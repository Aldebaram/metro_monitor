import 'package:http/http.dart' as http;
import 'package:metro_monitor/models/details_list.dart';
import 'dart:convert';

import 'package:metro_monitor/models/metro_list.dart';

class MetroAPI {
  final _baseAPI = "https://direto-dos-trens.appspot.com/api";
  final _detailsLimit = 7;

  Future<MetroList> fetchStatus() async {
    final response = await http.get(_baseAPI + '/status');
    if (response.statusCode == 200) {
      return MetroList.fromJson(json.decode(response.body));
    }
    return null;
  }

  Future<DetailsList> fetchDetailsID(code) async {
    final response = await http.get(_baseAPI + '/status/codigo/' + code.toString());
    if (response.statusCode == 200) {
      List ids = json.decode(response.body);
      DetailsList list = await fetchDetails(ids.getRange(0, _detailsLimit).toList());
      return list;
    }
    return null;
  }

  Future<DetailsList> fetchDetails(List ids) async {
    
    List details = [];

    await Future.forEach(ids, (id) async {
      var response = await http.get(_baseAPI + '/status/id/' + id['id'].toString());
      if (response.statusCode == 200) {
        details.add(json.decode(response.body));
      }
    });

    return DetailsList.fromJson(details);
  }

}
