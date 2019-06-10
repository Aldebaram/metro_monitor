import 'package:flutter/material.dart';
import 'package:zoomable_image/zoomable_image.dart';

class MetroView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mapa"),
        ),
        body: Container(
          child: ZoomableImage(new AssetImage('assets/img/map.jpg'),
              scale: 16.0),
        ));
  }
}
