import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'details.dart';
import 'mapView.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';
import 'common.dart';

class Details extends StatelessWidget {
  int codigo;
  Details(int codigo) {
    this.codigo = codigo;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<FullDetail>> fetchDetails() async {
      List<FullDetail> lista2 = new List<FullDetail>();
      final response = await http.get(
          'https://www.diretodostrens.com.br/api/status/codigo/' +
              codigo.toString());

      if (response.statusCode == 200) {
        // If server returns an OK response
        final jsonResponse = json.decode(response.body);
        DetailList lista = new DetailList.fromJson(jsonResponse);
        for (var i = 0; i < 10; i++) {
          final response2 = await http.get(
              'https://www.diretodostrens.com.br/api/status/id/' +
                  lista.details[i].id.toString());
          final jsonResponse2 = json.decode(response2.body);
          FullDetail detalhe = new FullDetail.fromJson(jsonResponse2);
          lista2.add(detalhe);
        }
        return lista2;
      } else {
        // If that response was not OK
        Future<List<FullDetail>> lista2;
        return lista2;
      }
    }

    

    formatDesc(String situacao, String descricao) {
      if (descricao != null) {
        String completo = descricao;
        return Text(completo, textScaleFactor: 1);
      } else {
        return Text(situacao, textScaleFactor: 1);
      }
    }


    Container card(FullDetail info) {
      initializeDateFormatting("pt_BR", null);
      return new Container(
        height: 115,
        child: Card(
          child: ListTile(
            leading: iconHandler(info.situacao),
            title: getNome(info.codigo),
            isThreeLine: true,
             dense: true,
            subtitle: formatDesc(info.situacao, info.descricao),
            trailing: Text(
              DateFormat("dd/MM - HH:mm", "pt_BR")
                  .format(DateTime.parse(info.criado).toLocal()),
              textScaleFactor: 0.7,
            ),
          ),
        ),
      );
    }

    List<Container> cardDetaillist(List<FullDetail> lista) {
      return lista.map(card).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new MetroView()));
            },
            child: Container(
                alignment: Alignment(-0.8, 0),
                height: 315,
                child: Image.asset('assets/img/map.jpg')),
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
          FutureBuilder<List<FullDetail>>(
            future: fetchDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Widget> lista = cardDetaillist(snapshot.data);
                return Column(
                  children: lista.map((Widget item) => item).toList(),
                );
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }
              return Container(
                padding: EdgeInsets.only(left: 185, right: 185, top: 20),
                child: new CircularProgressIndicator(),
              );
            },
          )
        ],
      ),
    );
  }
}
