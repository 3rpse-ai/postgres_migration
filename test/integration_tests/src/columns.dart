import 'package:test/test.dart';
import 'package:db_migrator/db_migrator.dart';
import 'test_data/column_data.dart';

void executeColumnIntegrationTests(
  TableMigrator migrator,
  Future<dynamic> Function(String sqlStatement) callDB,
) {
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
        await callDB(migrator.dropTable());
      });
    }
  }
}
