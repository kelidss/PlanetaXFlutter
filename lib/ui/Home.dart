import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //controlador de texto que será usado para manipular um campo de texto específico .
  //O uso comum desse controlador é conectar-se a um widget TextField para obter dentro desse campo de texto.
  final TextEditingController _controlePeso = TextEditingController();

  int radioValor = 1;
  String _nomePlaneta = "";
  bool selecaoValorA = true;
  bool selecaoValorB = false;
  late bool selecaoValorC;
  bool switchValor = false;

  double _resultadoFinal = 0.0;

  void tomaContaValorRadio(int? valor) {
    setState(() {
      radioValor = valor!; // isso aqui me deu dor de cabeça...
      switch (radioValor) {
        case 0:
          _nomePlaneta = "Plutão";
          _resultadoFinal = calcularPesoEmPlaneta(_controlePeso.text, 0.06);
          break;
        case 1:
          _nomePlaneta = "Marte";
          _resultadoFinal = calcularPesoEmPlaneta(_controlePeso.text, 0.38);
          break;
        case 2:
          _nomePlaneta = "Vênus";
          _resultadoFinal = calcularPesoEmPlaneta(_controlePeso.text, 0.91);
          break;
        default:
          _nomePlaneta = "Nenhum planeta selecionado";
          _resultadoFinal = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('planeta x'),
        backgroundColor: const Color.fromARGB(230, 82, 158, 209),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          padding: const EdgeInsets.all(1.5),
          children: <Widget>[
            Image.asset(
              'assets/planeta.jpg',
              height: 150,
              width: 5,
            ),
            Container(
              margin: const EdgeInsets.all(3.0),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _controlePeso,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Seu peso na terra',
                        hintText: 'Kg',
                        icon: Icon(Icons.mode_night_rounded)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio<int>(
                          activeColor: Colors.green,
                          value: 0,
                          groupValue: radioValor,
                          onChanged: tomaContaValorRadio),
                      const Text(
                        "Plutão",
                        style: TextStyle(color: Colors.green),
                      ),
                      Radio<int>(
                        activeColor: Colors.red,
                        value: 1,
                        groupValue: radioValor,
                        onChanged: tomaContaValorRadio,
                      ),
                      const Text(
                        "Marte",
                        style: TextStyle(color: Colors.orangeAccent),
                      ),
                      Radio<int>(
                        activeColor: const Color.fromARGB(255, 64, 169, 255),
                        value: 2,
                        groupValue: radioValor,
                        onChanged: tomaContaValorRadio,
                      ),
                      const Text(
                        "Vênus",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  Text(
                    _controlePeso.text.isEmpty
                        ? "Digite o seu peso..."
                        : '$_nomePlaneta ${_resultadoFinal.toStringAsFixed(2)} kg',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 37, 24, 97),
                        fontSize: 13.4,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  double calcularPesoEmPlaneta(String peso, double gravidadeSuperficial) {
    if (int.parse(peso).toString().isNotEmpty && int.parse(peso) > 0) {
      return (int.parse(peso) * gravidadeSuperficial);
    } else {
      return int.parse("180") * 0.38;
    }
  }
}
