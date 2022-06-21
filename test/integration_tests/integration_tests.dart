import 'package:test/test.dart';
import 'package:postgres_migration/postgres_migration.dart';
import 'src/columns.dart';
import 'src/constraints.dart';
import 'src/enums.dart';
import 'src/table_updates.dart';

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
    executeColumnIntegrationTests(migrator, callDB);
  });

  group('2. Create Table Constraints //', () {
    executeConstraintIntegrationTests(migrator, callDB);
  });

  group('3. Update Table //', () {
    executeTableUpdateIntegrationTests(migrator, callDB);
  });

  group('4. Enum // ', () {
    executeEnumIntegrationTests(migrator, callDB);
  });
}
