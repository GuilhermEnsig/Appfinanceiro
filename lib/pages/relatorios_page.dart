import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/finance_data.dart';

class RelatoriosPage extends StatelessWidget {
  const RelatoriosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final finance = context.watch<FinanceData>();
    final receitas = finance.totalReceitas;
    final despesas = finance.totalDespesas;
    final invest = finance.totalInvestido;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios'),
        backgroundColor: Colors.teal,
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'inicio') {
                Navigator.pushReplacementNamed(context, '/inicio');
              }
            },
            itemBuilder: (ctx) => const [
              PopupMenuItem(value: 'inicio', child: Text('Voltar ao Início')),
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text('Menu Principal',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Tela Inicial'),
              onTap: () => Navigator.pushReplacementNamed(context, '/inicio'),
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Minhas Finanças'),
              onTap: () => Navigator.pushReplacementNamed(context, '/'),
            ),
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: const Text('Investimentos'),
              onTap: () => Navigator.pushReplacementNamed(context, '/investimentos'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Resumo Financeiro',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              _cardResumo('Saldo Atual', finance.saldoTotal,
                  Colors.teal.shade100, Colors.teal.shade900),
              const SizedBox(height: 10),
              _cardResumo('Total de Receitas', receitas,
                  Colors.green.shade100, Colors.green.shade900),
              const SizedBox(height: 10),
              _cardResumo('Total de Despesas', despesas,
                  Colors.red.shade100, Colors.red.shade900),
              const SizedBox(height: 10),
              _cardResumo('Total Investido', invest,
                  Colors.blue.shade100, Colors.blue.shade900),

              const SizedBox(height: 30),
              const Text(
                'Gráfico de Desempenho',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              SizedBox(
                height: 320,
                child: BarChart(
                  BarChartData(
                    maxY: _definirMaxY(receitas, despesas, invest),
                    alignment: BarChartAlignment.spaceEvenly,
                    barTouchData: BarTouchData(enabled: false),
                    gridData: FlGridData(show: true, drawHorizontalLine: true),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          interval: _definirIntervalo(receitas, despesas, invest),
                          getTitlesWidget: (value, meta) => Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 0:
                                return const Text('Receitas');
                              case 1:
                                return const Text('Despesas');
                              case 2:
                                return const Text('Investimentos');
                              default:
                                return const Text('');
                            }
                          },
                        ),
                      ),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    barGroups: [
                      _criarBarra(0, receitas, Colors.green, 'R\$ ${receitas.toStringAsFixed(2)}'),
                      _criarBarra(1, despesas, Colors.red, 'R\$ ${despesas.toStringAsFixed(2)}'),
                      _criarBarra(2, invest, Colors.blue, 'R\$ ${invest.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Atualizado automaticamente',
                  style: TextStyle(
                    color: Colors.grey.withValues(alpha: 0.7),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🧩 Função para criar cada barra
  BarChartGroupData _criarBarra(int x, double valor, Color cor, String label) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: valor,
          color: cor,
          width: 40,
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.black12, width: 1),
          rodStackItems: [],
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }

  // 🧩 Função para ajustar escala do gráfico dinamicamente
  static double _definirMaxY(double r, double d, double i) {
    final maxVal = [r, d, i].reduce((a, b) => a > b ? a : b);
    return (maxVal <= 0) ? 100 : maxVal * 1.4;
  }

  static double _definirIntervalo(double r, double d, double i) {
    final maxVal = [r, d, i].reduce((a, b) => a > b ? a : b);
    return (maxVal <= 100) ? 20 : maxVal / 5;
  }

  // 🧩 Widget dos cartões superiores
  Widget _cardResumo(
      String titulo, double valor, Color cor, Color textoCor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo,
              style: TextStyle(
                  color: textoCor, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 6),
          Text('R\$ ${valor.toStringAsFixed(2)}',
              style: TextStyle(
                  color: textoCor, fontWeight: FontWeight.w600, fontSize: 18)),
        ],
      ),
    );
  }
}
