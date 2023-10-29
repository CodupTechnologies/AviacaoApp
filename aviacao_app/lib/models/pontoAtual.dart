class PontoAtual {
  final String codUser;
  final String nome;
  final DateTime horaPonto;
  final String latitude;
  final String longitude;
  final String tipoPonto;

  const PontoAtual({
    required this.codUser,
    required this.nome,
    required this.horaPonto,
    required this.latitude,
    required this.longitude,
    required this.tipoPonto,
  });

  Map<String, dynamic> toJson() => {
        "codUser": codUser,
        "nome": nome,
        "horaPonto": horaPonto,
        "latitude": latitude,
        "longitude": longitude,
        "tipoPonto": tipoPonto
      };
}
