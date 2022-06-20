import 'package:postgres_migration/postgres_migration.dart';

class TableMigrator {
  String tableName;

  String get _alterTable => "ALTER TABLE $tableName";

  String get _alterColumn => "$_alterTable ALTER COLUMN";

  /// Creates TableMigrator instance
  ///
  /// The tableName might need to be set in parantheses to avoid collision with certain keywords.
  TableMigrator(this.tableName);

  /// Returns SQL statement for creating a table with given properties
  ///
  /// Table properties are e.g. columns & constraints
  String createTable(List<TableProperty> properties) {
    List<String> propertyStrings =
        properties.map((property) => property.sqlSnippet).toList();
    return "CREATE TABLE $tableName (\n${propertyStrings.join(", ")}\n);";
  }

  /// Returns SQL statement for adding a column.
  String addColumn(Column column) =>
      "$_alterTable ADD COLUMN ${column.sqlSnippet};";

  /// Returns SQL statement for removing a column.
  ///
  /// All dat inside the column & constraints involving the column are dropped.
  ///
  /// In case the column is referenced by a foreign key constraint of another table an error would be raised by the DB.
  /// Dropping foreign constraints when deleting the column can be achieved via setting `cascading=true`
  String removeColumn(String columnName, {bool cascading = false}) =>
      "$_alterTable DROP COLUMN \"$columnName\"${cascading ? " CASCADE" : ""};";

  /// Adds a constraint to the table
  ///
  /// For altering constraints afterwards it is advised (though not enforced) to always provide a constraint name.
  ///
  /// Be aware that some constraints require a column name (or multiple) when not being declared with specific column. Those are:
  /// * [PrimaryKeyConstraint]
  /// * [UniqueConstraint]
  ///
  /// [ForeignKeyConstraint] needs a specific constructor to work as a TableProperty. Possible constructors are:
  /// * [ForeignKeyConstraint.tableProperty]
  /// * [ForeignKeyConstraint.multiColumn]
  String addConstraint(TableProperty constraint) =>
      "$_alterTable ADD ${constraint.sqlSnippet};";

  /// Adds a not null constraints for a specific column
  String addNotNullConstraint(String columnName) =>
      "$_alterColumn \"$columnName\" SET NOT NULL;";

  /// Removes a constraint from the table.
  String removeConstraint(String constraintName) =>
      "$_alterTable DROP CONSTRAINT $constraintName;";

  /// Removes a not null constraints for a specific column
  String removeNotNullConstraint(String columnName) =>
      "$_alterColumn \"$columnName\" DROP NOT NULL;";

  /// Removes a column's default value.
  ///
  /// This will effectively change the default NULL.
  String removeColumnDefaultValue(String columnName) =>
      "$_alterColumn \"$columnName\" DROP DEFAULT;";

  /// Changes a column's default value.
  ///
  /// This will only affect future inserts, not existing values within the column.
  ///
  /// It is sufficient to provide the columns name with the new default value. Other data will be ignored.
  String changeColumnDefaultValue(Column updatedColumn) =>
      "$_alterColumn \"${updatedColumn.name}\" SET DEFAULT ${updatedColumn.defaultValueAsString};";

  /// Changes a column's data type.
  ///
  /// In order to leverage the [Column] type safety, a column must be provided.
  ///
  /// Additionally `using` string can be provided for passing an expression how to cast the data to the new type.
  ///
  /// It is sufficient to provide the columns name + args (e.g. precision) where applicable. Other data will be ignored.
  String changeColumnDataType(Column updatedColumn, {String? using}) =>
      "$_alterColumn \"${updatedColumn.name}\" TYPE ${updatedColumn.typeWithArgs}${using != null ? " USING $using" : ""};";

  /// Renames a column.
  String renameColumn(String oldColumnName, String newColumnName) =>
      "$_alterTable RENAME COLUMN \"$oldColumnName\" TO \"$newColumnName\";";

  /// Renames a column.
  ///
  /// In order to allow subsequent statement creation via the migrator the [tableName] fields is updated with it.
  /// In case that is not desired set [updateTableNameInMigrator] to `false`.
  String renameTable(String newName, {updateTableNameInMigrator = true}) {
    String sqlSnippet = "$_alterTable RENAME TO $newName;";
    if (updateTableNameInMigrator) {
      tableName = newName;
    }
    return sqlSnippet;
  }

  /// Removes (DROP) the referenced table
  ///
  /// Use `mode` to specify what should happen if other tables depend on this table
  ///
  /// Use `ifExists` to not raise an expection if the table does not exist
  String removeTable({bool ifExists = false, TableDeletionMode? mode}) =>
      "DROP TABLE ${ifExists ? "IF EXISTS " : ""}$tableName${mode != null ? " ${mode.mode}" : ""};";
}

/// Choice of how table should be deleted
/// * Use cascade to automatically drop objects that depend on the table (such as views), and in turn all objects that depend on those objects
/// * Restrict is default. It leads to refusing to drop the table if any objects depend on it.
enum TableDeletionMode {
  /// Automatically drop objects that depend on the table (such as views), and in turn all objects that depend on those objects
  cascade('CASCADE'),

  /// Refuse to drop the table if any objects depend on it.
  restrict('RESTRICT');

  const TableDeletionMode(this.mode);

  final String mode;
}
