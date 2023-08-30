// ignore_for_file: prefer_const_constructors, unnecessary_this

import 'package:flutter/material.dart';

class calculadora extends StatefulWidget {
  @override
  _calculadoraState createState() => _calculadoraState();
}

class _calculadoraState extends State<calculadora> {
  var message = "Clique calcular";
  final gasolinaController = TextEditingController();

  final alcoolController = TextEditingController();

  var image = AssetImage("images/alcool.png");
  var showImage = false;

  showAlertDialog(BuildContext context, String reason) {

    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );

    AlertDialog alert = AlertDialog(
      title: Text("Erro"),
      content: Text(reason),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _calculate() {
    var alcoolText = this.alcoolController.text;
    var gasolinaText = this.gasolinaController.text;

    if (gasolinaText.isEmpty || double.tryParse(gasolinaText) == null) {
      showAlertDialog(context, "Valor da Gasolina inválido");
      return;
    }

    if (alcoolText.isEmpty || double.tryParse(alcoolText) == null) {
      showAlertDialog(context, "Valor do Etanol inválido");
      return;
    }

    var alcoolPrice = double.parse(alcoolText);
    var gasolinaPrice = double.parse(gasolinaText);
    var razao = alcoolPrice / gasolinaPrice;

    if (razao >= 0.7) {
      setState(() {
        this.message = "Compensa mais utilizar Gasolina";
        this.image = AssetImage("images/gasolina.png");
        this.showImage = true;
      });
    } else {
      setState(() {
        this.message = "Compensa mais utilizar Etanol";
        this.image = AssetImage("images/alcool.png");
        this.showImage = true;
      });
    }
  }
  
  void _cleanInputs() {
    setState(() {
      this.message = "Digite os preços";
      this.alcoolController.text = "";
      this.gasolinaController.text = "";
      this.image = AssetImage("images/undefined.png");
      this.showImage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculadora de combustivel")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                this.message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              if(showImage) Image(image: this.image, height: 100),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16, right: 15, left: 15),
            child: TextFormField(
              controller: gasolinaController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite o preço da gasolina',
                labelText: 'Gasolina',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16, right: 15, left: 15),
            child: TextFormField(
              controller: alcoolController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite o preço do etanol',
                labelText: 'Etanol',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(88, 36),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                  backgroundColor: Colors.blue.shade400,
                ),
                onPressed: () => _calculate(),
                child: Text('Calcular'),
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(88, 36),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                  backgroundColor: Colors.red.shade400,
                ),
                onPressed: () => _cleanInputs(),
                child: Text('Limpar'),
              ),
            ],
          )
        ],
      ),
    );
  }
}