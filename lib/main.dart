import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'metro.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linhas do Metrô',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Linhas do Metrô'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String texto = "";

  Future<MetroList> fetchPost() async {
    final response =
        await http.get('https://www.diretodostrens.com.br/api/status');

    if (response.statusCode == 200) {
      // If server returns an OK response
      final jsonResponse = json.decode(response.body);
      MetroList lista = new MetroList.fromJson(jsonResponse);
      return lista;
    } else {
      // If that response was not OK
      Future<MetroList> lista;
      return lista;
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

  void refresh() {
    fetchPost();
    setState(() {});
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

  Container card(Metro linha) {
    return new Container(
      height: 100,
      child: Card(
        child: ListTile(
          leading: iconHandler(linha.situacao),
          title: getNome(linha.codigo),
          subtitle: Text(linha.situacao),
          trailing: Text(DateFormat.yMd()
              .add_Hm()
              .format(DateTime.parse(linha.modificado).toLocal())),
        ),
      ),
    );
  }

  List<Container> cardlist(MetroList lista) {
    return lista.metros.map(card).toList();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          FutureBuilder<MetroList>(
            future: fetchPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Widget> lista = cardlist(snapshot.data);
                return Column(
                  children: lista.map((Widget item) => item).toList(),
                );
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }
              return new CircularProgressIndicator();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: refresh,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
