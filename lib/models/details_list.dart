import 'details.dart';

class DetailsList {
  final List<Details> details;

  DetailsList(this.details);

  factory DetailsList.fromJson(List<dynamic> parsedJson) {

    List<Details> details = List<Details>();
    details = parsedJson.map((i) => Details.fromJson(i)).toList();

    return DetailsList(details);
  }
}