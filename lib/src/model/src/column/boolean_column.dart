import 'column.dart';

/// Column for storing a [String] of any length
class BooleanColumn extends Column<bool> {
  @override
  String get type => 'boolean';
  
  BooleanColumn(
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
}
