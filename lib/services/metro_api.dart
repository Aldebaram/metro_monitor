import 'package:http/http.dart' as http;
import 'package:metro_monitor/models/details.dart';
import 'dart:convert';

import 'package:metro_monitor/models/metro_list.dart';

class MetroAPI {
  final _baseAPI = "https://direto-dos-trens.appspot.com/api";
  final _detailsLimit = 12;

  Future<MetroList> fetchStatus() async {
    final response = await http.get(_baseAPI + '/status');
    if (response.statusCode == 200) {
      return MetroList.fromJson(json.decode(response.body));
    }
    return null;
  }

  Future<List> fetchIdByCode(code) async {
    final response = await http.get(_baseAPI + '/status/codigo/' + code.toString());
    if (response.statusCode == 200) {
      List ids = json.decode(response.body);
      return ids.getRange(0, _detailsLimit).toList();
    }
    return null;
  }

  Future<Details> fetchDetails(id) async {

    var response = await http.get(_baseAPI + '/status/id/' + id.toString());
    if (response.statusCode == 200) {
      return Details.fromJson(json.decode(response.body));
    }

    return null;
  }

}
