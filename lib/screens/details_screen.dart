import 'package:flutter/material.dart';
import 'package:metro_monitor/components/metro_details_card.dart';
import 'package:metro_monitor/controllers/metro_controller.dart';
import 'package:metro_monitor/models/details.dart';
import 'map_screen.dart';

class DetailsScreen extends StatefulWidget {
  final code;

  const DetailsScreen(this.code);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  MetroController _metroController;

  @override
  void initState() {
    super.initState();
    _metroController = MetroController();
    _metroController.fetchDetailsList(widget.code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new MapScreen()));
                  },
                  child: Card(
                    child: Container(
                        alignment: Alignment(0, 0),
                        child: Image.asset('assets/img/map.jpg')),
                  ),
                ),
                Card(
                  child: Container(
                    alignment: Alignment(-0.8, 0),
                    height: 35,
                    child: Text(
                      "Historico",
                      textScaleFactor: 1.3,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]),
          StreamBuilder(
            stream: _metroController.getDetailsList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Details> list = snapshot.data.details;
                return Column(
                  children: list.map((line) {
                    return MetroDetailsCard(line);
                  }).toList(),
                );
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height / 2 - 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
