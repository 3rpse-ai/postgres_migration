import 'package:test/test.dart';
import 'package:postgres_migration/postgres_migration.dart';
import './integration_test_data.dart';

/// Collection of tests to run against DB
///
/// Tests only check for thrown exceptions (if accepted by DB), NOT for actual results in DB
void executeIntegrationTests(
  Future<dynamic> Function(String sqlStatement) callDB,
) {
  final migrator = TableMigrator('table_name');

  // Remove table after every run
  tearDown(() async => await callDB(migrator.removeTable(ifExists: true)));

  group('1. Create Table //', () {
    test('1. Simple table', () async {
      final statement = migrator.createTable([]);
      await callDB(statement);
    });

    test('2. Test numeric columns', () async {
      for (final dataSet in numericColumns.values) {
        final statement = migrator.createTable(dataSet);
        await callDB(statement);
        await callDB(migrator.removeTable());
      }
    });

    test('3. Test text columns', () async {
      for (final dataSet in textColumns.values) {
        final statement = migrator.createTable(dataSet);
        await callDB(statement);
        await callDB(migrator.removeTable());
      }
    });

    test('4. Test boolean columns', () async {
      for (final dataSet in booleanColumns.values) {
        final statement = migrator.createTable(dataSet);
        await callDB(statement);
        await callDB(migrator.removeTable());
      }
    });

    test('5. Test uuid columns', () async {
      for (final dataSet in uuidColumns.values) {
        final statement = migrator.createTable(dataSet);
        await callDB(statement);
        await callDB(migrator.removeTable());
      }
    });

    test('6. Test datetime columns', () async {
      for (final dataSet in dateTimeColumns.values) {
        final statement = migrator.createTable(dataSet);
        await callDB(statement);
        await callDB(migrator.removeTable());
      }
    });
  });
}
