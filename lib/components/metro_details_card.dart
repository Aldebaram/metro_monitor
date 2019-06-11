import 'package:flutter/material.dart';
import 'package:metro_monitor/models/details.dart';
import 'package:metro_monitor/utils/metro_utils.dart';

class MetroDetailsCard extends StatelessWidget {
  final Details details;

  const MetroDetailsCard(this.details);

  static final MetroUtils _utils = MetroUtils();

  @override
  Widget build(BuildContext context) {

    final List icon = _utils.iconHandler(details.situacao);

    return Container(
      height: 150,
      width: 700,
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
                if (details.situacao != null)
                  Container(
                    child: Text(
                      details.situacao,
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                if (details.descricao != null)
                  Container(
                    width: 250,
                    child: Text(
                      details.descricao,
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Text(_utils.formatDate(details.criado)),
            ),
          ],
        ),
      ),
    );
  }
}
