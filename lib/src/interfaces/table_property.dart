/// Abstract class for defining table properties
///
/// Properties can be anything that is declared with a table, e.g. columns,constraints
///
/// ```CREATE TABLE example(property1, property2, property3, etc)```
abstract class TableProperty {
  String get sqlSnippet;
}

/// Class for freely defining table properties
///
/// Properties can anything that is declared with a table, e.g. columns,constraints
///
/// ```CREATE TABLE example(property1, property2, property3, etc)```
class ManualTableProperty implements TableProperty {
  String parameter;

  ManualTableProperty(this.parameter);

  @override
  String get sqlSnippet => parameter;
}
