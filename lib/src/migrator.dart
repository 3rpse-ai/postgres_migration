import 'package:postgres/postgres.dart';

import 'columns/columns.dart';

class PostgreSQLMigrator {
  final PostgreSQLConnection connection;

  PostgreSQLMigrator(this.connection);

  Future<void> _initDB() async {
    if (connection.isClosed) {
      print("INIT DB CONNECTION");
      await connection.open();
      print("DB CONNECTION OPEN");
    }
  }

  Future<void> createTable(
      {required String tableName,
      required List<TableProperty> properties}) async {
    await _initDB();
    List<String> propertyStrings =
        properties.map((property) => property.sqlSnippet).toList();
    String query =
        "CREATE TABLE $tableName (\n${propertyStrings.join(", ")}\n);";

    print("postgres_migrator: $query");
    await connection.query(query);
  }

  Future<void> dropTable({required String tableName}) async {
    await _initDB();
    String query = "DROP TABLE $tableName;";
    await connection.query(query);
  }
}
