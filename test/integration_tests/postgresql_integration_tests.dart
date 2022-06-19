import 'package:postgres/postgres.dart';
import 'package:test/test.dart';
import 'integration_tests.dart';

void executePostgreSQLIntegrationTests() async {
  final connection = PostgreSQLConnection(
    "localhost",
    5432,
    "integration_tests",
    username: "postgres",
  );

  setUpAll(() async => await connection.open());
  tearDownAll(() async => await connection.close());
  executeIntegrationTests((sqlStatement) => connection.execute(sqlStatement));
}
