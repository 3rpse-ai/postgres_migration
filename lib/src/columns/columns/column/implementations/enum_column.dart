import '../column.dart';

/// Column representing an enum
///
/// In order to work with enum columns, a respective enum type must be created beforehand
///
/// Use [EnumMigrator] and it's convenience methods for handling enums.
class EnumColumn<T extends Enum> extends Column<Enum> {
  String enumName;

  @override
  String get type => enumName;

  @override
  String convertInputValueToString(Enum inputValue) {
    return "'${inputValue.name}'";
  }

  EnumColumn(
    super.name, {
    required this.enumName,
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

  EnumColumn.array(
    super.name, {
    required this.enumName,
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
