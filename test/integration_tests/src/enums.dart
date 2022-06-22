import 'package:test/test.dart';
import 'package:postgres_migration/postgres_migration.dart';

enum TestEnum {
  first,
  second,
  third,
}

void executeEnumIntegrationTests(
  TableMigrator migrator,
  Future<dynamic> Function(String sqlStatement) callDB,
){
  setUp(() async => await callDB(
        EnumMigrator.createEnum([TestEnum.first, TestEnum.second])));
    tearDown(() async => await callDB(EnumMigrator.dropEnum("TestEnum")));

    test("1. Create Enum With Name", () async {
      await callDB(
          EnumMigrator.createEnum(TestEnum.values, enumName: "MyEnum"));
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "MyEnum")]));
      await callDB(migrator.dropTable());
      await callDB(EnumMigrator.dropEnum("MyEnum"));
    });

    test("2. Create Enum Direct Input", () async {
      await callDB(EnumMigrator.createEnumDirectInput(
          enumValues: ["first", "second", "third"], enumName: "MyEnum"));
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "MyEnum")]));
      await callDB(migrator.dropTable());
      await callDB(EnumMigrator.dropEnum("MyEnum"));
    });

    test("3. Add Enum Value", () async {
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "TestEnum")]));
      await callDB(EnumMigrator.addEnumValue(TestEnum.third));
      await callDB(migrator.dropTable());
    });

    test("4. Add Enum Value With Name", () async {
      await callDB(EnumMigrator.createEnum(
        [
          TestEnum.first,
          TestEnum.second,
        ],
        enumName: "MyEnum",
      ));
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "MyEnum")]));
      await callDB(
          EnumMigrator.addEnumValue(TestEnum.third, enumName: "MyEnum"));
      await callDB(migrator.dropTable());
      await callDB(EnumMigrator.dropEnum("MyEnum"));
    });

    test("5. Add Enum Value If Not Exists", () async {
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "TestEnum")]));
      await callDB(
          EnumMigrator.addEnumValue(TestEnum.third, ifNotExists: true));
      await callDB(migrator.dropTable());
    });

    test("6. Add Enum Value If Not Exists + Before", () async {
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "TestEnum")]));
      await callDB(EnumMigrator.addEnumValue(
        TestEnum.third,
        ifNotExists: true,
        beforeValue: TestEnum.first,
      ));
      await callDB(migrator.dropTable());
    });

    test("7. Add Enum Value If Not Exists + After", () async {
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "TestEnum")]));
      await callDB(EnumMigrator.addEnumValue(
        TestEnum.third,
        ifNotExists: true,
        afterValue: TestEnum.first,
      ));
      await callDB(migrator.dropTable());
    });

    test("8. Add Enum Value Direct Input", () async {
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "TestEnum")]));
      await callDB(EnumMigrator.addEnumValueDirectInput(
          enumName: "TestEnum", enumValue: "third"));
      await callDB(migrator.dropTable());
    });

    test("9. Add Enum Value Direct Input If Not Exists", () async {
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "TestEnum")]));
      await callDB(EnumMigrator.addEnumValueDirectInput(
          enumName: "TestEnum", enumValue: "third", ifNotExists: true));
      await callDB(migrator.dropTable());
    });

    test("10. Add Enum Value Direct Input If Not Exists + Before", () async {
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "TestEnum")]));
      await callDB(EnumMigrator.addEnumValueDirectInput(
        enumName: "TestEnum",
        enumValue: "third",
        ifNotExists: true,
        beforeValue: "first",
      ));
      await callDB(migrator.dropTable());
    });

    test("11. Add Enum Value Direct Input After", () async {
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "TestEnum")]));
      await callDB(EnumMigrator.addEnumValueDirectInput(
        enumName: "TestEnum",
        enumValue: "third",
        afterValue: "first",
      ));
      await callDB(migrator.dropTable());
    });

    test("12. Drop Enum", () async {
      await callDB(EnumMigrator.createEnum(
        TestEnum.values,
        enumName: "MyEnum",
      ));
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "MyEnum")]));
      await callDB(migrator.dropTable());
      await callDB(EnumMigrator.dropEnum("MyEnum"));
    });

    test("13. Drop Enum If exists", () async {
      await callDB(EnumMigrator.createEnum(
        TestEnum.values,
        enumName: "MyEnum",
      ));
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "MyEnum")]));
      await callDB(migrator.dropTable());
      await callDB(EnumMigrator.dropEnum(
        "MyEnum",
        ifExists: true,
      ));
    });
    test("14. Drop Enum cascade", () async {
      await callDB(EnumMigrator.createEnum(
        TestEnum.values,
        enumName: "MyEnum",
      ));
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "MyEnum")]));
      await callDB(migrator.dropTable());
      await callDB(EnumMigrator.dropEnum(
        "MyEnum",
        cascade: true,
      ));
    });

    test("15. Drop Enum restrict", () async {
      await callDB(EnumMigrator.createEnum(
        TestEnum.values,
        enumName: "MyEnum",
      ));
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "MyEnum")]));
      await callDB(migrator.dropTable());
      await callDB(EnumMigrator.dropEnum(
        "MyEnum",
        restrict: true,
      ));
    });

    test("16. Drop Enum if exists + cascade", () async {
      await callDB(EnumMigrator.createEnum(
        TestEnum.values,
        enumName: "MyEnum",
      ));
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "MyEnum")]));
      await callDB(migrator.dropTable());
      await callDB(EnumMigrator.dropEnum(
        "MyEnum",
        ifExists: true,
        cascade: true,
      ));
    });

    test("17. Rename Enum", () async {
      await callDB(EnumMigrator.createEnum(
        TestEnum.values,
        enumName: "MyEnum",
      ));
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "MyEnum")]));
      await callDB(
          EnumMigrator.renameEnum(oldName: "MyEnum", newName: "NewEnum"));
      await callDB(migrator.dropTable());
      await callDB(EnumMigrator.dropEnum("NewEnum"));
    });

    test("18. Rename Enum Value", () async {
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "TestEnum")]));
      await callDB(EnumMigrator.renameEnumValue(
        oldValue: TestEnum.first,
        newValue: TestEnum.third,
      ));
      await callDB(migrator.dropTable());
    });

    test("19. Rename Enum Value With Name", () async {
      await callDB(EnumMigrator.createEnum(
        [
          TestEnum.first,
          TestEnum.second,
        ],
        enumName: "MyEnum",
      ));
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "TestEnum")]));
      await callDB(EnumMigrator.renameEnumValue(
          oldValue: TestEnum.first,
          newValue: TestEnum.third,
          enumName: "MyEnum"));
      await callDB(migrator.dropTable());
      await callDB(EnumMigrator.dropEnum("MyEnum"));
    });

    test("20. Rename Enum Value Direct Input", () async {
      await callDB(migrator
          .createTable([EnumColumn("enum_column", enumName: "TestEnum")]));
      await callDB(EnumMigrator.renameEnumValueDirectInput(
        enumName: "TestEnum",
        oldValue: "first",
        newValue: "third",
      ));
      await callDB(migrator.dropTable());
    });
}