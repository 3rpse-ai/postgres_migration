import 'package:postgres_migration/postgres_migration.dart';

class TableMigrator {
  String tableName;

  String get _alterTable => "ALTER TABLE $tableName";

  String get _alterColumn => "$_alterTable ALTER COLUMN";

  TableMigrator(this.tableName);

  String createTable(List<TableProperty> properties) {
    List<String> propertyStrings =
        properties.map((property) => property.sqlSnippet).toList();
    return "CREATE TABLE $tableName (\n${propertyStrings.join(", ")}\n);";
  }

  String addColumn(Column column) =>
      "$_alterTable ADD COLUMN ${column.sqlSnippet};";

  String removeColumn(String columnName, {bool cascading = false}) =>
      "$_alterTable DROP COLUMN $columnName${cascading ? " CASCADE" : ""};";

  String addConstraint(TableProperty constraint) =>
      "$_alterTable ADD COLUMN ${constraint.sqlSnippet};";

  String addNotNullConstraint(String columnName) =>
      "$_alterColumn $columnName SET NOT NULL;";

  String removeConstraint(String constraintName) =>
      "$_alterTable DROP CONSTRAINT $constraintName;";

  String removeNotNullConstraint(String columnName) =>
      "$_alterColumn $columnName DROP NOT NULL;";

  String removeColumnDefaultValue(String columnName) =>
      "$_alterColumn $columnName DROP DEFAULT;";

  String changeColumnDefaultValue(Column updatedColumn) =>
      "$_alterColumn ${updatedColumn.name} SET DEFAULT ${updatedColumn.defaultValueAsString};";

  String changeColumnDataType(Column updatedColumn) =>
      "$_alterColumn ${updatedColumn.name} TYPE ${updatedColumn.typeWithArgs};";

  String renameColumn(String oldColumnName, String newColumnName) =>
      "$_alterTable RENAME COLUMN $oldColumnName TO $newColumnName;";

  String renameTable(String newName) {
    String sqlSnippet = "$_alterTable RENAME TO $newName;";
    tableName = newName;
    return sqlSnippet;
  }
}
