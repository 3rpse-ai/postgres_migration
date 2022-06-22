import 'package:test/test.dart';

import 'integration_tests/postgresql_integration_tests.dart';
import 'unit_tests/unit_tests.dart';

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
