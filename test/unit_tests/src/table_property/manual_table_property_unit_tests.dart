import 'package:test/test.dart';

import 'package:db_migrator/db_migrator.dart';

void executeManualTablePropertyUnitTests() {
  test('1. Check Type', (() {
    final property = ManualTableProperty('My Table Property');
    expect(property, isA<TableProperty>());
  }));

  test('2. Check Output', (() {
    final property = ManualTableProperty('My Table Property');
    expect(property.sqlSnippet, "My Table Property");
  }));
}
