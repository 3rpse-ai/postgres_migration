import '../column.dart';

/// Column for storing a [String] of any length
class TextColumn extends Column<String> {
  @override
  String get type => 'text';

  @override
  String convertInputValueToString(String inputValue) {
    return "'$inputValue'";
  }

  TextColumn(
    super.name, {
    super.isNullable = false,
    super.manualDefaultValue,
    super.isPrimaryKey = false,
    super.isUnique = false,
    super.foreignKeyForTable,
    super.foreignKeyConstraint,
    super.checkConstraint,
    super.manualConstraint,
    super.primaryKeyConstraint,
    super.uniqueConstraint,
    super.defaultValue,
  });

  TextColumn.array(
    super.name, {
    super.isNullable = false,
    super.manualDefaultValue,
    super.isPrimaryKey = false,
    super.isUnique = false,
    super.foreignKeyForTable,
    super.foreignKeyConstraint,
    super.checkConstraint,
    super.manualConstraint,
    super.primaryKeyConstraint,
    super.uniqueConstraint,
    super.defaultArrayValue,
  }) : super.array();
}

/// Column for storing String of variable length with optional maximum.
///
/// In case no [length] is provided, the column is effectively equal to using a text column.
///
/// An attempt to store a longer [String] than [maxLength] will result in an error (except if the overflowing characters are only spaces, in which case they will be trimmed). An attempt to store a shorter string will be accepted as opposed to [CharColumn].
class VarcharColumn extends Column<String> {
  @override
  String get type => "varchar";

  @override
  String convertInputValueToString(String inputValue) {
    return "'$inputValue'";
  }

  VarcharColumn(
    super.name, {
    int? maxLength,
    super.isNullable = false,
    super.manualDefaultValue,
    super.isPrimaryKey = false,
    super.isUnique = false,
    super.foreignKeyForTable,
    super.foreignKeyConstraint,
    super.checkConstraint,
    super.manualConstraint,
    super.primaryKeyConstraint,
    super.uniqueConstraint,
    super.defaultValue,
  }) : super(args: maxLength?.toString());

  VarcharColumn.array(
    super.name, {
    int? maxLength,
    super.isNullable = false,
    super.manualDefaultValue,
    super.isPrimaryKey = false,
    super.isUnique = false,
    super.foreignKeyForTable,
    super.foreignKeyConstraint,
    super.checkConstraint,
    super.manualConstraint,
    super.primaryKeyConstraint,
    super.uniqueConstraint,
    super.defaultArrayValue,
  }) : super.array(args: maxLength?.toString());
}

/// Column for storing String of defined length.
///
/// In case no [length] is provided, postgres defaults to a length of 1.
///
/// An attempt to store a longer [String] will result in an error (except if the overflowing characters are only spaces, in which case they will be trimmed). An attempt to store a shorter string will lead to the [String] being space-padded.
class CharColumn extends Column<String> {
  @override
  String get type => "char";

  @override
  String convertInputValueToString(String inputValue) {
    return "'$inputValue'";
  }

  CharColumn(
    super.name, {
    int? length,
    super.isNullable = false,
    super.manualDefaultValue,
    super.isPrimaryKey = false,
    super.isUnique = false,
    super.foreignKeyForTable,
    super.foreignKeyConstraint,
    super.checkConstraint,
    super.manualConstraint,
    super.primaryKeyConstraint,
    super.uniqueConstraint,
    super.defaultValue,
  }) : super(args: length?.toString());

  CharColumn.array(
    super.name, {
    int? length,
    super.isNullable = false,
    super.manualDefaultValue,
    super.isPrimaryKey = false,
    super.isUnique = false,
    super.foreignKeyForTable,
    super.foreignKeyConstraint,
    super.checkConstraint,
    super.manualConstraint,
    super.primaryKeyConstraint,
    super.uniqueConstraint,
    super.defaultArrayValue,
  }) : super.array(args: length?.toString());
}
