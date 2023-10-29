class Apontamento {
//  final String codApontamento;
  final DateTime dataApontamento;
  final String veiculoPlaca;
  final String combustivel;
  final double odometroInicial;
  final double odometroFinal;
  final double registroTanqueInicial;
  final double registroTanqueFinal;
  final String regAeronave;
  final double tanqueAeronaveInicial;
  final double tanqueAeronaveFinal;

  const Apontamento(
      { //required this.codApontamento,
      required this.dataApontamento,
      required this.veiculoPlaca,
      required this.combustivel,
      required this.odometroInicial,
      required this.odometroFinal,
      required this.registroTanqueInicial,
      required this.registroTanqueFinal,
      required this.regAeronave,
      required this.tanqueAeronaveInicial,
      required this.tanqueAeronaveFinal});

  Map<String, dynamic> toJson() => {
        // "codApontamento": codApontamento,
        "dataApontamento": dataApontamento,
        "veiculoPlaca": veiculoPlaca,
        "combustivel": combustivel,
        "odometroInicial": odometroInicial,
        "odometroFinal": odometroFinal,
        "registroTanqueInicial": registroTanqueInicial,
        "registroTanqueFinal": registroTanqueFinal,
        "regAeronave": regAeronave,
        "tanqueAeronaveInicial": tanqueAeronaveInicial,
        "tanqueAeronaveFinal": tanqueAeronaveFinal
      };
}
