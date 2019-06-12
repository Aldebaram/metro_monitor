import 'dart:async';

import 'package:metro_monitor/models/details_list.dart';
import 'package:metro_monitor/models/metro_list.dart';
import 'package:metro_monitor/services/metro_api.dart';

class MetroController {
  static MetroController _metroController;

  factory MetroController() {
    if (_metroController == null) {
      _metroController = MetroController._();
    }
    return _metroController;
  }

  StreamController _listController = StreamController<MetroList>.broadcast();
  StreamController _listDetailsController = StreamController<DetailsList>.broadcast();

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

  Future<void> fetchDetailsList(id) async {
    DetailsList list = await _api.fetchDetailsID(id);
    _listDetailsController.add(list);
  }

  void dispose() {
    _listDetailsController.close();
    _listController.close();
  }
}
