import 'package:test/test.dart';
import 'package:db_migrator/db_migrator.dart';

enum TestEnum { firstValue, secondValue, thirdValue }

void executeEnumMigratorUnitTests() {
  test('1. Create Enum', () {
    String createEnum = EnumMigrator.createEnum(TestEnum.values);
    String createEnumWithName = EnumMigrator.createEnum(
      TestEnum.values,
      enumName: "TestEnum",
    );

    expect(
      createEnum,
      "CREATE TYPE TestEnum AS ENUM ('firstValue', 'secondValue', 'thirdValue')",
    );

    expect(
      createEnumWithName,
      "CREATE TYPE TestEnum AS ENUM ('firstValue', 'secondValue', 'thirdValue')",
    );
  });

  test('2. Create Enum Direct Input', () {
    String createEnum = EnumMigrator.createEnumDirectInput(
      enumValues: ["firstValue", "secondValue", "thirdValue"],
      enumName: "TestEnum",
    );

    expect(
      createEnum,
      "CREATE TYPE TestEnum AS ENUM ('firstValue', 'secondValue', 'thirdValue')",
    );
  });

  test('3. Add Enum Value', () {
    String addEnumValuePlain = EnumMigrator.addEnumValue(TestEnum.firstValue);
    expect(
      addEnumValuePlain,
      "ALTER TYPE TestEnum ADD VALUE 'firstValue'",
    );
    String addEnumValueName =
        EnumMigrator.addEnumValue(TestEnum.firstValue, enumName: "OTHERNAME");
    expect(
      addEnumValueName,
      "ALTER TYPE OTHERNAME ADD VALUE 'firstValue'",
    );
    String addEnumValueNameIfNotExists = EnumMigrator.addEnumValue(
        TestEnum.firstValue,
        enumName: "OTHERNAME",
        ifNotExists: true);
    expect(
      addEnumValueNameIfNotExists,
      "ALTER TYPE OTHERNAME ADD VALUE IF NOT EXISTS 'firstValue'",
    );
    String addEnumValueNameIfNotExistsBefore = EnumMigrator.addEnumValue(
      TestEnum.firstValue,
      enumName: "OTHERNAME",
      ifNotExists: true,
      beforeValue: TestEnum.secondValue,
    );
    expect(
      addEnumValueNameIfNotExistsBefore,
      "ALTER TYPE OTHERNAME ADD VALUE IF NOT EXISTS 'firstValue' BEFORE 'secondValue'",
    );
    String addEnumValueNameIfNotExistsAfter = EnumMigrator.addEnumValue(
      TestEnum.firstValue,
      enumName: "OTHERNAME",
      ifNotExists: true,
      afterValue: TestEnum.thirdValue,
    );
    expect(
      addEnumValueNameIfNotExistsAfter,
      "ALTER TYPE OTHERNAME ADD VALUE IF NOT EXISTS 'firstValue' AFTER 'thirdValue'",
    );
    String addEnumValueNameIfNotExistsBeforeAfter = EnumMigrator.addEnumValue(
      TestEnum.firstValue,
      enumName: "OTHERNAME",
      ifNotExists: true,
      beforeValue: TestEnum.secondValue,
      afterValue: TestEnum.thirdValue,
    );
    expect(
      addEnumValueNameIfNotExistsBeforeAfter,
      "ALTER TYPE OTHERNAME ADD VALUE IF NOT EXISTS 'firstValue' BEFORE 'secondValue'",
    );
  });

  test('4. Add Enum Value Direct Input', () {
    String addEnumValuePlain = EnumMigrator.addEnumValueDirectInput(
        enumValue: "firstValue", enumName: "TestEnum");
    expect(
      addEnumValuePlain,
      "ALTER TYPE TestEnum ADD VALUE 'firstValue'",
    );
    String addEnumValueName = EnumMigrator.addEnumValueDirectInput(
        enumValue: "firstValue", enumName: "OTHERNAME");
    expect(
      addEnumValueName,
      "ALTER TYPE OTHERNAME ADD VALUE 'firstValue'",
    );
    String addEnumValueNameIfNotExists = EnumMigrator.addEnumValueDirectInput(
        enumValue: "firstValue", enumName: "OTHERNAME", ifNotExists: true);
    expect(
      addEnumValueNameIfNotExists,
      "ALTER TYPE OTHERNAME ADD VALUE IF NOT EXISTS 'firstValue'",
    );
    String addEnumValueNameIfNotExistsBefore =
        EnumMigrator.addEnumValueDirectInput(
      enumValue: "firstValue",
      enumName: "OTHERNAME",
      ifNotExists: true,
      beforeValue: "secondValue",
    );
    expect(
      addEnumValueNameIfNotExistsBefore,
      "ALTER TYPE OTHERNAME ADD VALUE IF NOT EXISTS 'firstValue' BEFORE 'secondValue'",
    );
    String addEnumValueNameIfNotExistsAfter =
        EnumMigrator.addEnumValueDirectInput(
      enumValue: "firstValue",
      enumName: "OTHERNAME",
      ifNotExists: true,
      afterValue: "thirdValue",
    );
    expect(
      addEnumValueNameIfNotExistsAfter,
      "ALTER TYPE OTHERNAME ADD VALUE IF NOT EXISTS 'firstValue' AFTER 'thirdValue'",
    );
    String addEnumValueNameIfNotExistsBeforeAfter =
        EnumMigrator.addEnumValueDirectInput(
      enumValue: "firstValue",
      enumName: "OTHERNAME",
      ifNotExists: true,
      beforeValue: "secondValue",
      afterValue: "thirdValue",
    );
    expect(
      addEnumValueNameIfNotExistsBeforeAfter,
      "ALTER TYPE OTHERNAME ADD VALUE IF NOT EXISTS 'firstValue' BEFORE 'secondValue'",
    );
  });

  test('5. Rename Enum', () {
    String renameEnum = EnumMigrator.renameEnum(
      newName: "NewName",
      oldName: "OldName",
    );

    expect(
      renameEnum,
      "ALTER TYPE OldName RENAME TO NewName",
    );
  });

  test('6. Rename Enum Value', () {
    String renameEnum = EnumMigrator.renameEnumValue(
      oldValue: TestEnum.firstValue,
      newValue: TestEnum.secondValue,
    );

    String renameEnumWithName = EnumMigrator.renameEnumValue(
        oldValue: TestEnum.firstValue,
        newValue: TestEnum.secondValue,
        enumName: "ManualEnumName");

    expect(
      renameEnum,
      "ALTER TYPE TestEnum RENAME VALUE 'firstValue' TO 'secondValue'",
    );

    expect(
      renameEnumWithName,
      "ALTER TYPE ManualEnumName RENAME VALUE 'firstValue' TO 'secondValue'",
    );
  });

  test('6. Rename Enum Value Direct Input', () {
    String renameEnum = EnumMigrator.renameEnumValueDirectInput(
        oldValue: "firstValue", newValue: "secondValue", enumName: "TestEnum");

    expect(
      renameEnum,
      "ALTER TYPE TestEnum RENAME VALUE 'firstValue' TO 'secondValue'",
    );
  });

  test('7. Drop Enum', () {
    String dropEnum = EnumMigrator.dropEnum("TestEnum");

    expect(
      dropEnum,
      "DROP TYPE TestEnum",
    );

    String dropEnumIfExists = EnumMigrator.dropEnum("TestEnum", ifExists: true);

    expect(
      dropEnumIfExists,
      "DROP TYPE IF EXISTS TestEnum",
    );

    String dropEnumIfExistsCascade = EnumMigrator.dropEnum(
      "TestEnum",
      ifExists: true,
      mode: EnumDropMode.cascade,
    );

    expect(
      dropEnumIfExistsCascade,
      "DROP TYPE IF EXISTS TestEnum CASCADE",
    );

    String dropEnumIfExistsRestrict = EnumMigrator.dropEnum(
      "TestEnum",
      ifExists: true,
      mode: EnumDropMode.restrict,
    );

    expect(
      dropEnumIfExistsRestrict,
      "DROP TYPE IF EXISTS TestEnum RESTRICT",
    );
  });

  test('8. Print EnumDropMode', () {
    print(EnumDropMode.cascade);

    expect(EnumDropMode.cascade.mode, "CASCADE");
  });
}
