// ignore: constant_identifier_names
enum QueryStatus { ERROR, SUCCESS, NO_CONNECTION }

class QueryModel {
  final QueryStatus status;
  final String markdownData;
  final bool hasChanged;

  QueryModel(this.status, this.markdownData, this.hasChanged);
}
