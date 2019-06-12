import 'package:flutter/material.dart';
import 'package:metro_monitor/components/metro_card.dart';
import 'package:metro_monitor/controllers/metro_controller.dart';
import 'package:metro_monitor/models/metro.dart';
import 'package:metro_monitor/screens/details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MetroController _metroController;

  @override
  void initState() {
    super.initState();
    _metroController = MetroController();
  }

  @override
  void dispose() {
    _metroController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Linhas do Metrô"),
      ),
      body: RefreshIndicator(
        onRefresh: _metroController.fetchList,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            StreamBuilder(
              stream: _metroController.getList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Metro> list = snapshot.data.metros;
                  return Column(
                    children: list.map((line) {
                      return InkWell(
                        child: MetroCard(line),
                        onTap: () {
                          _metroController.fetchDetailsList(line.codigo);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsScreen()));
                        },
                      );
                    }).toList(),
                  );
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height - 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
