import 'package:test/test.dart';
import 'package:postgres_migration/postgres_migration.dart';
import 'test_data/column_data.dart';
import 'test_data/constraint_data.dart';
import 'test_data/table_updates.dart';

/// Collection of tests to run against DB
///
/// Tests only check for thrown exceptions (if accepted by DB), NOT for actual results in DB
void executeIntegrationTests(
  Future<dynamic> Function(String sqlStatement) callDB,
) {
  final migrator = TableMigrator('table_name');

  // Remove table after every run
  tearDown(() async => await callDB(migrator.removeTable(ifExists: true)));

  group('1. Create Table Columns //', () {
    // extract data from integration_test_data
    // creates a test per column type with respective use case
    for (int i = 0; i < columnTestData.entries.length; i++) {
      final columnCategory = columnTestData.entries.elementAt(i);
      for (int ii = 0; ii < columnCategory.value.entries.length; ii++) {
        final dataSet = columnCategory.value.entries.elementAt(ii);
        final categoryName = columnCategory.key;
        final categoryCount = i + 1;
        final dataSetname = dataSet.key;
        final dataSetCount = ii + 1;
        final testName =
            "$categoryCount. $categoryName // $dataSetCount. $dataSetname";
        test(testName, () async {
          final statement = migrator.createTable(dataSet.value);
          printOnFailure(statement);
          await callDB(statement);
          await callDB(migrator.removeTable());
        });
      }
    }
  });

  group('2. Create Table Constraints //', () {
    final ftMigrator = TableMigrator("foreign_table");
    setUp(() async =>
        callDB(ftMigrator.createTable(foreignTableConstraintTestData)));
    tearDown(() async => callDB(ftMigrator.removeTable()));

    // extract data from integration_test_data
    // creates a test per column type with respective use case
    for (int i = 0; i < constraintTestData.entries.length; i++) {
      final constraintCategory = constraintTestData.entries.elementAt(i);
      final dataSet = constraintCategory.value;
      final categoryName = constraintCategory.key;
      final categoryCount = i + 1;
      final testName = "$categoryCount. $categoryName";

      test(testName, () async {
        final statement = migrator.createTable(dataSet);
        printOnFailure(statement);
        await callDB(statement);
        await callDB(migrator.removeTable());
      });
    }
  });

  group('3. Update Table //', () {
    final ftMigrator = TableMigrator("foreign_table");
    setUp(() async {
      await callDB(ftMigrator.createTable(updateTableForeignTableTestData));
      await callDB(migrator.createTable(updateTableMainTableTestData));
    });
    tearDown(() async {
      await callDB(migrator.removeTable());
      await callDB(ftMigrator.removeTable());
    });

    group('1. Columns // ', () {
      group('1. Add Column // ', () {
        for (int i = 0; i < columnTestData.entries.length; i++) {
          final columnCategory = columnTestData.entries.elementAt(i);
          for (int ii = 0; ii < columnCategory.value.entries.length; ii++) {
            final dataSet = columnCategory.value.entries.elementAt(ii);
            final categoryName = columnCategory.key;
            final categoryCount = i + 1;
            final dataSetname = dataSet.key;
            final dataSetCount = ii + 1;
            final testName =
                "$categoryCount. $categoryName // $dataSetCount. $dataSetname // ";
            for (final column in dataSet.value) {
              test("$testName${column.runtimeType}", () async {
                final statement = migrator.addColumn(column);
                printOnFailure(statement);
                await callDB(statement);
              });
            }
          }
        }
      });
      group('2. Remove Column // ', () {
        test("1. Cascading False", () async {
          await callDB(migrator.removeColumn("main_date_column"));
        });

        test("2. Cascading True", () async {
          await callDB(migrator.removeColumn("main_date_column"));
        });
      });
      group("3. Change Default Value // ", () {
        test("1. Set text column default value", () async {
          await callDB(migrator.changeColumnDefaultValue(
              TextColumn("main_text_column", defaultValue: "HELLO THERE")));
        });
      });
      group("4. Remove Default Value // ", () {
        test("1. Remove column default value", () async {
          await callDB(migrator.changeColumnDefaultValue(
              TextColumn("main_text_column", defaultValue: "HELLO THERE")));
          await callDB(migrator.removeColumnDefaultValue("main_text_column"));
        });
      });
      // TODO: fix this test
      // group("5. Change Type // ", () {
      //   test("1. Change text to integer type", () async {
      //     await callDB(
      //       migrator.changeColumnDataType(IntegerColumn("main_text_column")),
      //     );
      //   });
      // });
      group("6. Rename Column // ", () {
        test("1. Rename text column", () async {
          await callDB(
            migrator.renameColumn("main_text_column", "new_text_column"),
          );
        });
      });
    });

    group('2. Constraints // ', () {
      group("1. Add Constraint // ", () {
        for (int i = 0; i < updateTableConstraintTestData.length; i++) {
          final constraint = updateTableConstraintTestData[i];
          final constraintCount = i + 1;
          final testName = "$constraintCount. ${constraint.runtimeType}";

          test(testName, () async {
            final statement = migrator.addConstraint(constraint);
            printOnFailure(statement);
            await callDB(statement);
          });
        }

        test("${updateTableConstraintTestData.length + 1}. NOT NULL Constraint",
            () async {
          await callDB(migrator.addNotNullConstraint('main_date_column'));
        });
      });
      group("2. Remove Constraint // ", () {
        test("1. Regular Constraint", () async {
          await callDB(migrator.addConstraint(
            UniqueConstraint(name: "unique_constraint", columnNames: [
              "main_text_column",
              "main_date_column",
            ]),
          ));
          await callDB(migrator.removeConstraint('unique_constraint'));
        });

        test("2. NOT NULL constraint", () async {
          await callDB(migrator.addNotNullConstraint("main_date_column"));
          await callDB(migrator.removeNotNullConstraint('main_date_column'));
        });
      });
    });

    group("3. Whole Table // ", () {
      group("1. Rename Table // ", () {
        test("1. Rename table", () async {
          final testMigrator = TableMigrator("Test_Table");
          await callDB(testMigrator.createTable([]));
          await callDB(testMigrator.renameTable("New_Name"));
          await callDB(testMigrator.removeTable());
        });

        test("2. Rename table, no migrator update", () async {
          final testMigrator = TableMigrator("Test_Table");
          await callDB(testMigrator.createTable([]));
          await callDB(testMigrator.renameTable("New_Name"));

          final newMigrator = TableMigrator(("New_Name"));
          await callDB(newMigrator.removeTable());
        });
      });

        group("2. Remove Table // ", () {
          test("1. Remove table simple", () async {
            final testMigrator = TableMigrator("New_Table");

            await callDB(testMigrator.createTable([]));
            await callDB(testMigrator.removeTable());
          });

          test("2. Remove table simple if exists", () async {
            final testMigrator = TableMigrator("New_Table");

            await callDB(testMigrator.createTable([]));
            await callDB(testMigrator.removeTable(ifExists: true));
          });

          test("3. Remove table mode: CASCADE", () async {
            final testMigrator = TableMigrator("New_Table");

            await callDB(testMigrator.createTable([]));
            await callDB(
                testMigrator.removeTable(mode: TableDeletionMode.cascade));
          });

          test("4. Remove table mode: RESTRICT", () async {
            final testMigrator = TableMigrator("New_Table");

            await callDB(testMigrator.createTable([]));
            await callDB(
                testMigrator.removeTable(mode: TableDeletionMode.restrict));
          });
        });
    });
  });
}
