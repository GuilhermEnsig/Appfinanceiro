import 'package:flutter/material.dart';
import 'transaction.dart';
import 'investment.dart';

class FinanceData with ChangeNotifier {
  // ----------------- Transações -----------------
  final List<Transacao> _transacoes = [];
  List<Transacao> get transacoes => _transacoes;

  void adicionarTransacao(Transacao t) {
    _transacoes.add(t);
    notifyListeners();
  }

  void removerTransacao(Transacao t) {
    _transacoes.remove(t);
    notifyListeners();
  }

  double get totalReceitas => _transacoes
      .where((t) => t.tipo == TipoTransacao.receita)
      .fold(0.0, (s, t) => s + t.valor);

  double get totalDespesas => _transacoes
      .where((t) => t.tipo == TipoTransacao.despesa)
      .fold(0.0, (s, t) => s + t.valor);

  double get saldoTotal => totalReceitas - totalDespesas;

  // ----------------- Investimentos -----------------
  final List<Investimento> _investimentos = [];
  List<Investimento> get investimentos => _investimentos;

  void adicionarInvestimento(String nome, double valor, double rentabilidade) {
    _investimentos.add(Investimento(
      nome: nome,
      valor: valor,
      rentabilidade: rentabilidade,
    ));
    notifyListeners();
  }

  void removerInvestimento(Investimento inv) {
    _investimentos.remove(inv);
    notifyListeners();
  }

  double get totalInvestido =>
      _investimentos.fold(0.0, (soma, inv) => soma + inv.valor);
}
