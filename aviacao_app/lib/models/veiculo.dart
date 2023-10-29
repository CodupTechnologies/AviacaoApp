class Veiculo {
  final String
      nome; // nome do veiculo internamente, pode ser usado para caracterização
  final String placa; // Placa do veiculo
  final String
      descricao; // Campo que pode ser utilizado para descrever de forma detalhada o veiculo
  final String
      combustivel; // Tipo do veiculo que o motor do veiculo utlizado ex: Diesel
  final double tanqueTotal; // Tanque total do veiculo
  final double tanqueAtual; // Tanque do veiculo atual
  final double
      combustivelTransporteTipo; // Tipo do combustivel Transportado no veículo
  final double
      combustivelTransporteTotal; // Capacidade total de carregamento de combustivel
  final double combustivelTransporteAtual; // Carga Atual de combustível
  final double
      registroBombaAtual; // Numeração atual do registro de combustivel da bomba do veiculo
  final double odometroAtual; // Odometro atual do veiculo
  final DateTime
      dataAtualizacao; // data da Ultima atualização de dados do veiculo.

  const Veiculo(
      {required this.nome,
      required this.placa,
      required this.descricao,
      required this.combustivel,
      required this.tanqueTotal,
      required this.tanqueAtual,
      required this.combustivelTransporteTipo,
      required this.combustivelTransporteTotal,
      required this.combustivelTransporteAtual,
      required this.registroBombaAtual,
      required this.odometroAtual,
      required this.dataAtualizacao});

  Map<String, dynamic> toJson() => {
        "nome": nome,
        "placa": placa,
        "descricao": descricao,
        "combustivel": combustivel,
        "tanqueTotal": tanqueTotal,
        "tanqueAtual": tanqueAtual,
        "combustivelTransporteTipo": combustivelTransporteTipo,
        "combustivelTransporteTotal": combustivelTransporteTotal,
        "combustivelTransporteAtual": combustivelTransporteAtual,
        "registroBombaAtual": registroBombaAtual,
        "odometroAtual": odometroAtual,
        "dataAtualizacao": dataAtualizacao,
      };
}
