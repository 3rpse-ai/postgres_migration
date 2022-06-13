import '../column.dart';

/// Column for small-range integers
///
/// Supports range from -32768 to +32767
class SmallIntColumn extends Column<int> {
  @override
  String get type => "smallint";

  SmallIntColumn(
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

  SmallIntColumn.array(
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
    super.defaultArrayValue,
  }) : super.array();
}

/// Column for mid-range integers
///
/// Typical choice for integer
///
/// Supports range from -2147483648 to +2147483647
class IntegerColumn extends Column<int> {
  @override
  String get type => "integer";

  IntegerColumn(
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

  IntegerColumn.array(
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
    super.defaultArrayValue,
  }) : super.array();
}

/// Column for large-range integers
///
/// Supports range from -9223372036854775808 to +9223372036854775807
class BigIntColumn extends Column<int> {
  @override
  String get type => "bigint";

  BigIntColumn(
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

  BigIntColumn.array(
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
    super.defaultArrayValue,
  }) : super.array();
}

/// Column for storing numbers with large number of digits
///
/// Default value supports `double.infinity` & `double.negativeInfinity` & `double.nan`
///
/// The precision of a numeric is the total count of significant digits in the whole number, that is, the number of digits to both sides of the decimal point.
///
/// The scale of a numeric is the count of decimal digits in the fractional part, to the right of the decimal point.
///
/// So the number 23.5141 has a precision of 6 and a scale of 4. Integers can be considered to have a scale of zero.
class NumericColumn extends Column<double> {
  @override
  String get type {
    return "numeric";
  }

  @override
  String convertInputValueToString(double inputValue) {
    if ((precision != null && scale == null) || scale == 0) {
      final asString = inputValue.toString();
      final inputValueAsInt = int.parse(
        asString.substring(0, asString.length - 2),
      );
      return inputValueAsInt.toString();
    }
    if (inputValue == double.infinity) {
      return "'INFINITY'";
    }
    if (inputValue == double.negativeInfinity) {
      return "'-INFINITY'";
    }
    if (inputValue.isNaN) {
      return "'NaN'";
    }
    return inputValue.toString();
  }

  /// The precision of a numeric is the total count of significant digits in the whole number, that is, the number of digits to both sides of the decimal point.
  int? precision;

  /// The scale of a numeric is the count of decimal digits in the fractional part, to the right of the decimal point.
  ///
  /// The scale cannot be defined without defining the precision.
  int? scale;
  NumericColumn(
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
    this.precision,
    this.scale,
  }) : super(
          // precision must always be provided if scale is provided.
          args: (precision != null || (scale != null && precision != null))
              ? [
                  precision,
                  if (scale != null) scale,
                ].join(", ")
              : null,
        );

  NumericColumn.array(
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
    super.defaultArrayValue,
    this.precision,
    this.scale,
  }) : super.array(
          // precision must always be provided if scale is provided.
          args: (precision != null || (scale != null && precision != null))
              ? [
                  precision,
                  if (scale != null) scale,
                ].join(", ")
              : null,
        );
}

/// Column for storing numbers with large number of digits
///
/// Interchangabel with NumericColumn. In fact this class simply extends from NumericColumn
///
/// Default value supports `double.infinity` & `double.negativeInfinity` & `double.nan`
///
/// The precision of a decimal is the total count of significant digits in the whole number, that is, the number of digits to both sides of the decimal point.
///
/// The scale of a decimal is the count of decimal digits in the fractional part, to the right of the decimal point.
///
/// So the number 23.5141 has a precision of 6 and a scale of 4. Integers can be considered to have a scale of zero.
class DecimalColumn extends NumericColumn {
  @override
  String get type {
    final type = super.type;
    // just reusing [NumericColumn] implementation here.
    return type.replaceAll('numeric', 'decimal');
  }

  DecimalColumn(
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
    super.precision,
    super.scale,
  });

  DecimalColumn.array(
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
    super.defaultArrayValue,
    super.precision,
    super.scale,
  }) : super.array();
}

/// Column for storing inexact decimal numbers
///
/// The data types real and double precision are inexact, variable-precision numeric types.
///
/// The real type has a range of around `1E-37` to `1E+37` with a precision of at least 6 digits.
class RealColumn extends Column<double> {
  @override
  String get type => "real";

  RealColumn(
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

  RealColumn.array(
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
    super.defaultArrayValue,
  }) : super.array();
}

/// Column for storing inexact decimal numbers
///
/// The data types real and double precision are inexact, variable-precision numeric types.
///
/// The double precision type has a range of around `1E-307` to `1E+308` with a precision of at least 15 digits.
class DoublePrecisionColumn extends Column<double> {
  @override
  String get type => "double precision";

  DoublePrecisionColumn(
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

  DoublePrecisionColumn.array(
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
    super.defaultArrayValue,
  }) : super.array();
}

/// Column for specifying inexact numeric types.
///
/// The minimum acceptable precision in binary digits can be specified.
///
/// PostgreSQL accepts float(1) to float(24) as selecting the real type, while float(25) to float(53) select double precision.
///
/// float with no precision specified is taken to mean double precision.
class FloatColumn extends Column<double> {
  int? precision;

  @override
  String get type => "float";

  FloatColumn(
    super.name, {
    this.precision,
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
  }) : super(args: precision?.toString());

  FloatColumn.array(
    super.name, {
    this.precision,
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
    super.defaultArrayValue,
  }) : super.array(args: precision?.toString());
}

/// Column for creating auto incrementing small integers
class SmallSerialColumn extends Column<int> {
  @override
  String get type => 'smallserial';

  SmallSerialColumn(
    super.name, {
    super.isPrimaryKey = false,
    super.isUnique = false,
    super.foreignKeyForTable,
    super.foreignKeyConstraint,
    super.checkConstraint,
    super.manualConstraint,
    super.primaryKeyConstraint,
    super.uniqueConstraint,
  }) : super(isNullable: true);
}

/// Column for creating auto incrementing integers
class SerialColumn extends Column<int> {
  @override
  String get type => 'serial';

  SerialColumn(
    super.name, {
    super.isPrimaryKey = false,
    super.isUnique = false,
    super.foreignKeyForTable,
    super.foreignKeyConstraint,
    super.checkConstraint,
    super.manualConstraint,
    super.primaryKeyConstraint,
    super.uniqueConstraint,
  }) : super(isNullable: true);
}

/// Column for creating auto incrementing big integers
class BigSerialColumn extends Column<int> {
  @override
  String get type => 'bigserial';

  BigSerialColumn(
    super.name, {
    super.isPrimaryKey = false,
    super.isUnique = false,
    super.foreignKeyForTable,
    super.foreignKeyConstraint,
    super.checkConstraint,
    super.manualConstraint,
    super.primaryKeyConstraint,
    super.uniqueConstraint,
  }) : super(isNullable: true);
}
