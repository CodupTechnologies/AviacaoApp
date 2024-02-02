import 'package:cloud_firestore/cloud_firestore.dart';

Future setTurnos(String codUser, DateTime dataHora, String posLatitude,
    String posLongitude, bool tipoLancamento) async {
  int counterPonts = 0;
  var data = Map();
  DateTime dataPonto;
  final agora = DateTime.now();
  String especiePonto = '';

  await FirebaseFirestore.instance
      .collection('AVP_ControlePonto')
      .where('codUser', isEqualTo: codUser)
      .get()
      .then((QuerySnapshot) {
    print('ok');
    for (var docSnapshot in QuerySnapshot.docs) {
      data = docSnapshot.data() as Map<String, dynamic>;
      dataPonto = (data['dataHoraPonto'] as Timestamp).toDate();
      if (dataPonto.day == agora.day &&
          dataPonto.month == agora.month &&
          dataPonto.year == agora.year) {
        counterPonts++;
      }
    }
    if (counterPonts == 0) {
      especiePonto = 'Abertura';
      print(especiePonto);
    } else if (counterPonts.isEven) {
      especiePonto = 'Abertura';
      print(especiePonto);
      // se é par
    } else if (counterPonts.isOdd) {
      especiePonto = 'Fechamento';
      print(especiePonto);
      // se é impar
    }
  });

  await FirebaseFirestore.instance.collection('AVP_ControlePonto').add({
    'codUser': codUser,
    'dataHoraPonto': dataHora,
    'turnoLatitude': posLatitude,
    'turnoLongitude': posLongitude,
    'tipoPonto': especiePonto,
    'intervaloAlmoco': tipoLancamento, // almoço ou não
  }).then((res) => print("Ponto registrado com sucesso"),
      onError: (e) => print("Erro no Lançamento"));
}
