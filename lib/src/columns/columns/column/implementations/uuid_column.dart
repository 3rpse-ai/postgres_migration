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

  UUIDColumn.array(
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
