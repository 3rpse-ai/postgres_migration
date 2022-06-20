import 'package:postgres_migration/postgres_migration.dart';

final updateTableForeignTableTestData = [
  SerialColumn("ft_serial_column", isPrimaryKey: true),
  TextColumn("ft_text_column"),
  IntegerColumn("ft_integer_column", isUnique: true),
  UniqueConstraint(columnNames: ["ft_integer_column", "ft_text_column"])
];

final updateTableMainTableTestData = [
  SerialColumn("main_serial_column"),
  TextColumn("main_text_column", isUnique: true),
  DateColumn("main_date_column", isNullable: true),
  IntegerColumn("main_integer_column", foreignKeyForTable: "foreign_table"),
];

final List<TableProperty> updateTableConstraintTestData = [
  PrimaryKeyConstraint(
    name: "primary_key",
    columnNames: ['main_serial_column'],
  ),
  PrimaryKeyConstraint(
    name: "primary_key",
    columnNames: [
      'main_serial_column',
      'main_text_column',
    ],
  ),
  UniqueConstraint(
    name: "unique_constraint",
    columnNames: ['main_date_column'],
  ),
  UniqueConstraint(name: "unique_constraint", columnNames: [
    'main_serial_column',
    'main_date_column',
  ]),
  CheckConstraint(check: "main_integer_column < main_serial_column"),
  ForeignKeyConstraint.tableProperty(
    foreignKeyColumn: "main_integer_column",
    referencedTable: "foreign_table",
  ),
  ForeignKeyConstraint.multiColumn(
    columnNames: {
      "main_integer_column": "ft_integer_column",
    },
    referencedTable: "foreign_table",
  ),
];
