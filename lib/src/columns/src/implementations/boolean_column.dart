import '../column.dart';

/// Column for storing a [bool]
class BooleanColumn extends Column<bool> {
  @override
  String get type => 'boolean';

  BooleanColumn(
    super.name, {
    super.isPrimaryKey = false,
    super.foreignKeyForTable,
    super.isUnique = false,
    super.isNullable = false,
    super.constraints,
    super.defaultValue,
    super.manualDefaultValue,
  });

  BooleanColumn.array(
    super.name, {
    super.isPrimaryKey = false,
    super.foreignKeyForTable,
    super.isUnique = false,
    super.isNullable = false,
    super.constraints,
    super.defaultArrayValue,
    super.manualDefaultValue,
  }) : super.array();
}
