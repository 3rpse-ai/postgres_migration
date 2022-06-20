import 'package:test/test.dart';
import 'package:postgres_migration/postgres_migration.dart';
import 'test_data/column_data.dart';
import 'test_data/constraint_data.dart';

/// Collection of tests to run against DB
///
/// Tests only check for thrown exceptions (if accepted by DB), NOT for actual results in DB
void executeIntegrationTests(
  Future<dynamic> Function(String sqlStatement) callDB,
) {
  final migrator = TableMigrator('table_name');

  // Remove table after every run
  tearDown(() async => await callDB(migrator.removeTable(ifExists: true)));

  group('1. Create Table Columns //', () {
    // extract data from integration_test_data
    // creates a test per column type with respective use case
    for (int i = 0; i < columnTestData.entries.length; i++) {
      final columnCategory = columnTestData.entries.elementAt(i);
      for (int ii = 0; ii < columnCategory.value.entries.length; ii++) {
        final dataSet = columnCategory.value.entries.elementAt(ii);
        final categoryName = columnCategory.key;
        final categoryCount = i + 1;
        final dataSetname = dataSet.key;
        final dataSetCount = ii + 1;
        final testName =
            "$categoryCount. $categoryName // $dataSetCount. $dataSetname";
        test(testName, () async {
          final statement = migrator.createTable(dataSet.value);
          printOnFailure(statement);
          await callDB(statement);
          await callDB(migrator.removeTable());
        });
      }
    }
  });

  group('2. Create Table Constraints //', () {
    final ftMigrator = TableMigrator("foreign_table");
    setUp(() async => callDB(ftMigrator.createTable(foreignTableConstraintTestData)));
    tearDown(() async => callDB(ftMigrator.removeTable()));

    // extract data from integration_test_data
    // creates a test per column type with respective use case
    for (int i = 0; i < constraintTestData.entries.length; i++) {
      final constraintCategory = constraintTestData.entries.elementAt(i);
      final dataSet = constraintCategory.value;
      final categoryName = constraintCategory.key;
      final categoryCount = i + 1;
      final testName = "$categoryCount. $categoryName";

      test(testName, () async {
        final statement = migrator.createTable(dataSet);
        printOnFailure(statement);
        await callDB(statement);
        await callDB(migrator.removeTable());
      });
    }
  });

  group('3. Update Table //', () {
    final ftMigrator = TableMigrator("foreign_table");
    setUp(() async => callDB(ftMigrator.createTable(foreignTableConstraintTestData)));
    tearDown(() async => callDB(ftMigrator.removeTable()));

    // extract data from integration_test_data
    // creates a test per column type with respective use case
    for (int i = 0; i < constraintTestData.entries.length; i++) {
      final constraintCategory = constraintTestData.entries.elementAt(i);
      final dataSet = constraintCategory.value;
      final categoryName = constraintCategory.key;
      final categoryCount = i + 1;
      final testName = "$categoryCount. $categoryName";

      test(testName, () async {
        final statement = migrator.createTable(dataSet);
        printOnFailure(statement);
        await callDB(statement);
        await callDB(migrator.removeTable());
      });
    }
  });
}
