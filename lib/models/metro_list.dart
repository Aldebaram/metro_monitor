import 'metro.dart';

class MetroList {
  final List<Metro> metros;

  MetroList(this.metros);

  factory MetroList.fromJson(List<dynamic> parsedJson) {

    List<Metro> metros = List<Metro>();
    metros = parsedJson.map((i)=>Metro.fromJson(i)).toList();

    return MetroList(metros);
  }
}