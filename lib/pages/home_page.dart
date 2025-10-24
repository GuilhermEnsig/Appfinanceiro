import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/finance_data.dart';
import '../models/transaction.dart'; // Import necessário para TipoTransacao
import '../widgets/transaction_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final finance = Provider.of<FinanceData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Finanças'),
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Menu Principal',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Tela Inicial'),
              onTap: () => Navigator.pushReplacementNamed(context, '/inicio'),
            ),
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: const Text('Investimentos'),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, '/investimentos'),
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Relatórios'),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, '/relatorios'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Saldo Total: R\$ ${finance.saldoTotal.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Receitas: R\$ ${finance.totalReceitas.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.green, fontSize: 16),
              ),
              Text(
                'Despesas: R\$ ${finance.totalDespesas.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
          const Divider(height: 30, thickness: 1),
          Expanded(
            child: ListView.builder(
              itemCount: finance.transacoes.length,
              itemBuilder: (context, index) {
                final transacao = finance.transacoes[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      transacao.tipo == TipoTransacao.receita
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: transacao.tipo == TipoTransacao.receita
                          ? Colors.green
                          : Colors.red,
                    ),
                    title: Text(transacao.descricao),
                    subtitle: Text(
                      'R\$ ${transacao.valor.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: transacao.tipo == TipoTransacao.receita
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.grey),
                      onPressed: () {
                        finance.removerTransacao(transacao);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: TransactionForm(
                  onSubmit: (transacao) {
                    finance.adicionarTransacao(transacao);
                    Navigator.pop(context);
                  },
                ),
              );
            },
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
