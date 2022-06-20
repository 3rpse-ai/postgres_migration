import 'package:postgres_migration/postgres_migration.dart';
import 'package:test/test.dart';

void executeConstraintUnitTests() {
  test(
    '1.1 CheckConstraint type test',
    () {
      CheckConstraint check = CheckConstraint(check: "");
      expect(check, isA<Constraint>());
      expect(check, isA<TableProperty>());
    },
  );

  test(
    '1.2 CheckConstraint simple test',
    () {
      CheckConstraint checkConstraint = CheckConstraint(check: "i < 10");
      expect(checkConstraint.sqlSnippet, equals('CHECK(i < 10)'));
    },
  );

  test(
    '1.3 CheckConstraint with name test',
    () {
      CheckConstraint checkConstraint =
          CheckConstraint(check: "i < 10", name: "check_constraint");
      expect(checkConstraint.sqlSnippet,
          equals('CONSTRAINT "check_constraint" CHECK(i < 10)'));
    },
  );

  test(
    '2.1 UniqueConstraint type test',
    () {
      UniqueConstraint unique = UniqueConstraint();
      expect(unique, isA<Constraint>());
      expect(unique, isA<TableProperty>());
    },
  );

  test(
    '2.2 UniqueConstraint simple test',
    () {
      UniqueConstraint checkConstraint = UniqueConstraint();
      expect(checkConstraint.sqlSnippet, equals('UNIQUE'));
    },
  );

  test(
    '2.3 UniqueConstraint with name test',
    () {
      UniqueConstraint checkConstraint =
          UniqueConstraint(name: "unique_constraint");
      expect(checkConstraint.sqlSnippet,
          equals('CONSTRAINT "unique_constraint" UNIQUE'));
    },
  );

  test(
    '2.4 UniqueConstraint simple with single column test',
    () {
      UniqueConstraint checkConstraint =
          UniqueConstraint(columnNames: ["first_column"]);
      expect(checkConstraint.sqlSnippet, equals('UNIQUE ("first_column")'));
    },
  );

  test(
    '2.5 UniqueConstraint simple with multiples column test',
    () {
      UniqueConstraint checkConstraint = UniqueConstraint(
        columnNames: [
          "first_column",
          "second_column",
          "third_column",
        ],
      );
      expect(checkConstraint.sqlSnippet,
          equals('UNIQUE ("first_column", "second_column", "third_column")'));
    },
  );

  test(
    '2.6 UniqueConstraint with name & single column test',
    () {
      UniqueConstraint checkConstraint = UniqueConstraint(
          columnNames: ["first_column"], name: "unique_constraint");
      expect(checkConstraint.sqlSnippet,
          equals('CONSTRAINT "unique_constraint" UNIQUE ("first_column")'));
    },
  );

  test(
    '2.7 UniqueConstraint  with name & with multiple columns test',
    () {
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
    },
  );

  test(
    '3.1 ManualConstraint type test',
    () {
      ManualConstraint manual =
          ManualConstraint("EXCLUDE USING gist (c with &&)");
      expect(manual, isA<Constraint>());
      expect(manual, isA<TableProperty>());
    },
  );

  test(
    '3.2 ManualConstraint simple test',
    () {
      ManualConstraint manual =
          ManualConstraint("EXCLUDE USING gist (c with &&)");
      expect(manual.sqlSnippet, equals("EXCLUDE USING gist (c with &&)"));
    },
  );

  test(
    '3.3 ManualConstraint with name test',
    () {
      ManualConstraint manual =
          ManualConstraint("EXCLUDE USING gist (c with &&)");
      manual.name = 'manual_constraint';
      expect(manual.sqlSnippet, equals('EXCLUDE USING gist (c with &&)'));
    },
  );

  test(
    '4.1 PrimaryKeyConstraint type test',
    () {
      PrimaryKeyConstraint primary = PrimaryKeyConstraint();
      expect(primary, isA<Constraint>());
      expect(primary, isA<TableProperty>());
    },
  );

  test(
    '4.2 PrimaryKeyConstraint simple test',
    () {
      PrimaryKeyConstraint primary = PrimaryKeyConstraint();
      expect(primary.sqlSnippet, equals('PRIMARY KEY'));
    },
  );

  test(
    '4.3 PrimaryKeyConstraint simple with single column test',
    () {
      PrimaryKeyConstraint primary =
          PrimaryKeyConstraint(columnNames: ["first_column"]);
      expect(primary.sqlSnippet, equals('PRIMARY KEY ("first_column")'));
    },
  );

  test(
    '4.4 PrimaryKeyConstraint simple with multiple columns test',
    () {
      PrimaryKeyConstraint primary =
          PrimaryKeyConstraint(columnNames: ["first_column", "second_column"]);
      expect(primary.sqlSnippet,
          equals('PRIMARY KEY ("first_column", "second_column")'));
    },
  );

  test(
    '4.5 PrimaryKeyConstraint with name test',
    () {
      PrimaryKeyConstraint primary =
          PrimaryKeyConstraint(name: "primary_constraint");
      expect(primary.sqlSnippet,
          equals('CONSTRAINT "primary_constraint" PRIMARY KEY'));
    },
  );

  test(
    '4.6 PrimaryKeyConstraint with name & single column test',
    () {
      PrimaryKeyConstraint primary = PrimaryKeyConstraint(
          name: "primary_constraint", columnNames: ["first_column"]);
      expect(
          primary.sqlSnippet,
          equals(
              'CONSTRAINT "primary_constraint" PRIMARY KEY ("first_column")'));
    },
  );

  test(
    '4.7 PrimaryKeyConstraint with name & multiple columns test',
    () {
      PrimaryKeyConstraint primary = PrimaryKeyConstraint(
          name: "primary_constraint",
          columnNames: ["first_column", "second_column"]);
      expect(
          primary.sqlSnippet,
          equals(
              'CONSTRAINT "primary_constraint" PRIMARY KEY ("first_column", "second_column")'));
    },
  );

  test(
    '5.1 ForeignKeyConstraint type test',
    () {
      ForeignKeyConstraint foreign =
          ForeignKeyConstraint(referencedTable: "reference_table");
      expect(foreign, isA<Constraint>());
      expect(foreign, isA<TableProperty>());
    },
  );

  test(
    '5.2 ForeignKeyConstraint simple test',
    () {
      ForeignKeyConstraint foreign =
          ForeignKeyConstraint(referencedTable: "referenced_table");
      expect(foreign.sqlSnippet, equals('REFERENCES "referenced_table"'));
    },
  );

  test(
    '5.3 ForeignKeyConstraint with name test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint(
          referencedTable: "referenced_table", name: "foreign_constraint");
      expect(
          foreign.sqlSnippet,
          equals(
              'CONSTRAINT "foreign_constraint" REFERENCES "referenced_table"'));
    },
  );

  test(
    '5.4 ForeignKeyConstraint simple with updateMode test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint(
          referencedTable: "referenced_table",
          updateMode: ForeignKeyUpdateMode.noAction);
      expect(foreign.sqlSnippet,
          equals('REFERENCES "referenced_table" ON UPDATE NO ACTION'));
    },
  );

  test(
    '5.5 ForeignKeyConstraint with name & updateMode test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint(
          name: "foreign_constraint",
          referencedTable: "referenced_table",
          updateMode: ForeignKeyUpdateMode.noAction);
      expect(
          foreign.sqlSnippet,
          equals(
              'CONSTRAINT "foreign_constraint" REFERENCES "referenced_table" ON UPDATE NO ACTION'));
    },
  );

  test(
    '5.6 ForeignKeyConstraint simple with deletionMode test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint(
          referencedTable: "referenced_table",
          deletionMode: ForeignKeyDeletionMode.setDefault);
      expect(
        foreign.sqlSnippet,
        equals(
          'REFERENCES "referenced_table" ON DELETE SET DEFAULT',
        ),
      );
    },
  );

  test(
    '5.7 ForeignKeyConstraint with name & deletionMode test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint(
          name: "foreign_constraint",
          referencedTable: "referenced_table",
          deletionMode: ForeignKeyDeletionMode.setDefault);
      expect(
        foreign.sqlSnippet,
        equals(
          'CONSTRAINT "foreign_constraint" REFERENCES "referenced_table" ON DELETE SET DEFAULT',
        ),
      );
    },
  );

  test(
    '5.8 ForeignKeyConstraint simple with referenced column test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint(
        referencedTable: "referenced_table",
        referencedColumn: "referenced_column",
      );
      expect(
        foreign.sqlSnippet,
        equals(
          'REFERENCES "referenced_table" ("referenced_column")',
        ),
      );
    },
  );

  test(
    '5.9 ForeignKeyConstraint with name & referenced column test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint(
        name: "foreign_constraint",
        referencedTable: "referenced_table",
        referencedColumn: "referenced_column",
      );
      expect(
        foreign.sqlSnippet,
        equals(
          'CONSTRAINT "foreign_constraint" REFERENCES "referenced_table" ("referenced_column")',
        ),
      );
    },
  );

  test(
    '5.10 ForeignKeyConstraint simple with referenced column  & deletion mode test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint(
        referencedTable: "referenced_table",
        referencedColumn: "referenced_column",
        deletionMode: ForeignKeyDeletionMode.setNull,
      );
      expect(
        foreign.sqlSnippet,
        equals(
          'REFERENCES "referenced_table" ("referenced_column") ON DELETE SET NULL',
        ),
      );
    },
  );

  test(
    '5.11 ForeignKeyConstraint with name & referenced column & deletion mode test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint(
        name: "foreign_constraint",
        referencedTable: "referenced_table",
        referencedColumn: "referenced_column",
        deletionMode: ForeignKeyDeletionMode.setNull,
      );
      expect(
        foreign.sqlSnippet,
        equals(
          'CONSTRAINT "foreign_constraint" REFERENCES "referenced_table" ("referenced_column") ON DELETE SET NULL',
        ),
      );
    },
  );

  test(
    '5.12 ForeignKeyConstraint simple with referenced column  & update mode test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint(
        referencedTable: "referenced_table",
        referencedColumn: "referenced_column",
        updateMode: ForeignKeyUpdateMode.setNull,
      );
      expect(
        foreign.sqlSnippet,
        equals(
          'REFERENCES "referenced_table" ("referenced_column") ON UPDATE SET NULL',
        ),
      );
    },
  );

  test(
    '5.13 ForeignKeyConstraint with name & referenced column & update mode test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint(
        name: "foreign_constraint",
        referencedTable: "referenced_table",
        referencedColumn: "referenced_column",
        updateMode: ForeignKeyUpdateMode.setNull,
      );
      expect(
        foreign.sqlSnippet,
        equals(
          'CONSTRAINT "foreign_constraint" REFERENCES "referenced_table" ("referenced_column") ON UPDATE SET NULL',
        ),
      );
    },
  );

  test(
    '5.14 ForeignKeyConstraint simple with referenced column  & update mode & deletion mode test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint(
        referencedTable: "referenced_table",
        referencedColumn: "referenced_column",
        deletionMode: ForeignKeyDeletionMode.restrict,
        updateMode: ForeignKeyUpdateMode.setNull,
      );
      expect(
        foreign.sqlSnippet,
        equals(
          'REFERENCES "referenced_table" ("referenced_column") ON UPDATE SET NULL ON DELETE RESTRICT',
        ),
      );
    },
  );

  test(
    '5.15 ForeignKeyConstraint with name & referenced column & update mode & deletion mode test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint(
        name: "foreign_constraint",
        referencedTable: "referenced_table",
        referencedColumn: "referenced_column",
        deletionMode: ForeignKeyDeletionMode.restrict,
        updateMode: ForeignKeyUpdateMode.setNull,
      );
      expect(
        foreign.sqlSnippet,
        equals(
          'CONSTRAINT "foreign_constraint" REFERENCES "referenced_table" ("referenced_column") ON UPDATE SET NULL ON DELETE RESTRICT',
        ),
      );
    },
  );

  test(
    '5.16 ForeignKeyConstraint.tableProperty simple with referenced column & update mode & deletion mode test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint.tableProperty(
        foreignKeyColumn: "foreign_key_column",
        referencedTable: "referenced_table",
        referencedColumn: "referenced_column",
        deletionMode: ForeignKeyDeletionMode.restrict,
        updateMode: ForeignKeyUpdateMode.setNull,
      );
      expect(
        foreign.sqlSnippet,
        equals(
          'FOREIGN KEY ("foreign_key_column") REFERENCES "referenced_table" ("referenced_column") ON UPDATE SET NULL ON DELETE RESTRICT',
        ),
      );
    },
  );

  test(
    '5.17 ForeignKeyConstraint.tableProperty with name & referenced column & update mode & deletion mode test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint.tableProperty(
        name: "foreign_constraint",
        foreignKeyColumn: "foreign_key_column",
        referencedTable: "referenced_table",
        referencedColumn: "referenced_column",
        deletionMode: ForeignKeyDeletionMode.restrict,
        updateMode: ForeignKeyUpdateMode.setNull,
      );
      expect(
        foreign.sqlSnippet,
        equals(
          'CONSTRAINT "foreign_constraint" FOREIGN KEY ("foreign_key_column") REFERENCES "referenced_table" ("referenced_column") ON UPDATE SET NULL ON DELETE RESTRICT',
        ),
      );
    },
  );

  test(
    '5.18 ForeignKeyConstraint.multiColumn simple with single column & update mode & deletion mode test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint.multiColumn(
        columnNames: {'1_foreign_key': "1_referenced"},
        referencedTable: "referenced_table",
        deletionMode: ForeignKeyDeletionMode.restrict,
        updateMode: ForeignKeyUpdateMode.setNull,
      );
      expect(foreign.sqlSnippet,
          'FOREIGN KEY ("1_foreign_key") REFERENCES "referenced_table" ("1_referenced") ON UPDATE SET NULL ON DELETE RESTRICT');
    },
  );

  test(
    '5.19 ForeignKeyConstraint.multiColumn with name & multiple columns & update mode & deletion mode test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint.multiColumn(
        name: "foreign_constraint",
        columnNames: {'1_foreign_key': "1_referenced"},
        referencedTable: "referenced_table",
        deletionMode: ForeignKeyDeletionMode.restrict,
        updateMode: ForeignKeyUpdateMode.setNull,
      );
      expect(foreign.sqlSnippet,
          'CONSTRAINT "foreign_constraint" FOREIGN KEY ("1_foreign_key") REFERENCES "referenced_table" ("1_referenced") ON UPDATE SET NULL ON DELETE RESTRICT');
    },
  );

  test(
    '5.20 ForeignKeyConstraint.multiColumn with name & multiple columns test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint.multiColumn(
        name: "foreign_constraint",
        columnNames: {
          '1_foreign_key': "1_referenced",
          '2_foreign_key': "2_referenced",
        },
        referencedTable: "referenced_table",
      );
      expect(
        foreign.sqlSnippet,
        'CONSTRAINT "foreign_constraint" FOREIGN KEY ("1_foreign_key", "2_foreign_key") REFERENCES "referenced_table" ("1_referenced", "2_referenced")',
      );
    },
  );

  test(
    '5.21 ForeignKeyConstraint.multiColumn simple with multiple columns test',
    () {
      ForeignKeyConstraint foreign = ForeignKeyConstraint.multiColumn(
        columnNames: {
          '1_foreign_key': "1_referenced",
          '2_foreign_key': "2_referenced",
        },
        referencedTable: "referenced_table",
      );
      expect(
        foreign.sqlSnippet,
        'FOREIGN KEY ("1_foreign_key", "2_foreign_key") REFERENCES "referenced_table" ("1_referenced", "2_referenced")',
      );
    },
  );

  test(
    '6.1 ForeignKeyDeletionMode.setNull value check',
    () {
      expect(ForeignKeyDeletionMode.setNull.sqlString,
          equals(" ON DELETE SET NULL"));
    },
  );

  test(
    '6.2 ForeignKeyDeletionMode.setDefault value check',
    () {
      expect(ForeignKeyDeletionMode.setDefault.sqlString,
          equals(" ON DELETE SET DEFAULT"));
    },
  );

  test(
    '6.3 ForeignKeyDeletionMode.cascade value check',
    () {
      expect(ForeignKeyDeletionMode.cascade.sqlString,
          equals(" ON DELETE CASCADE"));
    },
  );

  test(
    '6.4 ForeignKeyDeletionMode.restrict value check',
    () {
      expect(ForeignKeyDeletionMode.restrict.sqlString,
          equals(" ON DELETE RESTRICT"));
    },
  );

  test(
    '6.5 ForeignKeyDeletionMode.noAction value check',
    () {
      expect(ForeignKeyDeletionMode.noAction.sqlString,
          equals(" ON DELETE NO ACTION"));
    },
  );

  test(
    '6.6 ForeignKeyDeletionMode.undefined value check',
    () {
      expect(ForeignKeyDeletionMode.undefined.sqlString, equals(""));
    },
  );

  test(
    '7.1 ForeignKeyUpdateMode.setNull value check',
    () {
      expect(ForeignKeyUpdateMode.setNull.sqlString,
          equals(" ON UPDATE SET NULL"));
    },
  );

  test(
    '7.2 ForeignKeyUpdateMode.setDefault value check',
    () {
      expect(ForeignKeyUpdateMode.setDefault.sqlString,
          equals(" ON UPDATE SET DEFAULT"));
    },
  );

  test(
    '7.3 ForeignKeyUpdateMode.cascade value check',
    () {
      expect(
          ForeignKeyUpdateMode.cascade.sqlString, equals(" ON UPDATE CASCADE"));
    },
  );

  test(
    '7.4 ForeignKeyUpdateMode.restrict value check',
    () {
      expect(ForeignKeyUpdateMode.restrict.sqlString,
          equals(" ON UPDATE RESTRICT"));
    },
  );

  test(
    '7.5 ForeignKeyUpdateMode.noAction value check',
    () {
      expect(ForeignKeyUpdateMode.noAction.sqlString,
          equals(" ON UPDATE NO ACTION"));
    },
  );

  test(
    '7.6 ForeignKeyUpdateMode.undefined value check',
    () {
      expect(ForeignKeyUpdateMode.undefined.sqlString, equals(""));
    },
  );
}
