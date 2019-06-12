import 'dart:async';
import 'package:metro_monitor/models/details.dart';
import 'package:metro_monitor/models/metro_list.dart';
import 'package:metro_monitor/services/metro_api.dart';

class MetroController {

  static MetroController _metroController;
  List<Details> _details;

  factory MetroController() {
    if (_metroController == null) {
      _metroController = MetroController._();
    }
    return _metroController;
  }

  StreamController _listController = StreamController<MetroList>.broadcast();
  StreamController _listDetailsController = StreamController<List<Details>>.broadcast();

  Stream get getList => _listController.stream;
  Stream get getDetailsList => _listDetailsController.stream;

  MetroAPI _api;

  MetroController._() {
    _api = MetroAPI();
    fetchList();
  }

  Future<void> fetchList() async {
    MetroList list = await _api.fetchStatus();
    _listController.add(list);
  }

  Future<void> fetchDetailsList(code) async {
    _details = [];

    List ids = await _api.fetchIdByCode(code);

    await Future.forEach(ids, (id) async {
      Details details = await _api.fetchDetails(id['id']);
      if(details != null)
        _details.add(details);
        _listDetailsController.add(_details);
    });

  }

  void dispose() {
    _listDetailsController.close();
    _listController.close();
  }
}
