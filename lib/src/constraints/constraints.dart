import '../interfaces/table_property.dart';

/// Generic class for [Constraint]s.
///
/// *Constraints can be named which facilitates later migrations.*
abstract class Constraint {
  /// Define constraint name
  ///
  /// Results in following text being put before constraint `CONSTRAINT $name`
  String? name;

  /// Returns sql snippet without the name for this [Constraint]
  String get _constraintWithoutName;

  /// Returns sql snippet including the name for this [Constraint]. Name might be null.
  String get _constraintWithName {
    return "CONSTRAINT \"$name\" $_constraintWithoutName";
  }

  /// Returns final sql snippet for this [Constraint]
  String get constraint {
    return name == null ? _constraintWithoutName : _constraintWithName;
  }

  Constraint({this.name});
}

/// Possibility of inserting check constraint
///
/// By setting this constraint more complex checks comparing column value(s) can be defined.
///
/// Adding e.g. a CheckConstraint with `check="count<10"` will result in an added constraint of `CHECK (count < 10)`
class CheckConstraint extends Constraint implements TableProperty {
  String check;

  CheckConstraint({required this.check, super.name});

  @override
  String get _constraintWithoutName => "CHECK($check)";

  @override
  String get sqlSnippet => constraint;
}

/// Class for defining `UNIQUE` constraints.
///
/// After setting this constraint there must not be any duplicate values for a column
///
/// In case it should be created as a [TableProperty] the [columnNames] must be provided
///
/// *In case a single column should be marked as unique, without the need of naming the constraint, the `isUnique` flag of the [COLUMN] can be set.*
class UniqueConstraint extends Constraint implements TableProperty {
  /// Combination of columns which should be unique.
  List<String>? columnNames;

  UniqueConstraint({super.name, this.columnNames});

  @override
  String get _constraintWithoutName {
    final cleanColumnNames = columnNames?.map((name) => "\"$name\"").toList();

    // creates " (\"name1\", \"name2\", \"name3\")" if columnNames != null
    String? columnNamesAsString =
        cleanColumnNames != null ? " (${cleanColumnNames.join(", ")})" : null;

    return "UNIQUE${columnNamesAsString ?? ""}";
  }

  @override
  String get sqlSnippet => constraint;
}

/// Class for defining any constraint.
///
/// Enter the desired constraint in plain SQL. E.g: `EXCLUDE USING gist (c with &&)`
///
/// Depending on the used context it will be either added as parameter or appended to the column declaration
class ManualConstraint extends Constraint implements TableProperty {
  /// Enter the desired constraint in plain SQL. E.g: `EXCLUDE USING gist (c with &&)`
  String constraintString;
  ManualConstraint(this.constraintString);

  @override
  String get _constraintWithoutName => constraintString;

  @override
  String get sqlSnippet => constraintString;
}

/// Class for defining primary keys.
///
/// Defines a column / multiple columns as unqiue identifier of a row
///
/// In case it should be created as a [TableProperty] the [columnNames] must be provided
///
/// *In case a single column should be marked as primary key without the need of naming the constraint, the `isPrimaryKey` flag of the column can be directly set.*
class PrimaryKeyConstraint extends Constraint implements TableProperty {
  /// Combination of columns which should be unique & identify a row.
  List<String>? columnNames;

  PrimaryKeyConstraint({super.name, this.columnNames});

  @override
  String get _constraintWithoutName {
    final cleanColumnNames = columnNames?.map((name) => "\"$name\"").toList();

    // creates " (\"name1\", \"name2\", \"name3\")" if columnNames != null
    String? columnNamesAsString =
        cleanColumnNames != null ? " (${cleanColumnNames.join(", ")})" : null;
    // creates " (name1, name2, name3)" if columnNames != null
    return "PRIMARY KEY${columnNamesAsString ?? ""}";
  }

  @override
  String get sqlSnippet => constraint;
}

/// Class for defining foreign keys.
///
/// In case the foreign key references a column marked as primary key the referencedColumn can be left blank
///
/// In case it should be created as a [TableProperty] use the [ForeignKeyConstraint.tableProperty] constructor instead.
///
/// In case multiple columns should be combined to be a foreign key use the [ForeignKeyConstraint.multiColumn] constructor instead. If this constructor is used only usage as [TableProperty] is allowed by the DB.
///
/// *In case a single column should be marked as a foreign key the [foreignKeyForTable] property can be set if*
/// * *The column references a primary key*
/// * *No deletion or update mode needs to be defined*
/// * *No name for the foreign key constraints needs to be defined*
class ForeignKeyConstraint extends Constraint implements TableProperty {
  /// Specify the column referenced by the foreingKey. Defaults to the [referencedTable]'s primary key
  String? referencedColumn;

  /// The referenced table
  String referencedTable;

  /// How table referencing table rows should be treated on deleting referenced objects.
  ForeignKeyDeletionMode deletionMode;

  /// How table referencing table rows should be treated on opdating referenced objects.
  ForeignKeyUpdateMode updateMode;

  /// Needed to provide correct syntax if not used inline with column.
  bool _isTableProperty = false;

  /// Needed to provide correct syntax if used as [TableProperty] with (multiple) specified column(s).
  bool _isMultiColumn = false;

  /// Needed to be specified if used as [TableProperty] when not used for single column.
  String foreignKeyColumn = "";

  /// Needed to be specified if used as [TableProperty] for multiple columns.
  Map<String, String> columnNames = {};

  /// Constructor for creating foreign keys as inline [Constraint].
  ///
  /// Results in sql snippet like e.g. `REFERENCES product_groups`
  ForeignKeyConstraint({
    super.name,
    this.referencedColumn,
    required this.referencedTable,
    this.deletionMode = ForeignKeyDeletionMode.undefined,
    this.updateMode = ForeignKeyUpdateMode.undefined,
  });

  /// Constructor for defining foreign keys as [TableProperty].
  ///
  /// Results in sql snippet like e.g. `FOREIGN KEY (product_group_id) REFERENCES product_groups`
  ForeignKeyConstraint.tableProperty({
    super.name,
    this.referencedColumn,
    required this.referencedTable,
    this.deletionMode = ForeignKeyDeletionMode.undefined,
    this.updateMode = ForeignKeyUpdateMode.undefined,
    required this.foreignKeyColumn,
  }) : _isTableProperty = true;

  /// Constructor for defining multiColumn foreign keys.
  ///
  /// Only to be used as [TableProperty]
  ///
  /// The [columnNames] must be provided as a map in the format of:
  /// ```{
  ///   "foreignKeyColumnName": "referencedColumnName"
  /// }```
  ///
  /// Results in sql snippet like e.g. `FOREIGN KEY (b, c) REFERENCES other_table (c1, c2)`
  ForeignKeyConstraint.multiColumn({
    super.name,
    required this.referencedTable,
    this.deletionMode = ForeignKeyDeletionMode.undefined,
    this.updateMode = ForeignKeyUpdateMode.undefined,
    required this.columnNames,
  })  : _isTableProperty = true,
        _isMultiColumn = true;

  @override
  String get _constraintWithoutName {
    String columnReference =
        referencedColumn != null ? " (\"${referencedColumn!}\")" : "";
    String tablePropertySnippet =
        _isTableProperty ? "FOREIGN KEY (\"$foreignKeyColumn\") " : "";
    if (!_isMultiColumn) {
      return "${tablePropertySnippet}REFERENCES \"$referencedTable\"$columnReference${updateMode.sqlString}${deletionMode.sqlString}";
    } else {
      List<String> keyColumns =
          columnNames.keys.map((column) => "\"$column\"").toList();
      List<String> referencedColumns =
          columnNames.values.map((column) => "\"$column\"").toList();

      String keyColumnsString = keyColumns.join(', ');
      String referencedColumnsString = referencedColumns.join(', ');

      return "FOREIGN KEY ($keyColumnsString) REFERENCES \"$referencedTable\" ($referencedColumnsString)${updateMode.sqlString}${deletionMode.sqlString}";
    }
  }

  @override
  String get sqlSnippet => constraint;
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
