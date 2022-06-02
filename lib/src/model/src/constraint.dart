import 'table_property.dart';

/// Generic class for [Constraint]s.
///
/// *Constraints can be named which facilitates later migrations.*
abstract class Constraint {
  String? name;
  String get constraint;

  String get constraintWithName {
    return "CONSTRAINT \"$name\" $constraint";
  }

  String get fullConstraint {
    return name == null ? constraint : constraintWithName;
  }

  Constraint({this.name});
}

/// Possibility of inserting check constraint
///
/// Adding e.g. a CheckConstraint with `check="count<10"` will result in an added constraint of `CHECK (count < 10)`
class CheckConstraint extends Constraint implements TableProperty {
  String check;

  CheckConstraint({required this.check, super.name});

  @override
  String get constraint => "CHECK($check)";

  @override
  String get sqlSnippet => fullConstraint;
}

/// Class for defining `UNIQUE` constraints.
///
/// In case it should be created as a [TableProperty] the [columnNames] must be provided
///
/// *In case a single column should be marked as unique, without the need of naming the constraint, the `isUnique` flag of the [COLUMN] can be set.*
class UniqueConstraint extends Constraint implements TableProperty {
  List<String>? columnNames;

  UniqueConstraint({super.name, this.columnNames});

  @override
  String get constraint {
    final cleanColumnNames = columnNames?.map((name) => "\"$name\"").toList();

    // creates " (\"name1\", \"name2\", \"name3\")" if columnNames != null
    String? columnNamesAsString =
        cleanColumnNames != null ? " (${cleanColumnNames.join(", ")})" : null;

    return "UNIQUE${columnNamesAsString ?? ""}";
  }

  @override
  String get sqlSnippet => fullConstraint;
}

/// Class for defining any constraint.
///
/// Enter the desired constraint in plain SQL. E.g: `EXCLUDE USING gist (c with &&)`
///
/// Depending on the used context it will be either added as parameter or appended to the column declaration
class ManualConstraint extends Constraint implements TableProperty {
  String constraintString;
  ManualConstraint(this.constraintString);

  @override
  String get constraint => constraintString;

  @override
  String get sqlSnippet => constraintString;
}

/// Class for defining primary keys.
///
/// In case it should be created as a [TableProperty] the [columnNames] must be provided
///
/// *In case a single column should be marked as primary key without the need of naming the constraint, the `isPrimaryKey` flag of the column can be directly set.*
class PrimaryKeyConstraint extends Constraint implements TableProperty {
  List<String>? columnNames;

  PrimaryKeyConstraint({super.name, this.columnNames});

  @override
  String get constraint {
    final cleanColumnNames = columnNames?.map((name) => "\"$name\"").toList();

    // creates " (\"name1\", \"name2\", \"name3\")" if columnNames != null
    String? columnNamesAsString =
        cleanColumnNames != null ? " (${cleanColumnNames.join(", ")})" : null;
    // creates " (name1, name2, name3)" if columnNames != null
    return "PRIMARY KEY${columnNamesAsString ?? ""}";
  }

  @override
  String get sqlSnippet => fullConstraint;
}

/// Class for defining foreign keys.
///
/// In case the foreign key references a column marked as primary key the referencedColumn can be left blank
///
/// In case it should be created as a [TableProperty] use the [CombinedForeignKeyConstraint] instead.
///
/// *In case a single column should be marked as a foreign key the [foreignKeyForTable] property can be set if*
/// * *The column references a primary key*
/// * *No deletion or update mode needs to be defined*
/// * *No name for the foreign key constraints needs to be defined*
class ForeignKeyConstraint extends Constraint implements TableProperty {
  String? referencedColumn;
  String referencedTable;
  ForeignKeyDeletionMode deletionMode;
  ForeignKeyUpdateMode updateMode;

  ForeignKeyConstraint({
    super.name,
    this.referencedColumn,
    required this.referencedTable,
    this.deletionMode = ForeignKeyDeletionMode.undefined,
    this.updateMode = ForeignKeyUpdateMode.undefined,
  });

  @override
  String get constraint {
    String columnReference =
        referencedColumn != null ? " (\"${referencedColumn!}\")" : "";

    return "REFERENCES \"$referencedTable\"$columnReference${updateMode.sqlString}${deletionMode.sqlString}}";
  }

  @override
  String get sqlSnippet => fullConstraint;
}

/// Class for defining combined foreign keys.
///
/// Must only be used
///
/// The [columnNames] must be provided as a map in the format of:
/// ```{
///   "foreignKeyColumnName": "referencedColumnName"
/// }```
///
/// *In case a single column should be marked as a foreign key, use the [ForeignKeyConstraint] instead or define it via the column's `foreignKeyForTable` property.*
class CombinedForeignKeyConstraint extends Constraint implements TableProperty {
  Map<String, String> columnNames;
  String referencedTable;
  ForeignKeyDeletionMode deletionMode;
  ForeignKeyUpdateMode updateMode;

  CombinedForeignKeyConstraint({
    super.name,
    required this.referencedTable,
    required this.columnNames,
    this.deletionMode = ForeignKeyDeletionMode.undefined,
    this.updateMode = ForeignKeyUpdateMode.undefined,
  });

  @override
  String get constraint {
    List<String> keyColumns =
        columnNames.keys.map((column) => "\"$column\"").toList();
    List<String> referencedColumns =
        columnNames.values.map((column) => "\"$column\"").toList();

    String keyColumnsString = keyColumns.join(', ');
    String referencedColumnsString = referencedColumns.join(', ');

    return "FOREIGN KEY ($keyColumnsString) REFERENCES \"$referencedTable\" ($referencedColumnsString)${updateMode.sqlString}${deletionMode.sqlString}";
  }

  @override
  String get sqlSnippet => fullConstraint;
}

enum ForeignKeyDeletionMode {
  // Do not define any special deletion handling
  undefined(""),

  /// Sets foreignKey column to null on deletion of foreignObject
  setNull(" ON DELETE SET NULL"),

  /// Sets foreignKey column to default value on deletion of foreignObject
  setDefault(" ON DELETE SET DEFAULT"),

  /// Automatically deletes the referencing Object when foreignObject is deleted
  cascade(" ON DELETE CASCADE"),

  /// Same as restrict, but check happens at end of a transaction
  noAction(" ON DELETE NO ACTION"),

  /// Prevents deletion of a referenced row
  restrict(" ON DELETE RESTRICT");

  final String sqlString;
  const ForeignKeyDeletionMode(this.sqlString);
}

enum ForeignKeyUpdateMode {
  // Do not define any special update handling
  undefined(""),

  /// Sets foreignKey column to null on update of foreignObject
  setNull(" ON UPDATE SET NULL"),

  /// Sets foreignKey column to default value on update of foreignObject
  setDefault(" ON UPDATE SET DEFAULT"),

  /// Automatically updates the foreignKey value(s) when the referenced value(s) (e.g primary key) changes.
  cascade(" ON UPDATE CASCADE"),

  /// Same as restrict, but check happens at end of a transaction
  noAction(" ON UPDATE NO ACTION"),

  /// Prevents update of a referenced row
  restrict(" ON UPDATE RESTRICT");

  final String sqlString;
  const ForeignKeyUpdateMode(this.sqlString);
}
