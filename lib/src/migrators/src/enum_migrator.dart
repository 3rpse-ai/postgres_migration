/// Class with convenience methods for handling enums:
/// * Create enum (direct String input or provide enum)
/// * Rename enum
/// * Drop enum
/// * Add value to existing enum (direct String input or provide enumValue)
/// * Rename enum value (direct String input or provide enumValue)
class EnumMigrator {
  /// Creates an sql snippet in the form of `CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy');`
  ///
  /// Pass enumValues via EnumName.values, and optionally pass an enum name (otherwise the runtimeType will be used)
  ///
  /// The enumValues List must not be empty
  ///
  /// In order to be explicit about different enum versions (having different set of values) bass them individually (or just pass them all at once if you are confident it won't change).
  /// * `createEnum([MoodEnum.sad, MoodEnum.ok, MoodEnum.happy], enumName: 'mood')`
  /// * `createEnum(MoodEnum.values, enumName: 'mood')`
  static String createEnum<T extends Enum>(List<T> enumValues,
      {String? enumName}) {
    String typeName = enumName ?? enumValues.first.runtimeType.toString();
    List<String> valueNames =
        enumValues.map((value) => "'${value.name}'").toList();
    String valueNamesString = valueNames.join(", ");
    return 'CREATE TYPE $typeName AS ENUM ($valueNamesString)';
  }

  /// Creates an sql snippet in the form of `CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy');`
  ///
  /// The enumValues List must not be empty
  static String createEnumDirectInput(
      {required List<String> enumValues, required String enumName}) {
    List<String> valueNames = enumValues.map((value) => "'$value'").toList();
    String valueNamesString = valueNames.join(", ");
    return 'CREATE TYPE $enumName AS ENUM ($valueNamesString)';
  }

  /// Adds a value to an existing enum
  ///
  /// Creates an sql snippet in the form of `ALTER TYPE $enumName ADD VALUE [IF NOT EXISTS] $enumValue [BEFORE / AFTER] $referencedValue`
  ///
  /// Optionally pass an enum name (otherwise the runtimeType will be used)
  ///
  /// Pass `ifNotExists` arg to not throw an error if the value already exists
  ///
  /// Pass `beforeValue` **OR** `afterValue` arg to position the new value relative to the provided value.
  static String addEnumValue<T extends Enum>(
    T enumValue, {
    String? enumName,
    bool ifNotExists = false,
    T? beforeValue,
    T? afterValue,
  }) {
    String typeName = enumName ?? enumValue.runtimeType.toString();

    String preNameArgsString = ifNotExists ? " IF NOT EXISTS" : "";
    List<String> postNameArgs = [
      if (beforeValue != null) "BEFORE '${beforeValue.name}'",
      if (beforeValue == null && afterValue != null)
        "AFTER '${afterValue.name}'"
    ];

    String postNameArgsString =
        postNameArgs.isEmpty ? "" : " ${postNameArgs.join(" ")}";
    return "ALTER TYPE $typeName ADD VALUE$preNameArgsString '${enumValue.name}'$postNameArgsString";
  }

  /// Adds a value to an existing enum
  ///
  /// Creates an sql snippet in the form of `ALTER TYPE $enumName ADD VALUE [IF NOT EXISTS] $enumValue [BEFORE / AFTER] $referencedValue`
  ///
  /// Pass `ifNotExists` arg to not throw an error if the value already exists
  ///
  /// Pass `beforeValue` **OR** `afterValue` arg to position the new value relative to the provided value.
  static String addEnumValueDirectInput({
    required String enumValue,
    required String enumName,
    bool ifNotExists = false,
    String? beforeValue,
    String? afterValue,
  }) {
    String preNameArgsString = ifNotExists ? " IF NOT EXISTS" : "";
    List<String> postNameArgs = [
      if (beforeValue != null) "BEFORE '$beforeValue'",
      if (beforeValue == null && afterValue != null) "AFTER '$afterValue'"
    ];

    String postNameArgsString =
        postNameArgs.isEmpty ? "" : " ${postNameArgs.join(" ")}";
    return "ALTER TYPE $enumName ADD VALUE$preNameArgsString '$enumValue'$postNameArgsString";
  }

  /// Renames an enum
  static String renameEnum({required String oldName, required String newName}) {
    return "ALTER TYPE $oldName RENAME TO $newName";
  }

  /// Renames an enum value
  static String renameEnumValue<T extends Enum>(
      {required T oldValue, required T newValue, String? enumName}) {
    String typeName = enumName ?? oldValue.runtimeType.toString();
    return "ALTER TYPE $typeName RENAME VALUE '${oldValue.name}' TO '${newValue.name}'";
  }

  /// Renames an enum value
  static String renameEnumValueDirectInput(
      {required String oldValue,
      required String newValue,
      required String enumName}) {
    return "ALTER TYPE $enumName RENAME VALUE '$oldValue' TO '$newValue'";
  }

  /// Removes an enum type
  ///
  /// One can either set `cascade` **OR** `restrict` as argument.
  /// If both are provided only `cascade` is considered.
  static String dropEnum(
    String enumName, {
    bool ifExists = false,
    EnumDropMode? mode,
  }) {
    String preArgs = ifExists ? " IF EXISTS" : "";
    String postArgs = mode?.mode != null ? " ${mode!.mode}" : "";
    return "DROP TYPE$preArgs $enumName$postArgs";
  }
}

/// Mode defining how enum should be dropped
enum EnumDropMode {
  /// Automatically drop objects that depend on the enum (such as table columns, functions, and operators)
  cascade("CASCADE"),

  /// Refuse to drop the enum if any object depends on it.
  restrict("RESTRICT");

  /// SQL representation of the mode.
  final String mode;

  const EnumDropMode(this.mode);
}
