import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import  'presentation/medical_icons_icons.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightEditingController = TextEditingController();
  TextEditingController heightEditingController = TextEditingController();
  String _infoText ="";
  GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  void _resetFields(){
  setState(() {
    weightEditingController.text = "";
    heightEditingController.text = "";
    _infoText = "Informe Seus Dados";
    _formKey = GlobalKey<FormState>();
  });
  }

  void calculate(){
    setState(() {
      double weigh = double.parse(weightEditingController.text);
      double heigh = double.parse(heightEditingController.text)/100;
      double imc =weigh/(heigh*heigh);
      if(imc<18.6){
        _infoText="Abaixo do peso (IMC: ${imc.toStringAsPrecision(3)})";
        print(_infoText);
      }else if(imc>=18.6 && imc <=24.9){
        _infoText="Peso ideal (IMC: ${imc.toStringAsPrecision(3)})";
      }else if(imc>=24.9 && imc <=29.9){
        _infoText="Levemente acima do peso (IMC: ${imc.toStringAsPrecision(3)})";
      }else if(imc>=29.9 && imc <=34.9){
        _infoText="Obesidade Grau (IMC: ${imc.toStringAsPrecision(3)})";
      }else if(imc>=34.9 && imc <=39.9){
        _infoText="Obesidade Grau II (IMC: ${imc.toStringAsPrecision(3)})";
      }else if(imc>=40){
        _infoText="Obesidade Grau III (IMC: ${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.refresh,
                ),
                onPressed: () {
                  _resetFields();
                }),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  color: Colors.green,
                  size: 120.0,
                ),
                TextFormField(
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira seu peso";
                    }
                  },
                  controller: weightEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (Kg)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                ),
                TextFormField(
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira sua altura";
                    }
                  },
                  controller: heightEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          print("TESTE");
                          calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(_infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),)
              ],
            ),
          ),
        )
    );
  }
}
