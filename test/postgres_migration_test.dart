import 'package:test/test.dart';

import 'column_unit_tests/column_abstract_unit_tests.dart';
import 'column_unit_tests/column_implemenation_unit_tests.dart';
import 'constraint_unit_tests.dart';
import 'migrator_unit_tests/migrator_tests.dart';

void main() {
  group('Unit Tests', () {
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
  });
}
