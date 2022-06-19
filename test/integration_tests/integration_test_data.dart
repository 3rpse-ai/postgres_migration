import 'package:postgres_migration/postgres_migration.dart';

final tableCreationTestData = {
  "Test Table Without Columns": {"simple": List<TableProperty>.empty()},
  "Test Numeric Columns": {
    "Simple": [
      SmallIntColumn('small_int_column'),
      IntegerColumn('int_column'),
      BigIntColumn('big_int_column'),
      SmallSerialColumn('small_serial_column)'),
      SerialColumn('serial_column)'),
      BigSerialColumn('big_serial_column)'),
      FloatColumn('float_column'),
      DoublePrecisionColumn('double_column'),
      NumericColumn('numeric_column'),
      DecimalColumn('decimal_column'),
      RealColumn('real_column'),
    ],
    "With Arguments": [
      SmallIntColumn('small_int_column'),
      IntegerColumn('int_column'),
      BigIntColumn('big_int_column'),
      SmallSerialColumn('small_serial_column)'),
      SerialColumn('serial_column)'),
      BigSerialColumn('big_serial_column)'),
      FloatColumn('float_column', precision: 4),
      DoublePrecisionColumn('double_column'),
      NumericColumn('numeric_column', precision: 4, scale: 2),
      DecimalColumn('decimal_column', precision: 4, scale: 2),
      RealColumn('real_column'),
    ],
    "With Default": [
      SmallIntColumn('small_int_column', defaultValue: 3),
      IntegerColumn('int_column', defaultValue: 3),
      BigIntColumn('big_int_column', defaultValue: 3),
      SmallSerialColumn('small_serial_column)'),
      SerialColumn('serial_column)'),
      BigSerialColumn('big_serial_column)'),
      FloatColumn('float_column', precision: 4, defaultValue: 1.1),
      DoublePrecisionColumn('double_column', defaultValue: 2),
      NumericColumn('numeric_column',
          precision: 4, scale: 2, defaultValue: 2.2),
      DecimalColumn('decimal_column', precision: 4, scale: 2, defaultValue: 4),
      RealColumn('real_column', defaultValue: 1.555),
    ],
    "With Constraints": [
      SmallIntColumn('small_int_column', isNullable: true),
      IntegerColumn('int_column', isPrimaryKey: true),
      BigIntColumn('big_int_column', isUnique: true),
      SmallSerialColumn('small_serial_column)', isUnique: true),
      SerialColumn('serial_column'),
      BigSerialColumn('big_serial_column)'),
      FloatColumn('float_column',
          isUnique: true,
          checkConstraint:
              CheckConstraint(check: "serial_column < small_int_column")),
      DoublePrecisionColumn(
        'double_column',
        isUnique: true,
      ),
      NumericColumn('numeric_column', isUnique: true),
      DecimalColumn('decimal_column', isUnique: true),
      RealColumn('real_column', isUnique: true),
    ],
  },
  "Test Text Columns": {
    "Simple": [
      TextColumn("text_column"),
      CharColumn("char_column"),
      VarcharColumn("varchar_column"),
    ],
    "With Arguments": [
      TextColumn("text_column"),
      CharColumn("char_column", length: 16),
      VarcharColumn("varchar_column", maxLength: 12),
    ],
    "With Default": [
      TextColumn("text_column", defaultValue: "my default"),
      CharColumn("char_column", defaultValue: "my default"),
      VarcharColumn("varchar_column", defaultValue: "my default"),
    ],
    "With Constraints": [
      TextColumn("text_column", isNullable: false),
      CharColumn("char_column", isPrimaryKey: true),
      VarcharColumn("varchar_column", isUnique: true),
    ],
  },
  "Test Boolean Columns": {
    "Simple": [
      BooleanColumn("bool_column"),
    ],
    "With Default": [
      BooleanColumn("bool_column", defaultValue: true),
      BooleanColumn("bool_column_2", defaultValue: false),
    ],
    "With Constraints": [
      BooleanColumn("bool_column", isPrimaryKey: true),
      BooleanColumn("bool_column_2", isUnique: true),
      BooleanColumn("bool_column_3", isNullable: false),
    ]
  },
  "Test UUID Columns": {
    "Simple": [
      UUIDColumn("uuid_column"),
    ],
    "With Default": [
      UUIDColumn("uuid_column",
          defaultValue: "12345678-1234-1234-1234-123456789012"),
    ],
    "With Constraints": [
      UUIDColumn("uuid_column", isPrimaryKey: true),
      UUIDColumn("uuid_column_2", isUnique: true),
      UUIDColumn("uuid_column_3", isNullable: false),
    ],
  },
  "Test DateTime Columns": {
    "Simple": [
      TimestampColumn("timestamp_column"),
      TimestampWithTimeZoneColumn("timestamp_w_tz_column"),
      DateColumn("date_column"),
      IntervalColumn("interval_column"),
    ],
    "With Arguments": [
      TimestampColumn("timestamp_column", precision: 4),
      TimestampWithTimeZoneColumn("timestamp_w_tz_column", precision: 10),
      DateColumn("date_column"),
      IntervalColumn("interval_column"),
    ],
    "With Default": [
      TimestampColumn("timestamp_column", defaultToCurrentTimeStamp: true),
      TimestampColumn("timestamp_column_2",
          defaultToCurrentTimestampInUTC: true),
      TimestampColumn("timestamp_column_3", defaultValue: DateTime.now()),
      TimestampWithTimeZoneColumn(
        "timestamp_w_tz_column",
        defaultToCurrentTimeStamp: true,
      ),
      TimestampWithTimeZoneColumn(
        "timestamp_w_tz_column_2",
        defaultValue: DateTime.now(),
      ),
      DateColumn("date_column", defaultToCurrentDate: true),
      DateColumn("date_column_2", defaultToCurrentDateInUTC: true),
      DateColumn("date_column_3", defaultValue: DateTime.now()),
      IntervalColumn("interval_column", defaultValue: Interval(century: 1)),
    ],
    "With Constraints": [
      TimestampColumn("timestamp_column", isPrimaryKey: true),
      TimestampWithTimeZoneColumn("timestamp_w_tz_column", isUnique: true),
      DateColumn("date_column", isNullable: false),
      IntervalColumn("interval_column", isUnique: true),
    ],
  },
};
