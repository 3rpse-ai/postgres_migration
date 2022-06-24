import 'package:postgres_migration/postgres_migration.dart';

// Example assumes following:
// - There are 2 tables - students & schools. Any student can only be in one school
// - We will have 2 migrations. First create tables, then update them
// - We are not using any specific package to connect to the db. Hence methods for connecting to db are only mocked.
// 
// There is no opinion on how to structure your migrations, as the package is built to allow for maximum flexibility.
// After all the package just helps in creating the correspoding sql statements with a wide range of possibilities.
// You can e.g. build an automatic schema versioning on top which automatically runs your up / downgrades, or enhance an existing migration system with it.

// This should be replaced with a corresponding package such as postgres
class DB {
  static Future<void> openConnection() async {
    // open the connection
  }

  static Future<void> sendQuery(String query) async {
    // send query against DB
  }
}

// We create 2 minimalistic tables with a relation 1:n between them.
class FirstMigration {
  final schoolsTable = TableMigrator("schools");
  final List<TableProperty> schoolsTableProps = [
    SerialColumn('id', isPrimaryKey: true),
    TextColumn('name'),
  ];

  final studentsTable = TableMigrator("students");
  final List<TableProperty> studentsTableProps = [
    BigSerialColumn('id', isPrimaryKey: true),
    TextColumn('first_name'),
    TextColumn('last_name'),
    IntegerColumn(
      'schoolId',
      constraints: ColumnConstraints(
        foreignKeyConstraint: ForeignKeyConstraint(
          referencedTable: "schools",
          deletionMode: ForeignKeyDeletionMode.cascade,
          name: "fk_schools_constraint",
        ),
      ),
    ),
  ];

  Future<void> runMigration() async {
    // Create schools table
    await DB.sendQuery(schoolsTable.createTable(schoolsTableProps));
    // Create students table
    await DB.sendQuery(studentsTable.createTable(studentsTableProps));
  }
}

// We enhance both tables
class SecondMigration {
  final schoolsTable = TableMigrator("schools");
  final studentsTable = TableMigrator("students");

  Future<void> runMigration() async {
    // add Address Column to school

    final schoolAddress = TextColumn('address');
    await DB.sendQuery(schoolsTable.addColumn(schoolAddress));

    // Make Address Column + Name unique
    final uniqueConstraint = UniqueConstraint.tableProperty(
      columnNames: [
        'name',
        'address',
      ],
    );
    await DB.sendQuery(schoolsTable.addConstraint(uniqueConstraint));

    // Add createdAt field for students which defaults to current time on DB
    final studentCreatedAt = TimestampWithTimeZoneColumn(
      'created_at',
      defaultToCurrentTimeStamp: true,
    );
    await DB.sendQuery(studentsTable.addColumn(studentCreatedAt));
  }
}

void main() async {
  await FirstMigration().runMigration();
  await SecondMigration().runMigration();
}
