import '../constraint.dart';
import '../table_property.dart';

export 'numeric_columns.dart';

abstract class Column<T> implements TableProperty {
  String name;
  String get type;
  String? args;

  String get typeWithArgs {
    String argsString = args != null ? "($args)" : "";
    return "$type$argsString";
  }

  @override
  String get sqlSnippet =>
      "\"$name\" $typeWithArgs$_constraintsSnippet$_defaultValueSnippet";

  /// Used to set check constraint.
  CheckConstraint? checkConstraint;

  /// Used to set manual constraint. Allows for freely defining any constraint.
  ManualConstraint? manualConstraint;

  /// Used to set unique constraint. If value is provided [isUnique] flag is ignored.
  UniqueConstraint? uniqueConstraint;

  /// Used to set foreign key constraint. If value is provided [foreignKeyForTable] shorthand is ignored.
  ForeignKeyConstraint? foreignKeyConstraint;

  /// Used to set primary key constraint. If value is provided [isPrimaryKey] flag is ignored.
  PrimaryKeyConstraint? primaryKeyConstraint;

  /// Internal property for retrieving check constraint
  CheckConstraint? get _checkConstraint => checkConstraint;

  /// Internal property for retrieving manual constraint
  ManualConstraint? get _manualConstraint => manualConstraint;

  /// Internal property for retrieving unique constraint.
  ///
  /// Returns default [UniqueConstraint] if is [isUnique]is set and [uniqueConstraint] is null.
  UniqueConstraint? get _uniqueConstraint {
    return uniqueConstraint ?? (isUnique ? UniqueConstraint() : null);
  }

  /// Internal property for retrieving foreign key constraint.
  ///
  /// Returns default [ForeignKeyConstraint] if [foreignKeyForTable]is set and [foreignKeyConstraint] is null.
  ForeignKeyConstraint? get _foreignKeyConstraint {
    return foreignKeyConstraint ??
        (foreignKeyForTable != null
            ? ForeignKeyConstraint(referencedTable: foreignKeyForTable!)
            : null);
  }

  /// Internal property for retrieving primary key constraint.
  ///
  /// Returns default [PrimaryKeyConstraint] if is [isPrimaryKey]is set and [primaryKeyConstraint] is null.
  PrimaryKeyConstraint? get _primaryKeyConstraint {
    return primaryKeyConstraint ??
        (isPrimaryKey ? PrimaryKeyConstraint() : null);
  }

  /// Concatenated sql snippets of constraints
  String get _constraintsSnippet {
    String cString = "";

    if (!isNullable) {
      cString = "$cString NOT NULL";
    }

    if (_primaryKeyConstraint != null) {
      cString = "$cString ${_primaryKeyConstraint!.sqlSnippet}";
    }
    if (_foreignKeyConstraint != null) {
      cString = "$cString ${_foreignKeyConstraint!.sqlSnippet}";
    }

    if (_uniqueConstraint != null) {
      cString = "$cString ${_uniqueConstraint!.sqlSnippet}";
    }

    if (_checkConstraint != null) {
      cString = "$cString ${_checkConstraint!.sqlSnippet}";
    }
    if (_manualConstraint != null) {
      cString = "$cString ${_manualConstraint!.sqlSnippet}";
    }

    return cString;
  }

  String get _defaultValueSnippet {
    String? manualOverDefaultString = manualDefaultValue ??
        (defaultValue != null ? defaultValueAsString : null);
    return manualOverDefaultString != null
        ? " DEFAULT $manualOverDefaultString"
        : "";
  }

  /// Set this value to allow / prohibit null values. Defaults to not nullable.
  bool isNullable;

  /// Set this value to enforce the column using only unique values
  ///
  /// If [uniqueConstraint] is provided this flag is ignored.
  bool isUnique;

  /// Set this value to define the column as a primary key
  ///
  /// If [primaryKeyConstraint] is provided this flag is ignored.
  bool isPrimaryKey;

  /// Set this value with the referenced table's name to define the column as a foreign key
  ///
  /// If [foreignKeyConstraint] is provided this input is ignored.
  String? foreignKeyForTable;

  /// Possibility of inserting manual default statement
  ///
  /// Adding e.g. an IntegerColumn called "count" with default="0" will result in an SQL query "count integer DEFAULT 0"
  ///
  /// Always takes precedence over [defaultValue]
  String? manualDefaultValue;

  /// Overwrite this getter to provide a column specific default value. Otherwise `defaultValue.toString()` is returned.
  String get defaultValueAsString => defaultValue.toString();

  /// Used to define a default value. Results in sql snippet `DEFAULT $_defaultValue`.
  ///
  /// Override _defaultValueAsString getter to transform value into an sql friendly string. Otherwise `defaultValue.toString()` will be inserted into sql query.
  final T? defaultValue;

  Column(
    this.name, {
    this.isNullable = false,
    this.manualDefaultValue,
    this.isPrimaryKey = false,
    this.isUnique = false,
    this.foreignKeyForTable,
    this.foreignKeyConstraint,
    this.checkConstraint,
    this.manualConstraint,
    this.primaryKeyConstraint,
    this.uniqueConstraint,
    this.defaultValue,
    this.args,
  });
}
