import 'package:test/test.dart';

import 'integration_tests/postgresql_integration_tests.dart';
import 'unit_tests/unit_tests.dart';

// HOW TO CREATE CODE COVERAGE REPORT:
// -----------------------------------
// Generate `coverage/lcov.info` file:
// - flutter test --coverage
// Generate HTML report (on macOS you need to have lcov installed on your system (`brew install lcov`))
// - genhtml coverage/lcov.info -o coverage/html
// Open the report
// - open coverage/html/index.html

void main() {
  group('Unit Tests', () {
    executeUnitTests();
  });

  group('Integration Tests', () {
    group('// 1. PostgreSQL //', () {
      executePostgreSQLIntegrationTests();
    });
  });
}
