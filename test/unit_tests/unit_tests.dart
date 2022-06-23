import 'package:test/test.dart';

import 'src/column_unit_tests/column_abstract_unit_tests.dart';
import 'src/column_unit_tests/column_implemenation_unit_tests.dart';
import 'src/constraint_unit_tests/constraint_unit_tests.dart';
import 'src/migrator_unit_tests/migrator_tests.dart';
import 'src/table_property/table_property_unit_tests.dart';

void executeUnitTests() {
  group('// 1. Column Abstract Class //', () {
    executeColumnAbstractClassUnitTests();
  });

  group('// 2. TableProperty', () {
    executeTablePropertyUnitTests();
  });

  group('// 3. Column Implementations //', () {
    executeColumnImplementationUnitTests();
  });

  group('// 4. Constraints //', () {
    executeConstraintUnitTests();
  });

  group('// 5. Migrators //', () {
    executeMigratorUnitTests();
  });
}
