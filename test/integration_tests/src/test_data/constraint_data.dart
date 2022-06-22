import 'package:postgres_migration/postgres_migration.dart';

final foreignTableConstraintTestData = [
  SerialColumn("ft_serial_column", isPrimaryKey: true),
  TextColumn("ft_text_column"),
  IntegerColumn("ft_integer_column", isUnique: true),
  UniqueConstraint(columnNames: ["ft_integer_column", "ft_text_column"])
];

final Map<String, List<TableProperty>> constraintTestData = {
  'Shorthand Constraints': [
    SerialColumn("serial_column", isPrimaryKey: true),
    TextColumn("text_column", isUnique: true),
    DateColumn("date_column", isNullable: true),
    IntegerColumn("integer_column", foreignKeyForTable: "foreign_table"),
  ],
  'Inline Constraints': [
    SerialColumn(
      "serial_column",
      constraints: ColumnConstraints(
        primaryKeyConstraint:
            PrimaryKeyConstraint(name: "primary_key_constraint"),
      ),
    ),
    TextColumn(
      "text_column",
      constraints: ColumnConstraints(
        uniqueConstraint: UniqueConstraint(name: "unique_constraint"),
      ),
    ),
    DateColumn(
      "date_column",
      constraints: ColumnConstraints(
        checkConstraint: CheckConstraint(
          name: "check_constraint",
          check: 'serial_column < integer_column',
        ),
      ),
    ),
    IntegerColumn(
      "integer_column",
      constraints: ColumnConstraints(
        foreignKeyConstraint:
            ForeignKeyConstraint(referencedTable: "foreign_table"),
      ),
    ),
    IntegerColumn(
      "integer_column_2",
      constraints: ColumnConstraints(
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "foreign_table",
          referencedColumn: "ft_integer_column",
        ),
      ),
    ),
    IntegerColumn(
      "integer_column_3",
      constraints: ColumnConstraints(
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "foreign_table",
          referencedColumn: "ft_integer_column",
        ),
      ),
    ),
    IntegerColumn(
      "integer_column_4",
      constraints: ColumnConstraints(
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "foreign_table",
          deletionMode: ForeignKeyDeletionMode.cascade,
        ),
      ),
    ),
    IntegerColumn(
      "integer_column_5",
      constraints: ColumnConstraints(
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "foreign_table",
          deletionMode: ForeignKeyDeletionMode.restrict,
        ),
      ),
    ),
    IntegerColumn(
      "integer_column_6",
      constraints: ColumnConstraints(
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "foreign_table",
          deletionMode: ForeignKeyDeletionMode.noAction,
        ),
      ),
    ),
    IntegerColumn(
      "integer_column_7",
      constraints: ColumnConstraints(
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "foreign_table",
          deletionMode: ForeignKeyDeletionMode.setDefault,
        ),
      ),
    ),
    IntegerColumn(
      "integer_column_8",
      constraints: ColumnConstraints(
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "foreign_table",
          deletionMode: ForeignKeyDeletionMode.setNull,
        ),
      ),
    ),
    IntegerColumn(
      "integer_column_9",
      constraints: ColumnConstraints(
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "foreign_table",
          deletionMode: ForeignKeyDeletionMode.restrict,
          updateMode: ForeignKeyUpdateMode.cascade,
        ),
      ),
    ),
    IntegerColumn(
      "integer_column_10",
      constraints: ColumnConstraints(
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "foreign_table",
          updateMode: ForeignKeyUpdateMode.cascade,
        ),
      ),
    ),
    IntegerColumn(
      "integer_column_11",
      constraints: ColumnConstraints(
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "foreign_table",
          updateMode: ForeignKeyUpdateMode.noAction,
        ),
      ),
    ),
    IntegerColumn(
      "integer_column_12",
      constraints: ColumnConstraints(
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "foreign_table",
          updateMode: ForeignKeyUpdateMode.restrict,
        ),
      ),
    ),
    IntegerColumn(
      "integer_column_13",
      constraints: ColumnConstraints(
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "foreign_table",
          updateMode: ForeignKeyUpdateMode.setDefault,
        ),
      ),
    ),
    IntegerColumn(
      "integer_column_14",
      constraints: ColumnConstraints(
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "foreign_table",
          updateMode: ForeignKeyUpdateMode.setNull,
        ),
      ),
    ),
    IntegerColumn(
      "integer_column_15",
      constraints: ColumnConstraints(
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "foreign_table",
          updateMode: ForeignKeyUpdateMode.undefined,
        ),
      ),
    ),
  ],
  'Individual Constraints on Single Columns': [
    SerialColumn(
      "serial_column",
    ),
    PrimaryKeyConstraint(
      name: "primary_key_constraint",
      columnNames: ["serial_column"],
    ),
    TextColumn(
      "text_column",
    ),
    UniqueConstraint(
      name: "unique_constraint",
      columnNames: ["text_column"],
    ),
    DateColumn(
      "date_column",
    ),
    CheckConstraint(
      name: "check_constraint",
      check: 'serial_column < integer_column',
    ),
    IntegerColumn("integer_column"),
    ForeignKeyConstraint.tableProperty(
      foreignKeyColumn: "integer_column",
      referencedTable: "foreign_table",
    ),
    IntegerColumn("integer_column_2"),
    ForeignKeyConstraint.tableProperty(
      foreignKeyColumn: "integer_column_2",
      referencedTable: "foreign_table",
      referencedColumn: "ft_integer_column",
    ),
    IntegerColumn(
      "integer_column_3",
      constraints: ColumnConstraints(
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "foreign_table",
          referencedColumn: "ft_integer_column",
        ),
      ),
    ),
    ForeignKeyConstraint.tableProperty(
      foreignKeyColumn: "integer_column_3",
      referencedTable: "foreign_table",
      referencedColumn: "ft_integer_column",
    ),
    IntegerColumn("integer_column_4"),
    ForeignKeyConstraint.tableProperty(
      foreignKeyColumn: "integer_column_4",
      referencedTable: "foreign_table",
      deletionMode: ForeignKeyDeletionMode.cascade,
    ),
    IntegerColumn("integer_column_5"),
    ForeignKeyConstraint.tableProperty(
      foreignKeyColumn: "integer_column_5",
      referencedTable: "foreign_table",
      deletionMode: ForeignKeyDeletionMode.restrict,
    ),
    IntegerColumn("integer_column_6"),
    ForeignKeyConstraint.tableProperty(
      foreignKeyColumn: "integer_column_6",
      referencedTable: "foreign_table",
      deletionMode: ForeignKeyDeletionMode.noAction,
    ),
    IntegerColumn("integer_column_7"),
    ForeignKeyConstraint.tableProperty(
      foreignKeyColumn: "integer_column_7",
      referencedTable: "foreign_table",
      deletionMode: ForeignKeyDeletionMode.setDefault,
    ),
    IntegerColumn("integer_column_8"),
    ForeignKeyConstraint.tableProperty(
      foreignKeyColumn: "integer_column_8",
      referencedTable: "foreign_table",
      deletionMode: ForeignKeyDeletionMode.setNull,
    ),
    IntegerColumn("integer_column_9"),
    ForeignKeyConstraint.tableProperty(
      foreignKeyColumn: "integer_column_9",
      referencedTable: "foreign_table",
      deletionMode: ForeignKeyDeletionMode.noAction,
      updateMode: ForeignKeyUpdateMode.cascade,
    ),
    IntegerColumn("integer_column_10"),
    ForeignKeyConstraint.tableProperty(
      foreignKeyColumn: "integer_column_10",
      referencedTable: "foreign_table",
      updateMode: ForeignKeyUpdateMode.cascade,
    ),
    IntegerColumn("integer_column_11"),
    ForeignKeyConstraint.tableProperty(
      foreignKeyColumn: "integer_column_11",
      referencedTable: "foreign_table",
      updateMode: ForeignKeyUpdateMode.noAction,
    ),
    IntegerColumn("integer_column_12"),
    ForeignKeyConstraint.tableProperty(
      foreignKeyColumn: "integer_column_12",
      referencedTable: "foreign_table",
      updateMode: ForeignKeyUpdateMode.restrict,
    ),
    IntegerColumn("integer_column_13"),
    ForeignKeyConstraint.tableProperty(
      foreignKeyColumn: "integer_column_13",
      referencedTable: "foreign_table",
      updateMode: ForeignKeyUpdateMode.setDefault,
    ),
    IntegerColumn("integer_column_14"),
    ForeignKeyConstraint.tableProperty(
      foreignKeyColumn: "integer_column_14",
      referencedTable: "foreign_table",
      updateMode: ForeignKeyUpdateMode.setNull,
    ),
    IntegerColumn("integer_column_15"),
    ForeignKeyConstraint.tableProperty(
      foreignKeyColumn: "integer_column_15",
      referencedTable: "foreign_table",
      updateMode: ForeignKeyUpdateMode.undefined,
    ),
  ],
  'Individual Constraints on Multiple Columns': [
    SerialColumn(
      "serial_column",
    ),
    TextColumn(
      "text_column",
    ),
    PrimaryKeyConstraint(
      name: "primary_key_constraint",
      columnNames: ["serial_column", "text_column"],
    ),
    UniqueConstraint(
      name: "unique_constraint",
      columnNames: ["serial_column", "text_column"],
    ),
    DateColumn(
      "date_column",
    ),
    CheckConstraint(
      name: "check_constraint",
      check: 'serial_column < integer_column',
    ),
    IntegerColumn("integer_column"),
    ForeignKeyConstraint.multiColumn(
      columnNames: {
        "integer_column": "ft_integer_column",
        "text_column": "ft_text_column",
      },
      referencedTable: "foreign_table",
    ),
    IntegerColumn("integer_column_2"),
    ForeignKeyConstraint.multiColumn(
      columnNames: {
        "integer_column_2": "ft_integer_column",
        "text_column": "ft_text_column",
      },
      referencedTable: "foreign_table",
    ),
    IntegerColumn("integer_column_3"),
    ForeignKeyConstraint.multiColumn(
      columnNames: {
        "integer_column_3": "ft_integer_column",
        "text_column": "ft_text_column",
      },
      referencedTable: "foreign_table",
    ),
    IntegerColumn("integer_column_4"),
    ForeignKeyConstraint.multiColumn(
      columnNames: {
        "integer_column_4": "ft_integer_column",
        "text_column": "ft_text_column",
      },
      referencedTable: "foreign_table",
      deletionMode: ForeignKeyDeletionMode.cascade,
    ),
    IntegerColumn("integer_column_5"),
    ForeignKeyConstraint.multiColumn(
      columnNames: {
        "integer_column_5": "ft_integer_column",
        "text_column": "ft_text_column",
      },
      referencedTable: "foreign_table",
      deletionMode: ForeignKeyDeletionMode.restrict,
    ),
    IntegerColumn("integer_column_6"),
    ForeignKeyConstraint.multiColumn(
      columnNames: {
        "integer_column_6": "ft_integer_column",
        "text_column": "ft_text_column",
      },
      referencedTable: "foreign_table",
      deletionMode: ForeignKeyDeletionMode.noAction,
    ),
    IntegerColumn("integer_column_7"),
    ForeignKeyConstraint.multiColumn(
      columnNames: {
        "integer_column_7": "ft_integer_column",
        "text_column": "ft_text_column",
      },
      referencedTable: "foreign_table",
      deletionMode: ForeignKeyDeletionMode.setDefault,
    ),
    IntegerColumn("integer_column_8"),
    ForeignKeyConstraint.multiColumn(
      columnNames: {
        "integer_column_8": "ft_integer_column",
        "text_column": "ft_text_column",
      },
      referencedTable: "foreign_table",
      deletionMode: ForeignKeyDeletionMode.setNull,
    ),
    IntegerColumn("integer_column_9"),
    ForeignKeyConstraint.multiColumn(
      columnNames: {
        "integer_column_9": "ft_integer_column",
        "text_column": "ft_text_column",
      },
      referencedTable: "foreign_table",
      deletionMode: ForeignKeyDeletionMode.noAction,
      updateMode: ForeignKeyUpdateMode.cascade,
    ),
    IntegerColumn("integer_column_10"),
    ForeignKeyConstraint.multiColumn(
      columnNames: {
        "integer_column_10": "ft_integer_column",
        "text_column": "ft_text_column",
      },
      referencedTable: "foreign_table",
      updateMode: ForeignKeyUpdateMode.cascade,
    ),
    IntegerColumn("integer_column_11"),
    ForeignKeyConstraint.multiColumn(
      columnNames: {
        "integer_column_11": "ft_integer_column",
        "text_column": "ft_text_column",
      },
      referencedTable: "foreign_table",
      updateMode: ForeignKeyUpdateMode.noAction,
    ),
    IntegerColumn("integer_column_12"),
    ForeignKeyConstraint.multiColumn(
      columnNames: {
        "integer_column_12": "ft_integer_column",
        "text_column": "ft_text_column",
      },
      referencedTable: "foreign_table",
      updateMode: ForeignKeyUpdateMode.restrict,
    ),
    IntegerColumn("integer_column_13"),
    ForeignKeyConstraint.multiColumn(
      columnNames: {
        "integer_column_13": "ft_integer_column",
        "text_column": "ft_text_column",
      },
      referencedTable: "foreign_table",
      updateMode: ForeignKeyUpdateMode.setDefault,
    ),
    IntegerColumn("integer_column_14"),
    ForeignKeyConstraint.multiColumn(
      columnNames: {
        "integer_column_14": "ft_integer_column",
        "text_column": "ft_text_column",
      },
      referencedTable: "foreign_table",
      updateMode: ForeignKeyUpdateMode.setNull,
    ),
    IntegerColumn("integer_column_15"),
    ForeignKeyConstraint.multiColumn(
      columnNames: {
        "integer_column_15": "ft_integer_column",
        "text_column": "ft_text_column",
      },
      referencedTable: "foreign_table",
      updateMode: ForeignKeyUpdateMode.undefined,
    ),
  ],
};
