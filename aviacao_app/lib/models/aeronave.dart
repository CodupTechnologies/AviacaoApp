class Aeronave {
  // final String codAeronave;
  final String nomeAeronave;
  final String codRegistro;
  final String descricao;
  final String combustivel;
  final double tanqueTotal;
  final double tanqueAtual;

  const Aeronave(
      { //required this.codAeronave,
      required this.nomeAeronave,
      required this.codRegistro,
      required this.descricao,
      required this.combustivel,
      required this.tanqueTotal,
      required this.tanqueAtual});

  Map<String, dynamic> toJson() => {
        //   "codAeronave": codAeronave,
        "nomeAeronave": nomeAeronave,
        "codRegistro": codRegistro,
        "descricao": descricao,
        "combustivel": combustivel,
        "tanqueTotal": tanqueTotal,
        "tanqueAtual": tanqueAtual,
      };
}
