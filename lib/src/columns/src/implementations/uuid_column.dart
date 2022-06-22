import '../column.dart';

/// Column for storing  Universally Unique Identifiers (UUID) as defined by RFC 4122, ISO/IEC 9834-8:2005, and related standards.
///
/// Postgres does not provide any default creation of UUID values, hence this needs to be enabled by installing an extension on the sql server, or the server needs to handle it.
class UUIDColumn extends Column<String> {
  @override
  String get type => 'uuid';

  @override
  String convertInputValueToString(String inputValue) => "'$inputValue'";

  @override
  String convertArrayInputValueToString(String inputValue) => '"$inputValue"';

  UUIDColumn(
    super.name, {
    super.isPrimaryKey = false,
    super.foreignKeyForTable,
    super.isUnique = false,
    super.isNullable = false,
    super.constraints,
    super.defaultValue,
    super.manualDefaultValue,
  });

  UUIDColumn.array(
    super.name, {
    super.isPrimaryKey = false,
    super.foreignKeyForTable,
    super.isUnique = false,
    super.isNullable = false,
    super.constraints,
    super.defaultArrayValue,
    super.manualDefaultValue,
  }) : super.array();
}
