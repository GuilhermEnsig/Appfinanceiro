import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/finance_data.dart';
import '../models/investment.dart';

class InvestimentosPage extends StatefulWidget {
  const InvestimentosPage({super.key});

  @override
  State<InvestimentosPage> createState() => _InvestimentosPageState();
}

class _InvestimentosPageState extends State<InvestimentosPage> {
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();
  final _rentabilidadeController = TextEditingController();

  void _salvar() {
    final nome = _nomeController.text.trim();
    final valor = double.tryParse(_valorController.text.replaceAll(',', '.')) ?? 0;
    final rent = double.tryParse(_rentabilidadeController.text.replaceAll(',', '.')) ?? 0;

    if (nome.isEmpty || valor <= 0) return;

    context.read<FinanceData>().adicionarInvestimento(nome, valor, rent);

    _nomeController.clear();
    _valorController.clear();
    _rentabilidadeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final finance = context.watch<FinanceData>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Investimentos'),
        backgroundColor: Colors.teal,
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
              leading: const Icon(Icons.bar_chart),
              title: const Text('Relatórios'),
              onTap: () => Navigator.pushReplacementNamed(context, '/relatorios'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome do investimento'),
            ),
            TextField(
              controller: _valorController,
              decoration: const InputDecoration(labelText: 'Valor investido'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _rentabilidadeController,
              decoration: const InputDecoration(labelText: 'Rentabilidade (%)'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _salvar,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar Investimento'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade100,
                foregroundColor: Colors.teal.shade900,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: finance.investimentos.isEmpty
                  ? const Center(child: Text('Nenhum investimento ainda.'))
                  : ListView.builder(
                      itemCount: finance.investimentos.length,
                      itemBuilder: (context, i) {
                        final Investimento inv = finance.investimentos[i];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(inv.nome),
                            subtitle: Text(
                              'R\$ ${inv.valor.toStringAsFixed(2)}  |  ${inv.rentabilidade.toStringAsFixed(2)} %',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.grey),
                              onPressed: () => finance.removerInvestimento(inv),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
