/// Abstract class for defining parameters on tables
/// 
/// Parameters can be anything that is declared with a table, e.g. columns,constraints
///
/// ```CREATE TABLE example(parameter1, parameter2, parameter 3, etc)```
abstract class TableProperty {
  String get sqlSnippet;
}


/// Class for freely defining table parameters
/// 
/// Parameters can anything that is declared with a table, e.g. columns,constraints
///
/// ```CREATE TABLE example(parameter1, parameter2, parameter 3, etc)```
class ManualTableProperty implements TableProperty {
  String parameter;

  ManualTableProperty(this.parameter);

  @override
  String get sqlSnippet => parameter;
}
