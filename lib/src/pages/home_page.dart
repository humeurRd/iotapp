import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String estado = "APAGADO";
  String fecha = " ";
  var client = http.Client();

  void _changeStateLed() async {
    setState(() {
      if (estado == "APAGADO") {
        estado = "ENCENDIDO";
        fecha = "09-04-2021";
      } else {
        estado = "APAGADO";
        fecha = " ";
      }
      try {
        led(estado);
      } catch (e) {
        print(e);
      }
    });
  }

  Future<http.Response> led(String state) {
    return http.post(
      Uri.https('192.168.1.69:80', '/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'state': state,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Led'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'El estado del LED es:' + '$estado',
            ),
            Text('Fecha: $fecha', style: TextStyle(fontWeight: FontWeight.w100),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeStateLed,
        tooltip: 'ChangeState',
        child: Icon(Icons.power),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}