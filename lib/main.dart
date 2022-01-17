import 'dart:convert';

import 'package:chaleno/chaleno.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_code_test/company_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String textLabel = "";
  String code = "";

  String dateNF = "";
  String companyName = "";
  String companyCnpj = "";
  String valueNF = "";
  Dio dio = Dio();

  Future<String> getNfcSP() async {
    try {
      var parser = await Chaleno().load(code);

      //PESCAR NOME DA EMPRESA
      companyName = parser?.getElementById('u20').text!.trim() ?? "";

      //PESCAR CPNJ
      List<Result>? resultsText = parser?.getElementsByClassName('text');
      for (var r in resultsText!) {
        if (r.text!.contains("CNPJ:")) {
          companyCnpj = r.text!
              .replaceAll("\t", "")
              .replaceAll("\n", "")
              .trim()
              .split(":")
              .last
              .trim();
          break;
        }
      }

      //PESCAR VALOR DA NOTA
      List<Result>? results = parser?.getElementsByClassName('linhaShade');
      for (var r in results!) {
        if (r.text!.contains("Valor a pagar R\$:") ||
            r.text!.contains("Valor a pagar")) {
          valueNF = r.text!
              .replaceAll("\t", "")
              .replaceAll("\n", "")
              .trim()
              .split(":")
              .last
              .trim();
          break;
        }
      }

      //PESCAR DATA DA NOTA
      List<Result>? resultsTag = parser?.getElementsByTagName('li');
      for (var r in resultsTag!) {
        if (r.text!.contains("Emissão:") || r.text!.contains("Emissao:")) {
          r.text!.split("\n").map((t) {
            if (t.trim().contains("Emissão:") ||
                t.trim().contains("Emissao:")) {
              var tSplit = t.trim().split(":");
              if (tSplit.length > 3) {
                dateNF = tSplit[3].trim().split(" ").first;
              }
            }
          }).toList();

          break;
        }
      }

      textLabel = """
                $companyName \n
                $companyCnpj \n
                $dateNF \n
                $valueNF \n
                Link do Code: $code
        """;

      return "SUCESS";
    } catch (e) {
      textLabel = """
                Link do Code: $code
        """;
      return "ERROR: ${e.toString()}";
    }
  }

  void getQRCode() async {
    try {
      code = await FlutterBarcodeScanner.scanBarcode(
        "#F44336",
        "Cancelar",
        false,
        ScanMode.QR,
      );

      if (code != '-1') {
        //Codigos com link
        if (code.contains("http") || code.contains(".sp.gov")) {
          await getNfcSP();
        } else {
          //Codigos com dados
          var codeSplit = code.split("|");

          if (codeSplit.length > 2) {
            //data
            dateNF = codeSplit[1].substring(0, 8);
            //valor
            valueNF = codeSplit[2];

            //Verifica cnpj
            String cnpj = codeSplit.first.length > 44
                ? codeSplit.first
                .substring(codeSplit.first.length - 44)
                .substring(6, 20)
                : codeSplit.first.substring(6, 20);

            final response =
            await dio.get('https://www.receitaws.com.br/v1/cnpj/$cnpj');
            // CompanyModel? companyModel = CompanyModel.fromJson(jsonDecode(response.data));

            companyName = response.data["nome"];
            companyCnpj = response.data["cnpj"];

          }

          textLabel = """
                $companyName \n
                $companyCnpj \n
                $dateNF \n
                $valueNF \n
                Link do Code: $code
        """;
        }
      } else {
        textLabel = 'Não validado';
      }
      setState(() {
      });

    } catch (e) {
      print(e);
      textLabel = """
                Link do Code: $code
        """;

      setState(() {
      });
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Dados:',
            ),
            Text(
              textLabel,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getQRCode,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
