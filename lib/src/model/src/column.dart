import 'constraint.dart';
import 'table_property.dart';

abstract class Column implements TableProperty {
  String name;
  String get type;

  @override
  String get sqlSnippet => "\"$name\" $type$constraintsString";

  CheckConstraint? checkConstraint;

  ManualConstraint? manualConstraint;

  UniqueConstraint? uniqueConstraint;

  ForeignKeyConstraint? foreignKeyConstraint;

  PrimaryKeyConstraint? primaryKeyConstraint;

  /// Concatenated sql snippets of constraints
  String get constraintsString {
    String cString = "";

    if (primaryKeyConstraint != null) {
      cString = "$cString ${primaryKeyConstraint!.sqlSnippet}";
    }
    if (foreignKeyConstraint != null) {
      cString = "$cString ${foreignKeyConstraint!.sqlSnippet}";
    }

    if (uniqueConstraint != null) {
      cString = "$cString ${uniqueConstraint!.sqlSnippet}";
    }

    if (checkConstraint != null) {
      cString = "$cString ${checkConstraint!.sqlSnippet}";
    }
    if (manualConstraint != null) {
      cString = "$cString ${manualConstraint!.sqlSnippet}";
    }

    return cString;
  }

  /// Set this value to allow / prohibit null values. Defaults to not nullable.
  bool isNullable;

  /// Set this value to enforce the column using only unique values
  bool isUnique;

  /// Set this value to define the column as a primary key
  bool isPrimaryKey;

  /// Set this value with the referenced table's name to define the column as a foreign key
  String? foreignKeyForTable;

  /// possibility of inserting manual default statement
  ///
  /// adding e.g. an IntegerColumn called "count" with default="0" will result in an SQL query "count integer DEFAULT 0"
  String? manualDefault;

  String? defaultValue;

  Column(
    this.name, {
    this.isNullable = false,
    this.manualDefault,
    this.isPrimaryKey = false,
    this.isUnique = false,
    this.foreignKeyForTable,
    this.foreignKeyConstraint,
    this.checkConstraint,
    this.manualConstraint,
    this.primaryKeyConstraint,
    this.uniqueConstraint,
  });
}

class TextColumn extends Column {
  TextColumn(
    super.name, {
    super.manualDefault,
    super.checkConstraint,
    super.foreignKeyConstraint,
    super.foreignKeyForTable,
    super.isNullable,
    super.isPrimaryKey,
    super.isUnique,
    super.manualConstraint,
    super.primaryKeyConstraint,
    super.uniqueConstraint,
  });

  @override
  String get type => 'text';
}

class IntegerColumn extends Column {
  IntegerColumn(
    super.name, {
    super.manualDefault,
    super.checkConstraint,
    super.foreignKeyConstraint,
    super.foreignKeyForTable,
    super.isNullable,
    super.isPrimaryKey,
    super.isUnique,
    super.manualConstraint,
    super.primaryKeyConstraint,
    super.uniqueConstraint,
  });

  @override
  String get type => 'integer';
}
