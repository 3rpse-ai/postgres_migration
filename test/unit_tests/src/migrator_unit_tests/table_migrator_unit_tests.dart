import 'package:test/test.dart';
import 'package:postgres_migration/postgres_migration.dart';

void executeTableMigratorUnitTests() {
  test('1. Create Table', () {
    final migrator = TableMigrator('table_name');
    final properties = [
      IntegerColumn("int_column"),
      ForeignKeyConstraint.tableProperty(
          referencedTable: "other_table", foreignKeyColumn: "int_column")
    ];
    final snippet = migrator.createTable(properties);

    expect(snippet,
        'CREATE TABLE table_name (\n"int_column" integer NOT NULL, FOREIGN KEY ("int_column") REFERENCES "other_table"\n);');
  });

  test('2. Add Column', () {
    final migrator = TableMigrator('table_name');
    final intColumn = IntegerColumn("int_column");
    final snippet = migrator.addColumn(intColumn);

    expect(snippet,
        'ALTER TABLE table_name ADD COLUMN "int_column" integer NOT NULL;');
  });

  test('3. Remove Column', () {
    final migrator = TableMigrator('table_name');
    final snippet = migrator.dropColumn("int_column");

    expect(snippet, 'ALTER TABLE table_name DROP COLUMN "int_column";');

    final snippet2 =
        migrator.dropColumn("int_column", mode: ColumnDropMode.cascade);

    expect(
      snippet2,
      'ALTER TABLE table_name DROP COLUMN "int_column" CASCADE;',
    );

    final snippet3 =
        migrator.dropColumn("int_column", mode: ColumnDropMode.restrict);

    expect(
      snippet3,
      'ALTER TABLE table_name DROP COLUMN "int_column" RESTRICT;',
    );
  });

  test('4. Add Constraint', () {
    final migrator = TableMigrator('table_name');
    final constraint =
        PrimaryKeyConstraint.tableProperty(columnNames: ["int_column"]);
    final snippet = migrator.addConstraint(constraint);

    expect(snippet, 'ALTER TABLE table_name ADD PRIMARY KEY ("int_column");');
  });

  test('5. Add NOT NULL Constraint', () {
    final migrator = TableMigrator('table_name');
    final snippet = migrator.addNotNullConstraint("int_column");

    expect(snippet,
        'ALTER TABLE table_name ALTER COLUMN "int_column" SET NOT NULL;');
  });

  test('6. Remove Constraint', () {
    final migrator = TableMigrator('table_name');
    final snippet = migrator.dropConstraint("constraint_name");

    expect(snippet, 'ALTER TABLE table_name DROP CONSTRAINT constraint_name;');
  });

  test('7. Remove NOT NULL Constraint', () {
    final migrator = TableMigrator('table_name');
    final snippet = migrator.dropNotNullConstraint("int_column");

    expect(snippet,
        'ALTER TABLE table_name ALTER COLUMN "int_column" DROP NOT NULL;');
  });

  test('8. Remove Column Default Value', () {
    final migrator = TableMigrator('table_name');
    final snippet = migrator.dropColumnDefaultValue("int_column");

    expect(snippet,
        'ALTER TABLE table_name ALTER COLUMN "int_column" DROP DEFAULT;');
  });

  test('9. Change Column Default Value', () {
    final migrator = TableMigrator('table_name');
    final intColumn = IntegerColumn("int_column", defaultValue: 1);
    final snippet = migrator.changeColumnDefaultValue(intColumn);

    expect(snippet,
        'ALTER TABLE table_name ALTER COLUMN "int_column" SET DEFAULT 1;');
  });

  test('10. Change Column Data Type', () {
    final migrator = TableMigrator('table_name');
    final numericColumn =
        NumericColumn("int_column", defaultValue: 1, precision: 4);
    final snippet1 = migrator.changeColumnDataType(numericColumn);
    final snippet2 =
        migrator.changeColumnDataType(numericColumn, using: "TEST EXP");

    expect(snippet1,
        'ALTER TABLE table_name ALTER COLUMN "int_column" TYPE numeric(4);');
    expect(snippet2,
        'ALTER TABLE table_name ALTER COLUMN "int_column" TYPE numeric(4) USING TEST EXP;');
  });

  test('11. Rename Column', () {
    final migrator = TableMigrator('table_name');
    final snippet = migrator.renameColumn("int_column", "numeric_column");

    expect(snippet,
        'ALTER TABLE table_name RENAME COLUMN "int_column" TO "numeric_column";');
  });

  test('12. Rename Table', () {
    final migrator = TableMigrator('table_name');
    final snippet = migrator.renameTable("new_table_name");

    expect(snippet, 'ALTER TABLE table_name RENAME TO new_table_name;');
    expect(migrator.tableName == "new_table_name", isTrue);
  });

  test('13. Rename Table No Update', () {
    final migrator = TableMigrator('table_name');
    final snippet = migrator.renameTable("new_table_name",
        updateTableNameInMigrator: false);
    expect(snippet, 'ALTER TABLE table_name RENAME TO new_table_name;');
    expect(migrator.tableName == "new_table_name", isFalse);
  });

  test('14. Remove Table', () {
    final migrator = TableMigrator('table_name');
    final snippet = migrator.dropTable();
    expect(snippet, 'DROP TABLE table_name;');
  });

  test('15. Remove Table if exists', () {
    final migrator = TableMigrator('table_name');
    final snippet = migrator.dropTable(ifExists: true);
    expect(snippet, 'DROP TABLE IF EXISTS table_name;');
  });

  test('16. Remove Table cascade', () {
    final migrator = TableMigrator('table_name');
    final snippet = migrator.dropTable(mode: TableDropMode.cascade);
    expect(snippet, 'DROP TABLE table_name CASCADE;');
  });

  test('17. Remove Table restrict', () {
    final migrator = TableMigrator('table_name');
    final snippet = migrator.dropTable(mode: TableDropMode.restrict);
    expect(snippet, 'DROP TABLE table_name RESTRICT;');
  });

  test('18. Remove Table if exists restrict', () {
    final migrator = TableMigrator('table_name');
    final snippet =
        migrator.dropTable(ifExists: true, mode: TableDropMode.restrict);
    expect(snippet, 'DROP TABLE IF EXISTS table_name RESTRICT;');
  });
}
