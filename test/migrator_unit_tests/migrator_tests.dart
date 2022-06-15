import 'package:test/test.dart';
import 'emun_migrator_unit_tests.dart';
import 'table_migrator_unit_tests.dart';

void executeMigratorUnitTests() {
  group("EnumMigrator //", executeEnumMigratorUnitTests);
  group("TableMigrator //", executeTableMigratorUnitTests);
}
