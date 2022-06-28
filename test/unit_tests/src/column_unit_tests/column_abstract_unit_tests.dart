import 'package:test/test.dart';
import 'package:db_migrator/db_migrator.dart';

class ColumnImplementation extends Column {
  @override
  String get type => 'column_type';

  ColumnImplementation(
    super.name, {
    super.isPrimaryKey = false,
    super.foreignKeyForTable,
    super.isUnique = false,
    super.isNullable = false,
    super.constraints,
    super.defaultValue,
    super.manualDefaultValue,
    super.args,
    super.forceIncludeDefaultValue,
  });

  ColumnImplementation.array(
    super.name, {
    super.isPrimaryKey = false,
    super.foreignKeyForTable,
    super.isUnique = false,
    super.isNullable = false,
    super.constraints,
    super.defaultArrayValue,
    super.args,
  }) : super.array();
}

void executeColumnAbstractClassUnitTests() {
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
      constraints: ColumnConstraints(
        checkConstraint: CheckConstraint(check: "check"),
        manualConstraint: ManualConstraint("manual_constraint"),
        primaryKeyConstraint:
            PrimaryKeyConstraint(name: "primary_key_constraint"),
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "referenced_table",
          name: "foreign_key_constraint",
        ),
        uniqueConstraint: UniqueConstraint(name: "unique_constraint"),
      ),
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
      isNullable: true,
      isPrimaryKey: true,
      foreignKeyForTable: "referenced_table",
      isUnique: true,
      constraints: ColumnConstraints(
        checkConstraint: CheckConstraint(check: "check"),
        manualConstraint: ManualConstraint("manual_constraint"),
        primaryKeyConstraint:
            PrimaryKeyConstraint(name: "primary_key_constraint"),
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "referenced_table",
          name: "foreign_key_constraint",
        ),
        uniqueConstraint: UniqueConstraint(name: "unique_constraint"),
      ),
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
      constraints: ColumnConstraints(
        checkConstraint: CheckConstraint(check: "check"),
        manualConstraint: ManualConstraint("manual_constraint"),
        primaryKeyConstraint:
            PrimaryKeyConstraint(name: "primary_key_constraint"),
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "referenced_table",
          name: "foreign_key_constraint",
        ),
        uniqueConstraint: UniqueConstraint(name: "unique_constraint"),
      ),

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

  test('10 Maximum example w/o args', () {
    final column = ColumnImplementation(
      'column_name',
      constraints: ColumnConstraints(
        checkConstraint: CheckConstraint(check: "check"),
        manualConstraint: ManualConstraint("manual_constraint"),
        primaryKeyConstraint:
            PrimaryKeyConstraint(name: "primary_key_constraint"),
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "referenced_table",
          name: "foreign_key_constraint",
        ),
        uniqueConstraint: UniqueConstraint(name: "unique_constraint"),
      ),
      isNullable: true,
      isPrimaryKey: true,
      foreignKeyForTable: "referenced_table",
      isUnique: true,
      defaultValue: "default_value",
      manualDefaultValue: "manual_default",
      forceIncludeDefaultValue: true,
    );
    expect(
      column.sqlSnippet,
      equals(
        '"column_name" column_type CONSTRAINT "primary_key_constraint" PRIMARY KEY CONSTRAINT "foreign_key_constraint" REFERENCES "referenced_table" CONSTRAINT "unique_constraint" UNIQUE CHECK(check) manual_constraint DEFAULT manual_default',
      ),
    );
  });

  test('11 Args with maximum declaration test', () {
    final column = ColumnImplementation(
      'column_name',
      constraints: ColumnConstraints(
        checkConstraint: CheckConstraint(check: "check"),
        manualConstraint: ManualConstraint("manual_constraint"),
        primaryKeyConstraint:
            PrimaryKeyConstraint(name: "primary_key_constraint"),
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "referenced_table",
          name: "foreign_key_constraint",
        ),
        uniqueConstraint: UniqueConstraint(name: "unique_constraint"),
      ),
      isNullable: true,
      isPrimaryKey: true,
      foreignKeyForTable: "referenced_table",
      isUnique: true,
      defaultValue: "default_value",
      manualDefaultValue: "manual_default",
      args: "ARGS",
      forceIncludeDefaultValue: true,
    );
    expect(
      column.sqlSnippet,
      equals(
        '"column_name" column_type(ARGS) CONSTRAINT "primary_key_constraint" PRIMARY KEY CONSTRAINT "foreign_key_constraint" REFERENCES "referenced_table" CONSTRAINT "unique_constraint" UNIQUE CHECK(check) manual_constraint DEFAULT manual_default',
      ),
    );
  });

  test('12 Force include default value', () {
    final column =
        ColumnImplementation('column_name', forceIncludeDefaultValue: true);
    expect(
      column.sqlSnippet,
      equals(
        '"column_name" column_type NOT NULL DEFAULT null',
      ),
    );
  });

  test('13 Minimal array example', () {
    final column = ColumnImplementation.array('column_name');
    expect(
      column.sqlSnippet,
      equals(
        '"column_name" column_type[] NOT NULL',
      ),
    );
  });

  test('14 Array with default example', () {
    final column = ColumnImplementation.array('column_name',
        defaultArrayValue: ["default 1", "default 2", "default 3"]);
    expect(
      column.sqlSnippet,
      equals(
        '"column_name" column_type[] NOT NULL DEFAULT \'{default 1, default 2, default 3}\'',
      ),
    );
  });

  test('15 Array with default and args example', () {
    final column = ColumnImplementation.array('column_name',
        args: "args",
        defaultArrayValue: ["default 1", "default 2", "default 3"]);
    expect(
      column.sqlSnippet,
      equals(
        '"column_name" column_type(args)[] NOT NULL DEFAULT \'{default 1, default 2, default 3}\'',
      ),
    );
  });
}
