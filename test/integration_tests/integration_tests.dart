import 'package:test/test.dart';
import 'package:postgres_migration/postgres_migration.dart';

/// Collection of tests to run against DB
/// 
/// Tests only check for thrown exceptions (if accepted by DB), NOT for actual results in DB
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
