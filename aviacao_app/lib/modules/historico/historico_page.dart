import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../shared/themes/app_colors.dart';
import '../../shared/widgets/regular_button.dart';

const List<String> listaApontamentos = <String>[
  'Todos Apontamentos',
  'Ponto',
  'Abastecimento',
  'Transferência',
  'Troca',
];

final user = FirebaseAuth.instance.currentUser!;
String CRMControler = 'loading';
String MedicoControler = 'loading';
bool loading = true;
bool order = true;

class HistoricoPage extends StatefulWidget {
  HistoricoPage({Key? key}) : super(key: key);

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  final _user = FirebaseAuth.instance.currentUser!.uid.toString();
  late List<Map<String, dynamic>> items;
  bool isLoaded = false;
  late AsyncSnapshot<QuerySnapshot> snapshot;

  Future BringDataFromFirebase() async {
    var data = Map();
    await FirebaseFirestore.instance.collection('users').doc(_user).get().then(
        (DocumentSnapshot doc) {
      data = doc.data() as Map<String, dynamic>;
    }, onError: (e) => print("Erro de download de dados"));
    setState(() {
      CRMControler = data['UserCRM'].toString();
      MedicoControler = data['UserFirstName'].toString();
    });
  }

  final user = FirebaseAuth.instance.currentUser!;
  bool loading = false;
  String dropdownApontamento = listaApontamentos.first;
  DateTimeRange selectedDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  var dateCtl2 = TextEditingController();
  String demoDataInicial = "", demoDataFinal = "";
  DateTime agora = DateTime.now();
  late DateTime dataExame_temp;

  void dispose() {
    dateCtl2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, right: 15, left: 15),
              child: DropdownButtonFormField<String>(
                value: dropdownApontamento,
                icon: const Icon(Icons.arrow_drop_down_circle),
                elevation: 16,
                style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                onChanged: (String? value) {
                  setState(() {
                    dropdownApontamento = value!;
                  });
                },
                items: listaApontamentos // lista de clinicas
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.stroke,
                  contentPadding: const EdgeInsets.only(left: 20, right: 10),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, right: 15, left: 15),
                  child: TextFormField(
                    readOnly: true,
                    controller: dateCtl2,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 20),
                      fillColor: AppColors.primary,
                      isDense: true,
                      hintText: "Selecione a Data: ",
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.calendar_month_outlined,
                          size: 20,
                          color: AppColors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.stroke, width: 1.0),
                          borderRadius: BorderRadius.circular(40)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onTap: () async {
                      final DateTimeRange? dateTimeRange =
                          await showDateRangePicker(
                              helpText: 'Selecione as datas',
                              saveText: 'Salvar',
                              confirmText: 'Salvar',
                              cancelText: 'Cancelar',
                              fieldEndLabelText: 'Data Final',
                              fieldStartLabelText: 'Data Inicial',
                              fieldEndHintText: 'Data Final',
                              fieldStartHintText: 'Data Inicial',
                              context: context,
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: AppColors.primary,
                                      onPrimary: AppColors.white,
                                      onSurface: Colors.black,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary: AppColors.vermelho2,
                                        // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2500));
                      if (dateTimeRange != null) {
                        setState(() {
                          selectedDates = dateTimeRange;
                          demoDataInicial =
                              "${selectedDates.start.day}/${selectedDates.start.month}/${selectedDates.start.year}";
                          demoDataFinal =
                              "${selectedDates.end.day}/${selectedDates.end.month}/${selectedDates.end.year}";
                          dateCtl2.text =
                              "De: ${demoDataInicial} até ${demoDataFinal}";
                        });
                      }
                    },
                  ),
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                right: 20,
                left: 20,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: RegularButton(
                        textoBotao: 'Limpar campos',
                        onTap: () {
                          setState(() {
                            dropdownApontamento = listaApontamentos.first;
                            selectedDates = DateTimeRange(
                                start: DateTime.now(), end: DateTime.now());
                            dateCtl2.text = "";
                            demoDataInicial = "";
                            demoDataFinal = "";
                          });
                        },
                        loading: loading),
                  ),
                  InkWell(
                    onTap: () {
                      order = !order;
                    },
                    child: Row(
                      children: [
                        Text("Reordenar data"),
                        IconButton(
                          icon: Icon(Icons.date_range_outlined),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
