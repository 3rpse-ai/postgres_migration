import '../column.dart';

/// Column representing an enum
///
/// In order to work with enum columns, a respective enum type must be created beforehand
///
/// Use [EnumMigrator] and it's convenience methods for handling enums.
class EnumColumn<T extends Enum> extends Column<Enum> {
  /// Name of the enum type.
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
    super.isPrimaryKey = false,
    super.foreignKeyForTable,
    super.isUnique = false,
    super.isNullable = false,
    super.constraints,
    super.defaultValue,
    super.manualDefaultValue,
  });

  EnumColumn.array(
    super.name, {
    required this.enumName,
    super.isPrimaryKey = false,
    super.foreignKeyForTable,
    super.isUnique = false,
    super.isNullable = false,
    super.constraints,
    super.defaultArrayValue,
    super.manualDefaultValue,
  }) : super.array();
}
