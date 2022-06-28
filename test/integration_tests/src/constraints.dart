import 'package:test/test.dart';
import 'package:db_migrator/db_migrator.dart';
import 'test_data/constraint_data.dart';

void executeConstraintIntegrationTests(
  TableMigrator migrator,
  Future<dynamic> Function(String sqlStatement) callDB,
) {
  final ftMigrator = TableMigrator("foreign_table");
  setUp(() async =>
      callDB(ftMigrator.createTable(foreignTableConstraintTestData)));
  tearDown(() async => callDB(ftMigrator.dropTable()));

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
      await callDB(migrator.dropTable());
    });
  }
}
