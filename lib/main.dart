import 'package:chaleno/chaleno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
  String text = "";
  String code = "";

  void getQRCode() async {
    try {
      code = await FlutterBarcodeScanner.scanBarcode(
        "#F44336",
        "Cancelar",
        false,
        ScanMode.QR,
      );

      if (code != '-1') {

        String dateNF = "";
        String companyName = "";
        String companyCnpj = "";
        String valueNF = "";

        var parser = await Chaleno().load(
            code);

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

        text = """
                $companyName \n
                $companyCnpj \n
                $dateNF \n
                $valueNF \n
                Link do Code: $code
        """;

      } else {
        text = 'Não validado';
      }
    } catch (e) {
      print(e);
      text = """
                Link do Code: $code
        """;
    }
    setState(() {
    });
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
              'You have pushed the button this many times:',
            ),
            Text(
              text,
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
