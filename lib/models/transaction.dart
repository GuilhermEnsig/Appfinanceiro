enum TipoTransacao { receita, despesa }

class Transacao {
  final String descricao;
  final double valor;
  final TipoTransacao tipo;

  Transacao({
    required this.descricao,
    required this.valor,
    required this.tipo,
  });
}
