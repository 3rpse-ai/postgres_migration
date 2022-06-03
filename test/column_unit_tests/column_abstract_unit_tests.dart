import 'package:test/test.dart';
import 'package:postgres_migration/postgres_migration.dart';

class ColumnImplementation extends Column {
  @override
  String get type => 'column_type';

  ColumnImplementation(
    super.name, {
    super.checkConstraint,
    super.defaultValue,
    super.foreignKeyConstraint,
    super.foreignKeyForTable,
    super.isNullable,
    super.isPrimaryKey,
    super.isUnique,
    super.manualConstraint,
    super.manualDefaultValue,
    super.primaryKeyConstraint,
    super.uniqueConstraint,
  });
}

void executeColumnImplementationUnitTests() {
  test('1 TableProperty type inheritance', () {
    final column = ColumnImplementation('column_name');
    expect(column, isA<TableProperty>());
  });

  test('2 Minimal example', () {
    final column = ColumnImplementation('column_name');
    expect(column.sqlSnippet, equals('"column_name" column_type NOT NULL'));
  });

  test('3 Shorthand constraints', () {
    final column = ColumnImplementation('column_name',
        isNullable: true,
        isPrimaryKey: true,
        isUnique: true,
        foreignKeyForTable: "referenced_table");
    expect(
      column.sqlSnippet,
      equals(
        '"column_name" column_type PRIMARY KEY REFERENCES "referenced_table" UNIQUE',
      ),
    );
  });

  test('4 Detailed constraints', () {
    final column = ColumnImplementation(
      'column_name',
      checkConstraint: CheckConstraint(check: "check"),
      manualConstraint: ManualConstraint("manual_constraint"),
      primaryKeyConstraint:
          PrimaryKeyConstraint(name: "primary_key_constraint"),
      foreignKeyConstraint: ForeignKeyConstraint(
        referencedTable: "referenced_table",
        name: "foreign_key_constraint",
      ),
      uniqueConstraint: UniqueConstraint(name: "unique_constraint"),
    );
    expect(
      column.sqlSnippet,
      equals(
        '"column_name" column_type NOT NULL CONSTRAINT "primary_key_constraint" PRIMARY KEY CONSTRAINT "foreign_key_constraint" REFERENCES "referenced_table" CONSTRAINT "unique_constraint" UNIQUE CHECK(check) manual_constraint',
      ),
    );
  });

  test('5 Detailed vs shorthand constraints', () {
    final column = ColumnImplementation(
      'column_name',
      checkConstraint: CheckConstraint(check: "check"),
      manualConstraint: ManualConstraint("manual_constraint"),
      isNullable: true,
      isPrimaryKey: true,
      primaryKeyConstraint:
          PrimaryKeyConstraint(name: "primary_key_constraint"),
      foreignKeyForTable: "referenced_table",
      foreignKeyConstraint: ForeignKeyConstraint(
        referencedTable: "referenced_table",
        name: "foreign_key_constraint",
      ),
      isUnique: true,
      uniqueConstraint: UniqueConstraint(name: "unique_constraint"),
    );
    expect(
      column.sqlSnippet,
      equals(
        '"column_name" column_type CONSTRAINT "primary_key_constraint" PRIMARY KEY CONSTRAINT "foreign_key_constraint" REFERENCES "referenced_table" CONSTRAINT "unique_constraint" UNIQUE CHECK(check) manual_constraint',
      ),
    );
  });

  test('6 Default value', () {
    final column = ColumnImplementation(
      'column_name',
      // making sure toString method is called hence not providing string value here
      defaultValue: ColumnImplementation("test"),
    );
    expect(
      column.sqlSnippet,
      equals(
        '"column_name" column_type NOT NULL DEFAULT Instance of \'ColumnImplementation\'',
      ),
    );
  });

  test('7 Manual default value', () {
    final column = ColumnImplementation('column_name',
        manualDefaultValue: "manual_default");
    expect(
      column.sqlSnippet,
      equals(
        '"column_name" column_type NOT NULL DEFAULT manual_default',
      ),
    );
  });

  test('8 Manual default vs default value', () {
    final column = ColumnImplementation(
      'column_name',
      manualDefaultValue: "manual_default",
      defaultValue: "regular_default_value",
    );
    expect(
      column.sqlSnippet,
      equals(
        '"column_name" column_type NOT NULL DEFAULT manual_default',
      ),
    );
  });

  test('9 Default value with constraints', () {
    final column = ColumnImplementation(
      'column_name',
      checkConstraint: CheckConstraint(check: "check"),
      manualConstraint: ManualConstraint("manual_constraint"),
      primaryKeyConstraint:
          PrimaryKeyConstraint(name: "primary_key_constraint"),
      foreignKeyConstraint: ForeignKeyConstraint(
        referencedTable: "referenced_table",
        name: "foreign_key_constraint",
      ),
      uniqueConstraint: UniqueConstraint(name: "unique_constraint"),
      // making sure toString method is called hence not providing string value here
      defaultValue: ColumnImplementation("test"),
    );
    expect(
      column.sqlSnippet,
      equals(
        '"column_name" column_type NOT NULL CONSTRAINT "primary_key_constraint" PRIMARY KEY CONSTRAINT "foreign_key_constraint" REFERENCES "referenced_table" CONSTRAINT "unique_constraint" UNIQUE CHECK(check) manual_constraint DEFAULT Instance of \'ColumnImplementation\'',
      ),
    );
  });

  test('10 Maximum example', () {
    final column = ColumnImplementation(
      'column_name',
      checkConstraint: CheckConstraint(check: "check"),
      manualConstraint: ManualConstraint("manual_constraint"),
      isNullable: true,
      isPrimaryKey: true,
      primaryKeyConstraint:
          PrimaryKeyConstraint(name: "primary_key_constraint"),
      foreignKeyForTable: "referenced_table",
      foreignKeyConstraint: ForeignKeyConstraint(
        referencedTable: "referenced_table",
        name: "foreign_key_constraint",
      ),
      isUnique: true,
      uniqueConstraint: UniqueConstraint(name: "unique_constraint"),
      defaultValue: "default_value",
      manualDefaultValue: "manual_default",
    );
    expect(
      column.sqlSnippet,
      equals(
        '"column_name" column_type CONSTRAINT "primary_key_constraint" PRIMARY KEY CONSTRAINT "foreign_key_constraint" REFERENCES "referenced_table" CONSTRAINT "unique_constraint" UNIQUE CHECK(check) manual_constraint DEFAULT manual_default',
      ),
    );
  });
}
