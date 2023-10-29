class Abastecimento {
  final String codVeiculo;
  final String nome;
  final String placaVeiculo;
  final String descricao;
  final String combustivelTransporte;
  final String tipoAbastecimento;
  final double tanqueInicial;
  final double tanqueAtual;
  final String
      combustivelOperacaoTipo; // Tansferencia ou Abastecimento de Aeronave/Veiculo
  final double combustivelOperacaoInicial;
  final double combustivelOperacaoFinal;
  final String origemCombustivel;
  final String destinoCombustivel;
  final double quantidadeCombustivel;

  const Abastecimento(
      {required this.codVeiculo,
      required this.nome,
      required this.placaVeiculo,
      required this.descricao,
      required this.combustivelTransporte,
      required this.tipoAbastecimento,
      required this.tanqueInicial,
      required this.tanqueAtual,
      required this.combustivelOperacaoTipo,
      required this.combustivelOperacaoInicial,
      required this.combustivelOperacaoFinal,
      required this.origemCombustivel,
      required this.destinoCombustivel,
      required this.quantidadeCombustivel});

  Map<String, dynamic> toJson() => {
        "codVeiculo": codVeiculo,
        "nome": nome,
        "placaVeiculo": placaVeiculo,
        "descricao": descricao,
        "combustivelTransporte": combustivelTransporte,
        "tanqueInicial": tanqueInicial,
        "tanqueAtual": tanqueAtual,
        "combustivelOperacaoTipo": combustivelOperacaoTipo,
        "combustivelOperacaoInicial": combustivelOperacaoInicial,
        "combustivelOperacaoFinal": combustivelOperacaoFinal,
        "origemCombustivel": origemCombustivel,
        "destinoCombustivel": destinoCombustivel,
        "quantidadeCombustivel": quantidadeCombustivel,
      };
}
