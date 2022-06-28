<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# DB Migrator
A dart package for generating sql strings for DB migrations. Makes use of darts type system to eliminate human error. No code generation required. 

## DB Support
As of now only postgres version 10 or higher is supported.  
It is planned to extend support to MySQL / MariaDB databases.

## Features
Targeted for postgres, supporting version >10.

* Create / Update / Delete Tables
    * Define columns
    * Define constraints
* Create / Update / Delete Columns
    * Set default values
    * Define constraints
* Create / Update / Delete Enums

## Getting started
To get started, add `db_migrator` as a dependency:

```shell
dart pub add db_migrator
```

Additionally add any db driver of your choice.  
E.g. postgres package:

```shell
dart pub add postgres
```

## Usage
`db_migrator` provides fine grained control over your db migrations. However it is not opionated on how to structure those. Rather it is a collection of many helper classes to create sql statements for common migration scenarios, eliminating human error. Which driver is best suited for those scenarios is up to the user.

### Tables
```dart
// Create a simple table
final exampleTable = TableMigrator("table_name");
String createTable = exampleTable.createTable();
```

```dart
// The create table statement takes constraints & columns as arguments.
// So you can declare the table directly with them.
final exampleTable = TableMigrator("table_name");
final integerColumn = IntegerColumn("column_name");
final checkConstraint = CheckConstraint(check: "column_name < 10");
final tableProperties = [integerColumn, checkConstraint];
String createTable = exampleTable.createTable(tableProperties);
```

```dart
// You can also alter tables with the TableMigrator class
final exampleTable = TableMigrator("table_name");
final newColumn = TimeStampColumn("new_column");
String updateTable = exampleTable.addColumn(newColumn);
```
### Column
```dart
// Create a simple column. Find the supported types below.
final exampleColumn = TextColumn("column_name");
```

```dart
// You can also set a default value on columns. 
// Provide manualDefaultValue if you want to provide a default string value which is directly interpolated into the sql statement
final exampleColumn = BooleanColumn(
    "column_name",
    defaultValue: true,
  );
```

```dart
// You can also set constraints on columns. There are a few convience arguments for that.
final exampleColumn = IntegerColumn(
    "column_name",
    isPrimaryKey: true,
    isUnique: true,
  );

// alternatively you can pass constraints for more granular control.
final exampleColumn = IntegerColumn(
    "column_name",
    constraints: ColumnConstraints(
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "other_table",
          deletionMode: ForeignKeyDeletionMode.cascade,
          name: "contraint_name",
        ),
      ),
  );
```

```dart
// Lastly, for enumColumns an EnumMigrator class is provided
enum TestEnum { first, second }

String createEnum = EnumMigrator.createEnum(
  TestEnum.values,
  enumName: "test_enum",
);

// Now after creating the enum making use of above statment we can use enum columns.
final enumColumn = EnumColumn(
  "enum_column_name",
  enumName: "test_enum",
  defaultValue: TestEnum.first,
);
```

## Supported postgres data types

### Numeric Types ✅
| Type             | Supported  |
|------------------|------------|
| smallint         | ✅         |
| integer          | ✅         |
| bigint           | ✅         |
| decimal          | ✅         |
| numeric          | ✅         |
| real             | ✅         |
| double precision | ✅         |
| smallserial      | ✅         |
| serial           | ✅         |
| bigserial        | ✅         |

### Character Types ✅
| Type    | Supported  |
|---------|------------|
| varchar | ✅         |
| char    | ✅         |
| text    | ✅         |

### Date/Time Types ☑️
| Type                     | Supported  |
|--------------------------|------------|
| timestamp                | ✅         |
| timestamp with time zone | ✅         |
| date                     | ✅         |
| time                     | ❌         |
| time with time zone      | ❌         |
| interval                 | ✅         |

### Boolean Types ✅
| Type    | Supported  |
|---------|------------|
| boolean | ✅         |

### Enumerated Types ✅
| Type | Supported  |
|------|------------|
| enum | ✅         |

### UUID Type ✅
| Type  | Supported  |
|-------|------------|
| uuid  | ✅         |

## Unsupported postgres data type categories
✅ On the roadmap  
🤔 Considering support  
❌ No support planned  

> 💡 You can easily support needed types by extending the abstract column class


| Type Category     | Support Planned  |
|-------------------|------------------|
| Monetary          | ❌               |
| Binary            | 🤔               |
| Geometric         | ❌               |
| Network Address   | ❌               |
| Bit String        | 🤔               |
| Text Search       | 🤔               |
| XML               | ✅               |
| JSON              | ✅               |
| Composite         | ❌               |
| Range             | ❌               |
| Domain            | ❌               |
| Object Identifier | ❌               |
| pg_lsn            | ❌               |
| Pseudo            | 🤔               |


## Extending Column Support
You can easily add column data types you are missing by extending the abstract column class. 

```dart

// See this example for adding a "NewColumn".
// In many cases it is enough to provide the constructors + override the type getter.
class NewColumn extends Column<CorrespodingDartType> {

  @override
  String get type => 'sql_data_type';

  @override
  String get defaultValueAsString {
    // Override this getter if you want to customize your default values.
    return super.defaultValueAsString;
  }

  @override
  String convertInputValueToString(CorrespodingDartType inputValue) {
    // Override this method in order to convert your input type to sql friendly strings. 
    // Needed for default values.
    return super.convertInputValueToString(inputValue);
  }

  @override
  String convertArrayInputValueToString(CorrespodingDartType inputValue) {
    // Override this method in order to convert your input type to sql friendly strings. 
    // Needed for array default values.
    return super.convertArrayInputValueToString(inputValue);
  }

  NewColumn(
    super.name, {
    super.isPrimaryKey = false,
    super.foreignKeyForTable,
    super.isUnique = false,
    super.isNullable = false,
    super.constraints,
    super.defaultValue,
    super.manualDefaultValue,
  });

  NewColumn.array(
    super.name, {
    super.isPrimaryKey = false,
    super.foreignKeyForTable,
    super.isUnique = false,
    super.isNullable = false,
    super.constraints,
    super.defaultArrayValue,
    super.manualDefaultValue,
  })
}
```
