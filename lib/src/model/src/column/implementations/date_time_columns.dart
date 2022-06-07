import '../column.dart';

/// Column for defining a timestamp (equivalent of dart DateTime)
///
/// Use the `precision` argument to specify the number of fractional digits retained in the seconds field.
///
/// Be aware that when setting a default / inserting values no timezone will be respected.
/// Hence one must ensure (especially when used with different clients) that the time inputs are normalized.
///
/// Providing `DateTime.now()` as default value will result in the **localized** time when the migration is run being used as default. This is likely undesired. Use `defaultToCurrentTimeStamp`instead if a dynamic default is desired.
///
/// For defaulting to the current time stamp of the transaction (on e.g every insert) on the sql server, use the `defaultToCurrentTimestamp` option. This can again yield different results as opposed to the [TimestampWithTimeZoneColumn] implementation (as it is not defaulting to UTC).
/// Use `defaultToCurrentTimestampInUTC` to avoid using the sql server's localized time.
///
/// Please note that Postgresql `time` type is not supported as there is no native mapping in pure dart. In case you want to support this type you could use the [DateOfTime] class from the Flutter framework and extend the [Column] class.
class TimestampColumn extends Column<DateTime> {
  /// Set this flag to default to the corresponding transaction's current timestamp in the sql server's localized time. If this is set [defaultValue] will be ignored.
  bool defaultToCurrentTimeStamp;

  /// Set this flag to default to the corresponding transaction's current timestamp in UTC. If this is set, [defaultToCurrentTimeStamp] && [defaultValue] will be ignored.
  bool defaultToCurrentTimestampInUTC;

  @override
  String get type => 'timestamp';

  @override
  String get defaultValueAsString {
    if (defaultToCurrentTimestampInUTC) {
      return "timezone('utc', now())";
    }
    if (defaultToCurrentTimeStamp) {
      return "now()";
    }
    return "'${super.defaultValueAsString}'";
  }

  TimestampColumn(
    super.name, {
    int? precision,
    this.defaultToCurrentTimeStamp = false,
    this.defaultToCurrentTimestampInUTC = false,
    super.isNullable = false,
    super.manualDefaultValue,
    super.isPrimaryKey = false,
    super.isUnique = false,
    super.foreignKeyForTable,
    super.foreignKeyConstraint,
    super.checkConstraint,
    super.manualConstraint,
    super.primaryKeyConstraint,
    super.uniqueConstraint,
    super.defaultValue,
  }) : super(
          args: precision?.toString(),
          forceIncludeDefaultValue:
              defaultToCurrentTimeStamp || defaultToCurrentTimestampInUTC,
        );
}

/// Column for defining a timestamp (equivalent of dart DateTime) respecting time zones.
///
/// Use the `precision` argument to specify the number of fractional digits retained in the seconds field.
///
/// Note that using `DateTime(...)` will yield different results to `DateTime.utc(...)` depending on the client's timezone. This is important to consider when providing a default value.
/// Providing `DateTime.now()` as default value will result in the time when the migration is run being used as default. This is likely undesired. Use `defaultToCurrentTimeStamp`instead if a dynamic default is desired.
///
/// For defaulting to the current time stamp of the transaction (on e.g every insert) on the sql server, use the `defaultToCurrentTimestamp` option. This will respect the sql server's local timezone effectively storing the value in UTC.
///
/// Please note that Postgresql `time with time zone` type is not supported as there is no native mapping in pure dart. In case you want to support this type you could use the [DateOfTime] class from Flutter framework and extend the [Column] class.
class TimestampWithTimeZoneColumn extends Column<DateTime> {
  /// Set this flag to default to the corresponding transaction's current timestamp in the sql server's localized time (which is converted to & stored in UTC). If this is set [defaultValue] will be ignored.
  bool defaultToCurrentTimeStamp;

  @override
  String get type => 'timestamp with time zone';

  @override
  String get defaultValueAsString {
    if (defaultToCurrentTimeStamp) {
      return "now()";
    }
    // Conversion toUtc() is needed to yield a timezone delacring String when constructing a DateTime without timezone information.
    return "'${(defaultValue?.toUtc().toIso8601String()).toString()}'";
  }

  TimestampWithTimeZoneColumn(
    super.name, {
    int? precision,
    this.defaultToCurrentTimeStamp = false,
    super.isNullable = false,
    super.manualDefaultValue,
    super.isPrimaryKey = false,
    super.isUnique = false,
    super.foreignKeyForTable,
    super.foreignKeyConstraint,
    super.checkConstraint,
    super.manualConstraint,
    super.primaryKeyConstraint,
    super.uniqueConstraint,
    super.defaultValue,
  }) : super(
          args: precision?.toString(),
          forceIncludeDefaultValue: defaultToCurrentTimeStamp,
        );
}

/// Column for defining a date.
///
/// When providing a default [DateTime] value time will be effectively ignored.
///
/// Providing `DateTime.now()` as default value will result in the date when the migration is run being used as default. This is likely undesired. Use `defaultToCurrentDate`instead if a dynamic default is desired. Use `defaultToCurrentDateInUTC` to avoid using the sql server's localized time.
///
/// For defaulting to the current date of the transaction (on e.g every insert) on the sql server, use the `defaultToCurrentDate` option. This will however default to the server's current date which can differ from UTC.
class DateColumn extends Column<DateTime> {
  /// Set this flag to default to the corresponding transaction's current date in the sql server's localized time. If this is set [defaultValue] will be ignored.
  bool defaultToCurrentDate;

  /// Set this flag to default to the corresponding transaction's current date in UTC. If this is set, [defaultToCurrentDate] && [defaultValue] will be ignored.
  bool defaultToCurrentDateInUTC;

  @override
  String get type => 'date';

  @override
  String get defaultValueAsString {
    if (defaultToCurrentDateInUTC) {
      return "timezone('utc', now())";
    }
    if (defaultToCurrentDate) {
      return "now()";
    }
    return "'${super.defaultValueAsString}'";
  }

  DateColumn(
    super.name, {
    this.defaultToCurrentDate = false,
    this.defaultToCurrentDateInUTC = false,
    super.isNullable = false,
    super.manualDefaultValue,
    super.isPrimaryKey = false,
    super.isUnique = false,
    super.foreignKeyForTable,
    super.foreignKeyConstraint,
    super.checkConstraint,
    super.manualConstraint,
    super.primaryKeyConstraint,
    super.uniqueConstraint,
    super.defaultValue,
  }) : super(
          forceIncludeDefaultValue:
              defaultToCurrentDate || defaultToCurrentDateInUTC,
        );
}

class IntervalColumn extends Column<Interval> {
  @override
  String get type => 'interval';

  @override
  String get defaultValueAsString => "'${super.defaultValueAsString}'";

  IntervalColumn(
    super.name, {
    super.isNullable = false,
    super.manualDefaultValue,
    super.isPrimaryKey = false,
    super.isUnique = false,
    super.foreignKeyForTable,
    super.foreignKeyConstraint,
    super.checkConstraint,
    super.manualConstraint,
    super.primaryKeyConstraint,
    super.uniqueConstraint,
    super.defaultValue,
  });
}

/// Represents the Postgresql Interval type
class Interval {
  int? millennium;
  int? century;
  int? decade;
  int? year;
  int? month;
  int? week;
  int? day;
  int? hour;
  int? minute;
  int? second;
  int? millisecond;
  int? microsecond;

  Interval({
    this.millennium,
    this.century,
    this.decade,
    this.year,
    this.month,
    this.week,
    this.day,
    this.hour,
    this.minute,
    this.second,
    this.millisecond,
    this.microsecond,
  });

  @override
  String toString() {
    final units = [
      if (millennium != null) "$millennium millennium",
      if (century != null) "$century century",
      if (decade != null) "$decade decade",
      if (year != null) "$year year",
      if (month != null) "$month month",
      if (week != null) "$week week",
      if (day != null) "$day day",
      if (hour != null) "$hour hour",
      if (minute != null) "$minute minute",
      if (second != null) "$second second",
      if (millisecond != null) "$millisecond millisecond",
      if (microsecond != null) "$microsecond microsecond",
    ];
    String intervalString = units.join(" ");
    return intervalString.isEmpty ? "0" : intervalString;
  }
}
