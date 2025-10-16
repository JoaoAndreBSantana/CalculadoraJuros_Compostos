import 'package:flutter/material.dart';
import 'tela_resultado.dart';

const laranjaNeon = Color(0xFFFF9100);

class JurosCompostosApp extends StatelessWidget {
  const JurosCompostosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juros Compostos',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: laranjaNeon,
          brightness: Brightness.dark,
          primary: laranjaNeon,
        ),
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: laranjaNeon,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: laranjaNeon,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF1C1C1C),
          labelStyle: TextStyle(color: laranjaNeon),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: laranjaNeon, width: 2),
          ),
        ),
      ),
      home: const TelaCalculadora(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TelaCalculadora extends StatefulWidget {
  const TelaCalculadora({Key? key}) : super(key: key);

  @override
  State<TelaCalculadora> createState() => _TelaCalculadoraState();
}

class _TelaCalculadoraState extends State<TelaCalculadora> {
  final capitalController = TextEditingController();
  final mensalController = TextEditingController();
  final mesesController = TextEditingController();
  final taxaController = TextEditingController();

  void _calcular() {
    if (capitalController.text.isEmpty ||
        mensalController.text.isEmpty ||
        mesesController.text.isEmpty ||
        taxaController.text.isEmpty) {
      _mostrarAlerta('Preencha todos os campos!');
      return;
    }

    try {
      double capital = double.parse(capitalController.text);
      double mensal = double.parse(mensalController.text);
      int meses = int.parse(mesesController.text);
      double taxa = double.parse(taxaController.text) / 100;

      if (capital < 0 || mensal < 0 || meses <= 0 || taxa < 0) {
        _mostrarAlerta('Insira valores positivos válidos!');
        return;
      }

      double montante = capital;
      List<String> detalhes = [];
      for (int i = 1; i <= meses; i++) {
        double rendimento = montante * taxa;
        montante += rendimento + mensal;
        detalhes.add("Mês $i: R\$ ${montante.toStringAsFixed(2)} (Rendimento: R\$ ${rendimento.toStringAsFixed(2)})");
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TelaResultado(
            montanteFinal: montante,
            detalhesMeses: detalhes,
            capitalInicial: capital,
            aplicacaoMensal: mensal,
            taxaJuros: taxa * 100,
            meses: meses,
          ),
        ),
      );
    } catch (_) {
      _mostrarAlerta('Insira apenas números válidos!');
    }
  }

  void _mostrarAlerta(String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('Atenção', style: TextStyle(color: laranjaNeon)),
        content: Text(msg, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: laranjaNeon)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Juros Compostos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            _campoTexto(capitalController, 'Investimento inicial (R\$)'),
            _campoTexto(mensalController, 'Aplicação mensal (R\$)'),
            _campoTexto(mesesController, 'Período (meses)', tipo: TextInputType.number),
            _campoTexto(taxaController, 'Taxa de juros mensal (%)'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _calcular,
              icon: const Icon(Icons.calculate, color: Colors.black),
              label: const Text('Calcular'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campoTexto(TextEditingController controller, String label, {TextInputType tipo = TextInputType.number}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextField(
        controller: controller,
        keyboardType: tipo,
        style: const TextStyle(
          color: laranjaNeon,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          letterSpacing: 1.2,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: laranjaNeon,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          filled: true,
          fillColor: Color(0xFF1C1C1C),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: laranjaNeon, width: 2.5),
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        ),
      ),
    );
  }
}