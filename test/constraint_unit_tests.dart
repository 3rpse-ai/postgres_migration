import 'package:postgres_migration/postgres_migration.dart';
import 'package:test/test.dart';

import 'package:postgres_migration/src/model/model.dart';

void executeConstraintUnitTests() {
  group('// 1. Constraints //', () {
    test('1.1.1 CheckConstraint type test', () {
      CheckConstraint check = CheckConstraint(check: "");
      expect(check, isA<Constraint>());
      expect(check, isA<TableProperty>());
    });

    test('1.1.2 CheckConstraint simple test', () {
      CheckConstraint checkConstraint = CheckConstraint(check: "i < 10");
      expect(checkConstraint.sqlSnippet, equals('CHECK(i < 10)'));
    });

    test('1.1.3 CheckConstraint with name test', () {
      CheckConstraint checkConstraint =
          CheckConstraint(check: "i < 10", name: "check_constraint");
      expect(checkConstraint.sqlSnippet,
          equals('CONSTRAINT "check_constraint" CHECK(i < 10)'));
    });

    test('1.2.1 UniqueConstraint type test', () {
      UniqueConstraint unique = UniqueConstraint();
      expect(unique, isA<Constraint>());
      expect(unique, isA<TableProperty>());
    });

    test('1.2.2 UniqueConstraint simple test', () {
      UniqueConstraint checkConstraint = UniqueConstraint();
      expect(checkConstraint.sqlSnippet, equals('UNIQUE'));
    });

    test('1.2.3 UniqueConstraint with name test', () {
      UniqueConstraint checkConstraint =
          UniqueConstraint(name: "unique_constraint");
      expect(checkConstraint.sqlSnippet,
          equals('CONSTRAINT "unique_constraint" UNIQUE'));
    });

    test('1.2.4 UniqueConstraint simple with single column test', () {
      UniqueConstraint checkConstraint =
          UniqueConstraint(columnNames: ["first_column"]);
      expect(checkConstraint.sqlSnippet, equals('UNIQUE ("first_column")'));
    });

    test('1.2.5 UniqueConstraint simple with multiples column test', () {
      UniqueConstraint checkConstraint = UniqueConstraint(
        columnNames: [
          "first_column",
          "second_column",
          "third_column",
        ],
      );
      expect(checkConstraint.sqlSnippet,
          equals('UNIQUE ("first_column", "second_column", "third_column")'));
    });

    test('1.2.6 UniqueConstraint with name & single column test', () {
      UniqueConstraint checkConstraint = UniqueConstraint(
          columnNames: ["first_column"], name: "unique_constraint");
      expect(checkConstraint.sqlSnippet,
          equals('CONSTRAINT "unique_constraint" UNIQUE ("first_column")'));
    });

    test('1.2.7 UniqueConstraint  with name & with multiple columns test', () {
      UniqueConstraint checkConstraint = UniqueConstraint(
        columnNames: [
          "first_column",
          "second_column",
          "third_column",
        ],
        name: "unique_constraint",
      );
      expect(
          checkConstraint.sqlSnippet,
          equals(
              'CONSTRAINT "unique_constraint" UNIQUE ("first_column", "second_column", "third_column")'));
    });

    test('1.3.1 ManualConstraint type test', () {
      expect(false, isTrue);
    });

    test('1.3.2 ManualConstraint simple test', () {
      expect(false, isTrue);
    });

    test('1.3.3 ManualConstraint with name test', () {
      expect(false, isTrue);
    });

    test('1.4.1 PrimaryKeyConstraint type test', () {
      expect(false, isTrue);
    });

    test('1.4.2 PrimaryKeyConstraint simple test', () {
      expect(false, isTrue);
    });

    test('1.4.3 PrimaryKeyConstraint simple with single column test', () {
      expect(false, isTrue);
    });

    test('1.4.4 PrimaryKeyConstraint simple with multiple columns test', () {
      expect(false, isTrue);
    });

    test('1.4.5 PrimaryKeyConstraint with name test', () {
      expect(false, isTrue);
    });

    test('1.4.6 PrimaryKeyConstraint with name & single column test', () {
      expect(false, isTrue);
    });

    test('1.4.7 PrimaryKeyConstraint with name & multiple columns test', () {
      expect(false, isTrue);
    });

    test('1.5.1 ForeignKeyConstraint type test', () {
      expect(false, isTrue);
    });

    test('1.5.2 ForeignKeyConstraint simple test', () {
      expect(false, isTrue);
    });

    test('1.5.3 ForeignKeyConstraint with name test', () {
      expect(false, isTrue);
    });

    test('1.5.4 ForeignKeyConstraint simple with updateMode test', () {
      expect(false, isTrue);
    });

    test('1.5.5 ForeignKeyConstraint with name & updateMode test', () {
      expect(false, isTrue);
    });

    test('1.5.6 ForeignKeyConstraint simple with deletionMode test', () {
      expect(false, isTrue);
    });

    test('1.5.7 ForeignKeyConstraint with name & deletionMode test', () {
      expect(false, isTrue);
    });

    test('1.5.8 ForeignKeyConstraint simple with referenced column test', () {
      expect(false, isTrue);
    });

    test('1.5.9 ForeignKeyConstraint with name & referenced column test', () {
      expect(false, isTrue);
    });

    test(
        '1.5.10 ForeignKeyConstraint simple with referenced column  & deletion mode test',
        () {
      expect(false, isTrue);
    });

    test(
        '1.5.11 ForeignKeyConstraint with name & referenced column & deletion mode test',
        () {
      expect(false, isTrue);
    });

    test(
        '1.5.12 ForeignKeyConstraint simple with referenced column  & update mode test',
        () {
      expect(false, isTrue);
    });

    test(
        '1.5.13 ForeignKeyConstraint with name & referenced column & update mode test',
        () {
      expect(false, isTrue);
    });

    test(
        '1.5.14 ForeignKeyConstraint simple with referenced column  & update mode & deletion mode test',
        () {
      expect(false, isTrue);
    });

    test(
        '1.5.15 ForeignKeyConstraint with name & referenced column & update mode & deletion mode test',
        () {
      expect(false, isTrue);
    });

    test('1.6.1 CombinedForeignKeyConstraint type test', () {
      expect(false, isTrue);
    });

    test('1.6.2 CombinedForeignKeyConstraint simple test', () {
      expect(false, isTrue);
    });

    test('1.6.3 CombinedForeignKeyConstraint with name test', () {
      expect(false, isTrue);
    });

    test('1.6.4 CombinedForeignKeyConstraint simple with updateMode test', () {
      expect(false, isTrue);
    });

    test('1.6.5 CombinedForeignKeyConstraint with name & updateMode test', () {
      expect(false, isTrue);
    });

    test('1.6.6 CombinedForeignKeyConstraint simple with deletionMode test',
        () {
      expect(false, isTrue);
    });

    test('1.6.7 CombinedForeignKeyConstraint with name & deletionMode test',
        () {
      expect(false, isTrue);
    });

    test(
        '1.6.8 CombinedForeignKeyConstraint simple with multiple referenced columns test',
        () {
      expect(false, isTrue);
    });

    test(
        '1.6.9 CombinedForeignKeyConstraint with name & multiple referenced columns test',
        () {
      expect(false, isTrue);
    });

    test(
        '1.6.10 CombinedForeignKeyConstraint simple with multiple referenced columns & deletion mode test',
        () {
      expect(false, isTrue);
    });

    test(
        '1.6.11 CombinedForeignKeyConstraint with name & multiple referenced columns & deletion mode test',
        () {
      expect(false, isTrue);
    });

    test(
        '1.6.12 CombinedForeignKeyConstraint simple with multiple referenced columns  & update mode test',
        () {
      expect(false, isTrue);
    });

    test(
        '1.6.13 CombinedForeignKeyConstraint with name & multiple referenced columns & update mode test',
        () {
      expect(false, isTrue);
    });

    test(
        '1.6.14 CombinedForeignKeyConstraint simple with multiple referenced columns & update mode & deletion mode test',
        () {
      expect(false, isTrue);
    });

    test(
        '1.6.15 CombinedForeignKeyConstraint with name & multiple referenced columns & update mode & deletion mode test',
        () {
      expect(false, isTrue);
    });

    test('1.7.1 ForeignKeyDeletionMode.setNull value check', () {
      expect(false, isTrue);
    });

    test('1.7.2 ForeignKeyDeletionMode.setDefault value check', () {
      expect(false, isTrue);
    });

    test('1.7.3 ForeignKeyDeletionMode.cascade value check', () {
      expect(false, isTrue);
    });

    test('1.7.4 ForeignKeyDeletionMode.restrict value check', () {
      expect(false, isTrue);
    });

    test('1.7.5 ForeignKeyDeletionMode.noAction value check', () {
      expect(false, isTrue);
    });

    test('1.7.6 ForeignKeyDeletionMode.undefined value check', () {
      expect(false, isTrue);
    });

    test('1.8.1 ForeignKeyUpdateMode.setNull value check', () {
      expect(false, isTrue);
    });

    test('1.8.2 ForeignKeyUpdateMode.setDefault value check', () {
      expect(false, isTrue);
    });

    test('1.8.3 ForeignKeyUpdateMode.cascade value check', () {
      expect(false, isTrue);
    });

    test('1.8.4 ForeignKeyUpdateMode.restrict value check', () {
      expect(false, isTrue);
    });

    test('1.8.5 ForeignKeyUpdateMode.noAction value check', () {
      expect(false, isTrue);
    });

    test('1.8.6 ForeignKeyUpdateMode.undefined value check', () {
      expect(false, isTrue);
    });
  });
}
