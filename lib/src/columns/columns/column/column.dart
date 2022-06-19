import '../constraint.dart';
import '../table_property.dart';

export 'implementations/numeric_columns.dart';
export 'implementations/text_columns.dart';
export 'implementations/boolean_column.dart';
export 'implementations/date_time_columns.dart';
export 'implementations/enum_column.dart';
export 'implementations/uuid_column.dart';

abstract class Column<T> implements TableProperty {
  String name;
  String get type;

  bool isArray;

  /// Set this parameter to provide column arguments.
  /// E.g. type = "varchar", args = "9" results in varchar(9)
  String? args;

  String get typeWithArgs {
    String argsString = args != null ? "($args)" : "";
    String arrayString = isArray ? "[]" : "";
    return "$type$argsString$arrayString";
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
    String? defaultValueString;

    if (manualDefaultValue != null) {
      defaultValueString = manualDefaultValue;
    } else if (isArray) {
      if (defaultArrayValue != null) {
        final defaultValuesAsStrings = defaultArrayValue!
            .map((value) => convertArrayInputValueToString(value))
            .toList();
        defaultValueString = "'{${defaultValuesAsStrings.join(", ")}}'";
      }
    } else if (defaultValue != null || forceIncludeDefaultValue) {
      defaultValueString = defaultValueAsString;
    }
    return defaultValueString != null ? " DEFAULT $defaultValueString" : "";
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
  ///
  /// Be aware that some default values will require parantheses. This has to be included in the default.
  /// * E.g. `manualDefault: "'defaultWithParantheses'"`
  String? manualDefaultValue;

  /// Overwrite this getter to provide a column specific default value. Otherwise [convertInputValueToString] / [convertArrayInputValueToString]  is returned, which again defaults to `defaultValue.toString()`.
  String get defaultValueAsString => defaultValue != null
      ? isArray
          ? convertArrayInputValueToString(defaultValue as T)
          : convertInputValueToString(defaultValue as T)
      : defaultValue.toString();

  /// Used to define a default value. Results in sql snippet `DEFAULT $_defaultValue`.
  ///
  /// Override [defaultValueAsString] getter to transform value into an sql friendly string. Otherwise `defaultValue.toString()` will be inserted into sql query.
  final T? defaultValue;

  /// Converts data input to sql friendly string. Defaults to inputValue.toString(). Overwrite this method to e.g. support parantheses on around String inputs.
  String convertInputValueToString(T inputValue) {
    return inputValue.toString();
  }

  /// Converts data input to sql friendly string. Defaults to inputValue.toString(). Overwrite this method to e.g. support parantheses on around String inputs.
  String convertArrayInputValueToString(T inputValue) {
    return convertInputValueToString(inputValue);
  }

  /// Used to define a default value for Array Columns. Results in sql snippet `DEFAULT {$_defaultValue[0], $_defaultValue[1]}`.
  ///
  /// Override [convertInputValueToString] method to transform separate input values into an sql friendly string. Otherwise `inputValue.toString()` will be inserted into sql query.
  final List<T>? defaultArrayValue;

  /// Set this to true to enforce [defaultValueAsString] being included in [_defaultValueSnippet].
  ///
  /// In case [manualDefaultValue] is provided this flag is ignored.
  bool forceIncludeDefaultValue;

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
    this.forceIncludeDefaultValue = false,
  })  : isArray = false,
        defaultArrayValue = null;

  Column.array(
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
    this.defaultArrayValue,
    this.args,
  })  : isArray = true,
        forceIncludeDefaultValue = false,
        defaultValue = null;
}
