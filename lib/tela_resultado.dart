import 'package:flutter/material.dart';

const laranjaNeon = Color(0xFFFF9100);

class TelaResultado extends StatelessWidget {
  final double montanteFinal;
  final List<String> detalhesMeses;
  final double capitalInicial;
  final double aplicacaoMensal;
  final double taxaJuros;
  final int meses;

  const TelaResultado({
    Key? key,
    required this.montanteFinal,
    required this.detalhesMeses,
    required this.capitalInicial,
    required this.aplicacaoMensal,
    required this.taxaJuros,
    required this.meses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalInvestido = capitalInicial + (aplicacaoMensal * meses);
    double rendimentoTotal = montanteFinal - totalInvestido;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.black,
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Montante', style: TextStyle(color: laranjaNeon, fontWeight: FontWeight.bold, fontSize: 14)),
                          SizedBox(height: 4),
                          Text('R\$ ${montanteFinal.toStringAsFixed(2)}', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Card(
                    color: Colors.black,
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Investido', style: TextStyle(color: laranjaNeon, fontWeight: FontWeight.bold, fontSize: 14)),
                          SizedBox(height: 4),
                          Text('R\$ ${totalInvestido.toStringAsFixed(2)}', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Card(
                    color: Colors.black,
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rendimento', style: TextStyle(color: laranjaNeon, fontWeight: FontWeight.bold, fontSize: 14)),
                          SizedBox(height: 4),
                          Text('R\$ ${rendimentoTotal.toStringAsFixed(2)}', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Card(
              color: Colors.black,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Meses: $meses', style: TextStyle(color: laranjaNeon, fontSize: 14)),
                    Text('Juros: ${taxaJuros.toStringAsFixed(2)}%', style: TextStyle(color: laranjaNeon, fontSize: 14)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Evolução mensal',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: laranjaNeon),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: detalhesMeses.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.black,
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    child: Text(
                      detalhesMeses[index],
                      style: TextStyle(
                        color: laranjaNeon,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}