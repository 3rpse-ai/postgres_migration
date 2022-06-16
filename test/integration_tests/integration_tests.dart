import 'package:test/test.dart';
import 'package:postgres_migration/postgres_migration.dart';

void executeIntegrationTests(
  Future<dynamic> Function(String sqlStatement) callDB,
) {
  final migrator = TableMigrator('table_name');

  // Remove table after every run
  tearDownAll(() async => await callDB(migrator.removeTable()));

  test('Create simple table', () async {
    final statement = migrator.createTable([]);
    await callDB(statement);
  });
}
