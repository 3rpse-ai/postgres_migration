import 'package:test/test.dart';

import 'src/column_unit_tests/column_abstract_unit_tests.dart';
import 'src/column_unit_tests/column_implemenation_unit_tests.dart';
import 'src/constraint_unit_tests/constraint_unit_tests.dart';
import 'src/migrator_unit_tests/migrator_tests.dart';

void executeUnitTests() {
  group('// 1. Constraints //', () {
    executeConstraintUnitTests();
  });
  group('// 2. Column Abstract Class //', () {
    executeColumnAbstractClassUnitTests();
  });

  group('// 3. Column Implementations //', () {
    executeColumnImplementationUnitTests();
  });

  group('// 4. Migrators //', () {
    executeMigratorUnitTests();
  });
}
