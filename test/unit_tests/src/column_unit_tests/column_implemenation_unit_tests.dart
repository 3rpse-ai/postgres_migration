import 'package:test/test.dart';
import 'package:db_migrator/db_migrator.dart';

void executeColumnImplementationUnitTests() {
  test('1.1 small int simple column', () {
    final column = SmallIntColumn('column_name');
    expect(column.sqlSnippet, '"column_name" smallint NOT NULL');
  });

  test('1.2 small int column with default', () {
    final column = SmallIntColumn('column_name', defaultValue: 2);
    expect(column.sqlSnippet, '"column_name" smallint NOT NULL DEFAULT 2');
  });

  test('1.3 small int array column', () {
    final column = SmallIntColumn.array('column_name');
    expect(column.sqlSnippet, '"column_name" smallint[] NOT NULL');
  });

  test('1.4 small int array column with default', () {
    final column =
        SmallIntColumn.array('column_name', defaultArrayValue: [1, 2, 3]);
    expect(column.sqlSnippet,
        '"column_name" smallint[] NOT NULL DEFAULT \'{1, 2, 3}\'');
  });

  test('2.1 integer simple column', () {
    final column = IntegerColumn('column_name');
    expect(column.sqlSnippet, '"column_name" integer NOT NULL');
  });

  test('2.2 integer column with default', () {
    final column = IntegerColumn('column_name', defaultValue: 2);
    expect(column.sqlSnippet, '"column_name" integer NOT NULL DEFAULT 2');
  });

  test('2.3 integer array column', () {
    final column = IntegerColumn.array('column_name');
    expect(column.sqlSnippet, '"column_name" integer[] NOT NULL');
  });

  test('2.4 integer array column with default', () {
    final column =
        IntegerColumn.array('column_name', defaultArrayValue: [1, 2, 3]);
    expect(column.sqlSnippet,
        '"column_name" integer[] NOT NULL DEFAULT \'{1, 2, 3}\'');
  });

  test('3.1 big int simple column', () {
    final column = BigIntColumn('column_name');
    expect(column.sqlSnippet, '"column_name" bigint NOT NULL');
  });

  test('3.2 big int column with default', () {
    final column = BigIntColumn('column_name', defaultValue: 2);
    expect(column.sqlSnippet, '"column_name" bigint NOT NULL DEFAULT 2');
  });

  test('3.3 big int array column', () {
    final column = BigIntColumn.array('column_name');
    expect(column.sqlSnippet, '"column_name" bigint[] NOT NULL');
  });

  test('3.4 big int array column with default', () {
    final column =
        BigIntColumn.array('column_name', defaultArrayValue: [1, 2, 3]);
    expect(column.sqlSnippet,
        '"column_name" bigint[] NOT NULL DEFAULT \'{1, 2, 3}\'');
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
    final column = NumericColumn('column_name', defaultValue: double.nan);
    expect(column.sqlSnippet, '"column_name" numeric NOT NULL DEFAULT \'NaN\'');
  });

  test('4.10 numeric array column', () {
    final column = NumericColumn.array('column_name');
    expect(column.sqlSnippet, '"column_name" numeric[] NOT NULL');
  });

  test('4.11 numeric array column with default', () {
    final column = NumericColumn.array(
      'column_name',
      defaultArrayValue: [1.1, 2.2, 3.3],
    );
    expect(column.sqlSnippet,
        '"column_name" numeric[] NOT NULL DEFAULT \'{1.1, 2.2, 3.3}\'');
  });

  test('4.12 numeric array column with default & args', () {
    final column = NumericColumn.array(
      'column_name',
      defaultArrayValue: [1.1, 2.2, 3.3],
      precision: 3,
      scale: 2,
    );
    expect(column.sqlSnippet,
        '"column_name" numeric(3, 2)[] NOT NULL DEFAULT \'{1.1, 2.2, 3.3}\'');
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
    final column = DecimalColumn('column_name', defaultValue: double.nan);
    expect(column.sqlSnippet, '"column_name" decimal NOT NULL DEFAULT \'NaN\'');
  });

  test('5.10 decimal array column', () {
    final column = DecimalColumn.array('column_name');
    expect(column.sqlSnippet, '"column_name" decimal[] NOT NULL');
  });

  test('5.11 decimal array column with default', () {
    final column = DecimalColumn.array(
      'column_name',
      defaultArrayValue: [1.1, 2.2, 3.3],
    );
    expect(column.sqlSnippet,
        '"column_name" decimal[] NOT NULL DEFAULT \'{1.1, 2.2, 3.3}\'');
  });

  test('5.12 decimal array column with default & args', () {
    final column = DecimalColumn.array(
      'column_name',
      defaultArrayValue: [1.1, 2.2, 3.3],
      precision: 3,
      scale: 2,
    );
    expect(column.sqlSnippet,
        '"column_name" decimal(3, 2)[] NOT NULL DEFAULT \'{1.1, 2.2, 3.3}\'');
  });

  test('6.1 real simple column', () {
    final column = RealColumn('column_name');
    expect(column.sqlSnippet, '"column_name" real NOT NULL');
  });

  test('6.2 real column with default', () {
    final column = RealColumn('column_name', defaultValue: 2);
    expect(column.sqlSnippet, '"column_name" real NOT NULL DEFAULT 2.0');
  });

  test('6.3 real array column', () {
    final column = RealColumn.array('column_name');
    expect(column.sqlSnippet, '"column_name" real[] NOT NULL');
  });

  test('6.4 real array column with default', () {
    final column =
        RealColumn.array('column_name', defaultArrayValue: [1, 2, 3]);
    expect(column.sqlSnippet,
        '"column_name" real[] NOT NULL DEFAULT \'{1.0, 2.0, 3.0}\'');
  });

  test('7.1 double precision simple column', () {
    final column = DoublePrecisionColumn('column_name');
    expect(column.sqlSnippet, '"column_name" double precision NOT NULL');
  });

  test('7.2 double precision column with default', () {
    final column = DoublePrecisionColumn('column_name', defaultValue: 2);
    expect(column.sqlSnippet,
        '"column_name" double precision NOT NULL DEFAULT 2.0');
  });

  test('7.3 double precision array column', () {
    final column = DoublePrecisionColumn.array('column_name');
    expect(column.sqlSnippet, '"column_name" double precision[] NOT NULL');
  });

  test('7.4 double precision array column with default', () {
    final column = DoublePrecisionColumn.array('column_name',
        defaultArrayValue: [1, 2, 3]);
    expect(column.sqlSnippet,
        '"column_name" double precision[] NOT NULL DEFAULT \'{1.0, 2.0, 3.0}\'');
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
    final column = FloatColumn('column_name', defaultValue: 4.22);
    expect(column.sqlSnippet, '"column_name" float NOT NULL DEFAULT 4.22');
  });

  test('8.4 float array column', () {
    final column = FloatColumn.array('column_name');
    expect(column.sqlSnippet, '"column_name" float[] NOT NULL');
  });

  test('8.5 float array column with default', () {
    final column =
        FloatColumn.array('column_name', defaultArrayValue: [1, 2, 3]);
    expect(column.sqlSnippet,
        '"column_name" float[] NOT NULL DEFAULT \'{1.0, 2.0, 3.0}\'');
  });

  test('8.6 float array column with default & precision', () {
    final column = FloatColumn.array('column_name',
        precision: 3, defaultArrayValue: [1, 2, 3]);
    expect(column.sqlSnippet,
        '"column_name" float(3)[] NOT NULL DEFAULT \'{1.0, 2.0, 3.0}\'');
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

  test('12.1 uuid simple column', () {
    final column = UUIDColumn('column_name');
    expect(column.sqlSnippet, '"column_name" uuid NOT NULL');
  });

  test('12.2 uuid column with default', () {
    final column = UUIDColumn(
      'column_name',
      defaultValue: "a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11",
    );
    expect(column.sqlSnippet,
        '"column_name" uuid NOT NULL DEFAULT \'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11\'');
  });

  test('12.3 uuid array column', () {
    final column = UUIDColumn.array('column_name');
    expect(column.sqlSnippet, '"column_name" uuid[] NOT NULL');
  });

  test('12.4 uuid array column with default', () {
    final column = UUIDColumn.array('column_name', defaultArrayValue: [
      "a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11",
      "b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11",
      "c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11"
    ]);
    expect(
      column.sqlSnippet,
      '"column_name" uuid[] NOT NULL DEFAULT \'{"a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11", "b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11", "c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11"}\'',
    );
  });

  test('13.1 text simple column', () {
    final column = TextColumn('column_name');
    expect(column.sqlSnippet, '"column_name" text NOT NULL');
  });

  test('13.2 text column with default', () {
    final column = TextColumn('column_name', defaultValue: "default_value");
    expect(column.sqlSnippet,
        '"column_name" text NOT NULL DEFAULT \'default_value\'');
  });

  test('13.3 text array column', () {
    final column = TextColumn.array('column_name');
    expect(column.sqlSnippet, '"column_name" text[] NOT NULL');
  });

  test('13.4 text array column with default', () {
    final column =
        TextColumn.array('column_name', defaultArrayValue: ["1", "2", "3"]);
    expect(column.sqlSnippet,
        '"column_name" text[] NOT NULL DEFAULT \'{"1", "2", "3"}\'');
  });

  test('14.1 varchar simple column', () {
    final column = VarcharColumn('column_name');
    expect(column.sqlSnippet, '"column_name" varchar NOT NULL');
  });

  test('14.2 varchar column with max length', () {
    final column = VarcharColumn('column_name', maxLength: 3);
    expect(column.sqlSnippet, '"column_name" varchar(3) NOT NULL');
  });

  test('14.3 varchar column with default', () {
    final column = VarcharColumn('column_name', defaultValue: "default_value");
    expect(column.sqlSnippet,
        '"column_name" varchar NOT NULL DEFAULT \'default_value\'');
  });

  test('14.4 varchar array column', () {
    final column = VarcharColumn.array('column_name');
    expect(column.sqlSnippet, '"column_name" varchar[] NOT NULL');
  });

  test('14.5 varchar array column with default', () {
    final column = VarcharColumn.array(
      'column_name',
      defaultArrayValue: ["1", "2", "3"],
    );
    expect(column.sqlSnippet,
        '"column_name" varchar[] NOT NULL DEFAULT \'{"1", "2", "3"}\'');
  });

  test('14.6 varchar array column with default & max length', () {
    final column = VarcharColumn.array('column_name',
        maxLength: 3, defaultArrayValue: ["1", "2", "3"]);
    expect(column.sqlSnippet,
        '"column_name" varchar(3)[] NOT NULL DEFAULT \'{"1", "2", "3"}\'');
  });

  test('15.1 char simple column', () {
    final column = CharColumn('column_name');
    expect(column.sqlSnippet, '"column_name" char NOT NULL');
  });

  test('15.2 char column with length', () {
    final column = CharColumn('column_name', length: 3);
    expect(column.sqlSnippet, '"column_name" char(3) NOT NULL');
  });

  test('15.3 char column with default', () {
    final column = CharColumn('column_name', defaultValue: "4.22");
    expect(column.sqlSnippet, '"column_name" char NOT NULL DEFAULT \'4.22\'');
  });

  test('15.4 char array column', () {
    final column = CharColumn.array('column_name');
    expect(column.sqlSnippet, '"column_name" char[] NOT NULL');
  });

  test('15.5 char array column with default', () {
    final column = CharColumn.array(
      'column_name',
      defaultArrayValue: ["1", "2", "3"],
    );
    expect(column.sqlSnippet,
        '"column_name" char[] NOT NULL DEFAULT \'{"1", "2", "3"}\'');
  });

  test('15.6 char array column with default & max length', () {
    final column = CharColumn.array('column_name',
        length: 3, defaultArrayValue: ["1", "2", "3"]);
    expect(column.sqlSnippet,
        '"column_name" char(3)[] NOT NULL DEFAULT \'{"1", "2", "3"}\'');
  });

  test('16.1 boolean simple column', () {
    final column = BooleanColumn('column_name');
    expect(column.sqlSnippet, '"column_name" boolean NOT NULL');
  });

  test('16.2 boolean column with default true', () {
    final column = BooleanColumn('column_name', defaultValue: true);
    expect(column.sqlSnippet, '"column_name" boolean NOT NULL DEFAULT true');
  });

  test('16.3 boolean column with default false', () {
    final column = BooleanColumn('column_name', defaultValue: false);
    expect(column.sqlSnippet, '"column_name" boolean NOT NULL DEFAULT false');
  });

  test('16.4 boolean array column', () {
    final column = BooleanColumn.array('column_name');
    expect(column.sqlSnippet, '"column_name" boolean[] NOT NULL');
  });

  test('16.5 boolean array column with default', () {
    final column = BooleanColumn.array('column_name',
        defaultArrayValue: [true, false, true]);
    expect(column.sqlSnippet,
        '"column_name" boolean[] NOT NULL DEFAULT \'{true, false, true}\'');
  });

  test('17.1 timestamp simple column', () {
    final column = TimestampColumn('column_name');
    expect(column.sqlSnippet, '"column_name" timestamp NOT NULL');
  });

  test('17.2 timestamp column with default', () {
    final column = TimestampColumn(
      'column_name',
      defaultValue: DateTime(2022, 02, 30),
    );
    expect(column.sqlSnippet,
        '"column_name" timestamp NOT NULL DEFAULT \'2022-03-02 00:00:00.000\'');
  });

  test('17.3 timestamp column with defaultToCurrentTimestamp', () {
    final column = TimestampColumn(
      'column_name',
      defaultToCurrentTimeStamp: true,
    );
    expect(column.sqlSnippet, '"column_name" timestamp NOT NULL DEFAULT now()');
  });

  test('17.4 timestamp column with default defaultToCurrentTimestampInUTC', () {
    final column =
        TimestampColumn('column_name', defaultToCurrentTimestampInUTC: true);
    expect(column.sqlSnippet,
        '"column_name" timestamp NOT NULL DEFAULT timezone(\'utc\', now())');
  });

  test('17.5 timestamp column default vs defaultToCurrentTimestamp', () {
    final column = TimestampColumn(
      'column_name',
      defaultToCurrentTimeStamp: true,
      defaultValue: DateTime(0),
    );
    expect(column.sqlSnippet, '"column_name" timestamp NOT NULL DEFAULT now()');
  });

  test(
      '17.6 timestamp column default vs defaultToCurrentTimestamp vs defaultToCurrentTimestampInUTC',
      () {
    final column = TimestampColumn(
      'column_name',
      defaultToCurrentTimeStamp: true,
      defaultToCurrentTimestampInUTC: true,
      defaultValue: DateTime(0),
    );
    expect(column.sqlSnippet,
        '"column_name" timestamp NOT NULL DEFAULT timezone(\'utc\', now())');
  });

  test('17.7 timestamp array column', () {
    final column = TimestampColumn.array('column_name');
    expect(column.sqlSnippet, '"column_name" timestamp[] NOT NULL');
  });

  test('17.8 timestamp array column with precision', () {
    final column = TimestampColumn.array('column_name', precision: 2);
    expect(column.sqlSnippet, '"column_name" timestamp(2)[] NOT NULL');
  });

  test('17.9 timestamp array column with default', () {
    final column = TimestampColumn.array(
      'column_name',
      defaultArrayValue: [DateTime(2022, 02, 30), DateTime(2022, 02, 30)],
    );
    expect(column.sqlSnippet,
        '"column_name" timestamp[] NOT NULL DEFAULT \'{"2022-03-02 00:00:00.000", "2022-03-02 00:00:00.000"}\'');
  });

  test('18.1 timestamp with time zone simple column', () {
    final column = TimestampWithTimeZoneColumn('column_name');
    expect(
        column.sqlSnippet, '"column_name" timestamp with time zone NOT NULL');
  });

  test('18.2 timestamp with time zone column with default', () {
    final column = TimestampWithTimeZoneColumn(
      'column_name',
      defaultValue: DateTime.parse("2022-06-07 12:00:00.000+02"),
    );
    expect(column.sqlSnippet,
        '"column_name" timestamp with time zone NOT NULL DEFAULT \'2022-06-07T10:00:00.000Z\'');
  });

  test('18.3 timestamp with time zone column with defaultToCurrentTimestamp',
      () {
    final column = TimestampWithTimeZoneColumn(
      'column_name',
      defaultToCurrentTimeStamp: true,
    );
    expect(column.sqlSnippet,
        '"column_name" timestamp with time zone NOT NULL DEFAULT now()');
  });

  test(
      '18.4 timestamp with time zone column default vs defaultToCurrentTimestamp + precision',
      () {
    final column = TimestampWithTimeZoneColumn(
      'column_name',
      precision: 2,
      defaultToCurrentTimeStamp: true,
      defaultValue: DateTime(0),
    );
    expect(column.sqlSnippet,
        '"column_name" timestamp(2) with time zone NOT NULL DEFAULT now()');
  });

  test('18.5 timestamp with time zone array column', () {
    final column = TimestampWithTimeZoneColumn.array('column_name');
    expect(
        column.sqlSnippet, '"column_name" timestamp with time zone[] NOT NULL');
  });

  test('18.6 timestamp with time zone array column with precision', () {
    final column =
        TimestampWithTimeZoneColumn.array('column_name', precision: 2);
    expect(column.sqlSnippet,
        '"column_name" timestamp(2) with time zone[] NOT NULL');
  });

  test('18.7 timestamp with time zone array column with default', () {
    final column = TimestampWithTimeZoneColumn.array(
      'column_name',
      defaultArrayValue: [DateTime(2022, 02, 30), DateTime(2022, 02, 30)],
    );
    expect(column.sqlSnippet,
        '"column_name" timestamp with time zone[] NOT NULL DEFAULT \'{"2022-03-01T23:00:00.000Z", "2022-03-01T23:00:00.000Z"}\'');
  });

  test('19.1 date simple column', () {
    final column = DateColumn('column_name');
    expect(column.sqlSnippet, '"column_name" date NOT NULL');
  });

  test('19.2 date column with default', () {
    final column = DateColumn(
      'column_name',
      defaultValue: DateTime(2022, 02, 30),
    );
    expect(column.sqlSnippet,
        '"column_name" date NOT NULL DEFAULT \'2022-03-02 00:00:00.000\'');
  });

  test('19.3 date column with defaultToCurrentDate', () {
    final column = DateColumn(
      'column_name',
      defaultToCurrentDate: true,
    );
    expect(column.sqlSnippet, '"column_name" date NOT NULL DEFAULT now()');
  });

  test('19.4 date column with default defaultToCurrentDateInUTC', () {
    final column = DateColumn(
      'column_name',
      defaultToCurrentDateInUTC: true,
    );
    expect(column.sqlSnippet,
        '"column_name" date NOT NULL DEFAULT timezone(\'utc\', now())');
  });

  test('19.5 date column default vs defaultToCurrentDate', () {
    final column = DateColumn(
      'column_name',
      defaultToCurrentDate: true,
      defaultValue: DateTime(0),
    );
    expect(column.sqlSnippet, '"column_name" date NOT NULL DEFAULT now()');
  });

  test(
      '19.6 date column default vs defaultToCurrentDate vs defaultToCurrentDateInUTC',
      () {
    final column = DateColumn(
      'column_name',
      defaultToCurrentDate: true,
      defaultToCurrentDateInUTC: true,
      defaultValue: DateTime(0),
    );
    expect(column.sqlSnippet,
        '"column_name" date NOT NULL DEFAULT timezone(\'utc\', now())');
  });

  test('19.7 date array column', () {
    final column = DateColumn.array('column_name');
    expect(column.sqlSnippet, '"column_name" date[] NOT NULL');
  });

  test('19.8 date array column with default', () {
    final column = DateColumn.array(
      'column_name',
      defaultArrayValue: [DateTime(2022, 02, 30), DateTime(2022, 02, 30)],
    );
    expect(column.sqlSnippet,
        '"column_name" date[] NOT NULL DEFAULT \'{"2022-03-02 00:00:00.000", "2022-03-02 00:00:00.000"}\'');
  });

  test('20.1 interval simple column', () {
    final column = IntervalColumn('column_name');
    expect(column.sqlSnippet, '"column_name" interval NOT NULL');
  });

  test('20.2 interval column with empty default', () {
    final column = IntervalColumn(
      'column_name',
      defaultValue: Interval(),
    );
    expect(column.sqlSnippet, '"column_name" interval NOT NULL DEFAULT \'0\'');
  });

  test('20.3 interval column with year only', () {
    final column = IntervalColumn(
      'column_name',
      defaultValue: Interval(year: 1),
    );
    expect(column.sqlSnippet,
        '"column_name" interval NOT NULL DEFAULT \'1 year\'');
  });

  test('20.4 interval column with default', () {
    final column = IntervalColumn(
      'column_name',
      defaultValue: Interval(
        millennium: 1,
        century: 2,
        decade: 3,
        year: 4,
        month: 5,
        week: 6,
        day: 7,
        hour: 8,
        minute: 9,
        second: 10,
        millisecond: 11,
        microsecond: 12,
      ),
    );
    expect(column.sqlSnippet,
        '"column_name" interval NOT NULL DEFAULT \'1 millennium 2 century 3 decade 4 year 5 month 6 week 7 day 8 hour 9 minute 10 second 11 millisecond 12 microsecond\'');
  });

  test('20.5 interval array column', () {
    final column = IntervalColumn.array('column_name');
    expect(column.sqlSnippet, '"column_name" interval[] NOT NULL');
  });

  test('20.6 interval array column with default', () {
    final column = IntervalColumn.array(
      'column_name',
      defaultArrayValue: [
        Interval(
          millennium: 1,
          century: 2,
          decade: 3,
          year: 4,
          month: 5,
          week: 6,
          day: 7,
          hour: 8,
          minute: 9,
          second: 10,
          millisecond: 11,
          microsecond: 12,
        ),
        Interval(
          millennium: 1,
          century: 2,
          decade: 3,
          year: 4,
          month: 5,
        ),
      ],
    );
    expect(column.sqlSnippet,
        '"column_name" interval[] NOT NULL DEFAULT \'{"1 millennium 2 century 3 decade 4 year 5 month 6 week 7 day 8 hour 9 minute 10 second 11 millisecond 12 microsecond", "1 millennium 2 century 3 decade 4 year 5 month"}\'');
  });

  test('21.1 enum simple column', () {
    final column = EnumColumn('column_name', enumName: "test_enum");
    expect(column.sqlSnippet, '"column_name" test_enum NOT NULL');
  });

  test('21.2 enum column with default', () {
    final column = EnumColumn(
      'column_name',
      enumName: "test_enum",
      defaultValue: TestEnum.firstValue,
    );
    expect(column.sqlSnippet,
        '"column_name" test_enum NOT NULL DEFAULT \'firstValue\'');
  });

  test('21.3 enum array column', () {
    final column = EnumColumn.array('column_name', enumName: "test_enum");
    expect(column.sqlSnippet, '"column_name" test_enum[] NOT NULL');
  });

  test('21.4 enum array column with default', () {
    final column = EnumColumn.array('column_name',
        enumName: "test_enum", defaultArrayValue: TestEnum.values);
    expect(
      column.sqlSnippet,
      '"column_name" test_enum[] NOT NULL DEFAULT \'{\'firstValue\', \'secondValue\', \'thirdValue\'}\'',
    );
  });
}

/// Simple enum implementation for [EnumColumn] tests
enum TestEnum { firstValue, secondValue, thirdValue }
