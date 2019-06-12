import 'package:flutter/material.dart';
import 'package:metro_monitor/models/metro.dart';
import 'package:metro_monitor/utils/metro_utils.dart';

class MetroCard extends StatelessWidget {
  final Metro line;

  const MetroCard(this.line);

  static final MetroUtils _utils = MetroUtils();

  @override
  Widget build(BuildContext context) {
    List icon = _utils.iconHandler(line.situacao);

    return Container(
      height: 100,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                icon[0],
                color: icon[1],
                size: 40,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    _utils.getNome(line.codigo),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.5,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  line.situacao,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Text(_utils.formatDate(line.modificado),
                  textAlign: TextAlign.end),
            ),
          ],
        ),
      ),
    );
  }
}
