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
  setUp(() async => await connection.open());
  executeIntegrationTests((sqlStatement) => connection.execute(sqlStatement));
}
