import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'details.dart';
import 'mapView.dart';

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

    Text getNome(num linhaId) {
      switch (linhaId) {
        case 1:
          return Text('Linha 1 - Azul');
          break;
        case 2:
          return Text('Linha 2 - Verde');
          break;
        case 3:
          return Text('Linha 3 - Vermelha');
          break;
        case 4:
          return Text('Linha 4 - Amarela');
          break;
        case 5:
          return Text('Linha 5 - Lilás');
          break;
        case 6:
          return Text('Linha 6 - ????');
          break;
        case 7:
          return Text('Linha 7 - Rubi');
          break;
        case 8:
          return Text('Linha 8 - Diamante');
          break;
        case 9:
          return Text('Linha 9 - Esmeralda');
          break;
        case 10:
          return Text('Linha 10 - Turquesa');
          break;
        case 11:
          return Text('Linha 11 - Coral');
          break;
        case 12:
          return Text('Linha 12 - Safira');
          break;
        case 13:
          return Text('Linha 13 - Jade');
          break;
        case 14:
          return Text('Linha 14 - ??????');
          break;
        case 15:
          return Text('Linha 15 - Prata');
          break;
        default:
          return Text('Linha ?');
      }
    }

    formatDesc(String situacao, String descricao) {
      if (descricao != null) {
        String completo = descricao;
        return Text(completo,textScaleFactor: 1);
      } else {
        return Text(situacao,textScaleFactor: 1);
      }
    }

    Icon iconHandler(String situacao) {
      situacao = situacao.toLowerCase();
      if (situacao.contains("normal")) {
        return Icon(
          Icons.check,
          color: Colors.green,
          size: 40.0,
        );
      }

      if (situacao.contains("diferenciada") ||
          situacao.contains("parcial") ||
          situacao.contains("velocidade reduzida")) {
        return Icon(
          Icons.warning,
          color: Colors.yellow,
          size: 40.0,
        );
      }

      if (situacao.contains("paralisada")) {
        return Icon(
          Icons.report,
          color: Colors.red,
          size: 40.0,
        );
      }

      if (situacao.contains("encerrada")) {
        return Icon(
          Icons.block,
          color: Colors.black,
          size: 40.0,
        );
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
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new MetroView()));
            },
            child: Card(
              child: Container(
                  alignment: Alignment(-0.8, 0),
                  height: 315,
                  child: Image.asset('lib/assets/img/map.jpg')),
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
