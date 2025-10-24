import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/finance_data.dart';

class InvestmentForm extends StatefulWidget {
  const InvestmentForm({super.key});

  @override
  State<InvestmentForm> createState() => _InvestmentFormState();
}

class _InvestmentFormState extends State<InvestmentForm> {
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();
  final _rentabilidadeController = TextEditingController();

  void _adicionarInvestimento(BuildContext context) {
    final nome = _nomeController.text;
    final valor = double.tryParse(_valorController.text) ?? 0.0;
    final rentabilidade = double.tryParse(_rentabilidadeController.text) ?? 0.0;

    if (nome.isEmpty || valor <= 0) return;

    Provider.of<FinanceData>(context, listen: false)
        .adicionarInvestimento(nome, valor, rentabilidade);

    _nomeController.clear();
    _valorController.clear();
    _rentabilidadeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _rentabilidadeController,
            decoration: const InputDecoration(labelText: 'Rentabilidade (%)'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => _adicionarInvestimento(context),
            icon: const Icon(Icons.add),
            label: const Text('Adicionar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
