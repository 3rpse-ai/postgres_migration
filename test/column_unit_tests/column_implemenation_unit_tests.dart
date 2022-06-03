import 'package:test/test.dart';
import 'package:postgres_migration/postgres_migration.dart';

void executeColumnImplementationUnitTests() {
  test('1.1 small int simple column', () {
    final column = SmallIntColumn('column_name');
    expect(column.sqlSnippet, '"column_name" smallint NOT NULL');
  });

  test('1.2 small int column with default', () {
    final column = SmallIntColumn('column_name', defaultValue: 2);
    expect(column.sqlSnippet, '"column_name" smallint NOT NULL DEFAULT 2');
  });

  test('2.1 integer simple column', () {
    final column = IntegerColumn('column_name');
    expect(column.sqlSnippet, '"column_name" integer NOT NULL');
  });

  test('2.2 integer column with default', () {
    final column = IntegerColumn('column_name', defaultValue: 2);
    expect(column.sqlSnippet, '"column_name" integer NOT NULL DEFAULT 2');
  });

  test('3.1 big int simple column', () {
    final column = BigIntColumn('column_name');
    expect(column.sqlSnippet, '"column_name" bigint NOT NULL');
  });

  test('3.2 big int column with default', () {
    final column = BigIntColumn('column_name', defaultValue: 2);
    expect(column.sqlSnippet, '"column_name" bigint NOT NULL DEFAULT 2');
  });

  test('4.1 numeric simple column', () {
    final column = NumericColumn('column_name');
    expect(column.sqlSnippet, '"column_name" numeric NOT NULL');
  });

  test('4.2 numeric column with default', () {
    final column = NumericColumn('column_name', defaultValue: 2.2);
    expect(column.sqlSnippet, '"column_name" numeric NOT NULL DEFAULT 2.2');
  });

  test('4.3 numeric column with precision & default', () {
    final column = NumericColumn('column_name', defaultValue: 2, precision: 4);
    expect(column.sqlSnippet, '"column_name" numeric(4) NOT NULL DEFAULT 2');
  });

  test('4.4 numeric column with default & scale', () {
    final column = NumericColumn('column_name', defaultValue: 2, scale: 2);
    expect(column.sqlSnippet, '"column_name" numeric NOT NULL DEFAULT 2.0');
  });

  test('4.5 numeric column with default, precision & 0 scale', () {
    final column =
        NumericColumn('column_name', defaultValue: 2, precision: 2, scale: 0);
    expect(column.sqlSnippet, '"column_name" numeric(2, 0) NOT NULL DEFAULT 2');
  });

  test('4.6 numeric column with default, precision & scale', () {
    final column =
        NumericColumn('column_name', defaultValue: 2, precision: 3, scale: 2);
    expect(
        column.sqlSnippet, '"column_name" numeric(3, 2) NOT NULL DEFAULT 2.0');
  });

  test('4.7 numeric column with double.infinty default', () {
    final column = NumericColumn('column_name', defaultValue: double.infinity);
    expect(column.sqlSnippet,
        '"column_name" numeric NOT NULL DEFAULT \'INFINITY\'');
  });

  test('4.8 numeric column with double.negativeInfinty default', () {
    final column =
        NumericColumn('column_name', defaultValue: double.negativeInfinity);
    expect(column.sqlSnippet,
        '"column_name" numeric NOT NULL DEFAULT \'-INFINITY\'');
  });

  test('4.9 numeric column with double.nan default', () {
    final column =
        NumericColumn('column_name', defaultValue: double.nan);
    expect(column.sqlSnippet,
        '"column_name" numeric NOT NULL DEFAULT \'NaN\'');
  });

  test('5.1 decimal simple column', () {
    final column = DecimalColumn('column_name');
    expect(column.sqlSnippet, '"column_name" decimal NOT NULL');
  });

  test('5.2 decimal column with default', () {
    final column = DecimalColumn('column_name', defaultValue: 2.2);
    expect(column.sqlSnippet, '"column_name" decimal NOT NULL DEFAULT 2.2');
  });

  test('5.3 decimal column with precision & default', () {
    final column = DecimalColumn('column_name', defaultValue: 2, precision: 4);
    expect(column.sqlSnippet, '"column_name" decimal(4) NOT NULL DEFAULT 2');
  });

  test('5.4 decimal column with default & scale', () {
    final column = DecimalColumn('column_name', defaultValue: 2, scale: 2);
    expect(column.sqlSnippet, '"column_name" decimal NOT NULL DEFAULT 2.0');
  });

  test('5.5 decimal column with default, precision & 0 scale', () {
    final column =
        DecimalColumn('column_name', defaultValue: 2, precision: 2, scale: 0);
    expect(column.sqlSnippet, '"column_name" decimal(2, 0) NOT NULL DEFAULT 2');
  });

  test('5.6 decimal column with default, precision & scale', () {
    final column =
        DecimalColumn('column_name', defaultValue: 2, precision: 3, scale: 2);
    expect(
        column.sqlSnippet, '"column_name" decimal(3, 2) NOT NULL DEFAULT 2.0');
  });

  test('5.7 decimal column with double.infinty default', () {
    final column = DecimalColumn('column_name', defaultValue: double.infinity);
    expect(column.sqlSnippet,
        '"column_name" decimal NOT NULL DEFAULT \'INFINITY\'');
  });

  test('5.8 decimal column with double.negativeInfinty default', () {
    final column =
        DecimalColumn('column_name', defaultValue: double.negativeInfinity);
    expect(column.sqlSnippet,
        '"column_name" decimal NOT NULL DEFAULT \'-INFINITY\'');
  });

  test('5.9 decimal column with double.nan default', () {
    final column =
        DecimalColumn('column_name', defaultValue: double.nan);
    expect(column.sqlSnippet,
        '"column_name" decimal NOT NULL DEFAULT \'NaN\'');
  });

  test('6.1 real simple column', () {
    final column = RealColumn('column_name');
    expect(column.sqlSnippet, '"column_name" real NOT NULL');
  });

  test('6.2 real column with default', () {
    final column = RealColumn('column_name', defaultValue: 2);
    expect(column.sqlSnippet, '"column_name" real NOT NULL DEFAULT 2.0');
  });

  test('7.1 double precision simple column', () {
    final column = DoublePrecisionColumn('column_name');
    expect(column.sqlSnippet, '"column_name" double precision NOT NULL');
  });

  test('7.2 double precision column with default', () {
    final column = DoublePrecisionColumn('column_name', defaultValue: 2);
    expect(column.sqlSnippet, '"column_name" double precision NOT NULL DEFAULT 2.0');
  });

  test('8.1 float simple column', () {
    final column = FloatColumn('column_name');
    expect(column.sqlSnippet, '"column_name" float NOT NULL');
  });

  test('8.2 float column with precision', () {
    final column = FloatColumn('column_name', precision: 3);
    expect(column.sqlSnippet, '"column_name" float(3) NOT NULL');
  });

  test('8.3 float column with default', () {
    final column = FloatColumn('column_name', defaultValue:  4.22);
    expect(column.sqlSnippet, '"column_name" float NOT NULL DEFAULT 4.22');
  });

  test('9.1 small serial column', () {
    final column = SmallSerialColumn('column_name');
    expect(column.sqlSnippet, '"column_name" smallserial');
  });

  test('10.1 serial column', () {
    final column = SerialColumn('column_name');
    expect(column.sqlSnippet, '"column_name" serial');
  });

  test('11.1 big serial column', () {
    final column = BigSerialColumn('column_name');
    expect(column.sqlSnippet, '"column_name" bigserial');
  });
}

