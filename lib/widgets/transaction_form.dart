import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionForm extends StatefulWidget {
  final Function(Transacao) onSubmit;

  const TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  TipoTransacao _tipoSelecionado = TipoTransacao.receita;

  void _enviarFormulario() {
    final descricao = _descricaoController.text;
    final valor = double.tryParse(_valorController.text) ?? 0.0;

    if (descricao.isEmpty || valor <= 0) return;

    final novaTransacao = Transacao(
      descricao: descricao,
      valor: valor,
      tipo: _tipoSelecionado,
    );

    widget.onSubmit(novaTransacao);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _descricaoController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          TextField(
            controller: _valorController,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Valor'),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Tipo:'),
              const SizedBox(width: 10),
              DropdownButton<TipoTransacao>(
                value: _tipoSelecionado,
                items: const [
                  DropdownMenuItem(
                    value: TipoTransacao.receita,
                    child: Text('Receita'),
                  ),
                  DropdownMenuItem(
                    value: TipoTransacao.despesa,
                    child: Text('Despesa'),
                  ),
                ],
                onChanged: (valor) {
                  setState(() {
                    _tipoSelecionado = valor!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _enviarFormulario,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
            ),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
