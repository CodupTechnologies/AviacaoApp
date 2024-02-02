import 'package:aviacao_app/modules/abastecimento/atualizar_abastecimento_page.dart';
import 'package:aviacao_app/modules/apontamento/atualizarApontamento_page.dart';
import 'package:aviacao_app/shared/widgets/card_historicoAbastecimento.dart';
import 'package:aviacao_app/shared/widgets/card_historicoApontamento.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../shared/themes/app_colors.dart';
import '../../shared/widgets/regular_button.dart';

final user = FirebaseAuth.instance.currentUser!;
bool loading = true;
bool order = true;
Map<String, dynamic> mapa = {};

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
    await FirebaseFirestore.instance.collection('users').doc(_user).get().then(
        (DocumentSnapshot doc) {
      // dataa = doc.data() as Map<String, dynamic>;
    }, onError: (e) => print("Erro de download de dados"));
    setState(() {});
  }

  final user = FirebaseAuth.instance.currentUser!;
  bool loading = false;
  DateTimeRange selectedDatesApontamento =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  DateTimeRange selectedDatesAbastecimento =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  var dateCtlApontamento = TextEditingController();
  var dateCtlAbastecimento = TextEditingController();
  String demoDataInicialApontamento = "", demoDataFinalApontamento = "";
  String demoDataInicialAbastecimento = "", demoDataFinalAbastecimento = "";
  DateTime agora = DateTime.now();
  var data = Map<String, dynamic>;
  late DateTime dataAbastecimento;
  late DateTime dataApontamento;

  void dispose() {
    dateCtlApontamento.dispose();
    dateCtlAbastecimento.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Histórico'),
            centerTitle: true,
            backgroundColor: AppColors.primary,
            bottom: const TabBar(indicatorColor: Color(0xFFFFB30D), tabs: [
              Tab(
                child: Text(
                  'Apontamento',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  'Abastecimento',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
            ]),
          ),
          body: TabBarView(children: <Widget>[
            Column(
              children: [
                Row(children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 12, right: 15, left: 15),
                      child: TextFormField(
                        readOnly: true,
                        controller: dateCtlApontamento,
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
                              borderSide: BorderSide(
                                  color: AppColors.stroke, width: 1.0),
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
                          final DateTimeRange? dateTimeRangeApontamento =
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
                          if (dateTimeRangeApontamento != null) {
                            setState(() {
                              selectedDatesApontamento =
                                  dateTimeRangeApontamento;
                              demoDataInicialApontamento =
                                  "${selectedDatesApontamento.start.day}/${selectedDatesApontamento.start.month}/${selectedDatesApontamento.start.year}";
                              demoDataFinalApontamento =
                                  "${selectedDatesApontamento.end.day}/${selectedDatesApontamento.end.month}/${selectedDatesApontamento.end.year}";
                              dateCtlApontamento.text =
                                  "De: ${demoDataInicialApontamento} até ${demoDataFinalApontamento}";
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
                                selectedDatesApontamento = DateTimeRange(
                                    start: DateTime.now(), end: DateTime.now());
                                dateCtlApontamento.text = "";
                                demoDataInicialApontamento = "";
                                demoDataFinalApontamento = "";
                              });
                            },
                            loading: loading),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            order = !order;
                          });
                        },
                        child: Row(
                          children: [
                            Text("Reordenar data"),
                            IconButton(
                              icon: Icon(Icons.date_range_outlined),
                              onPressed: () {
                                setState(() {
                                  order = !order;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('AVP_Apontamentos')
                          .orderBy('dataApontamento', descending: order)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting &&
                            !snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                    snapshot.data!.docs[index];

                                var data = snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;

                                chamaCardApontamento(String usera) {
                                  return CardHistoricoApontamento(
                                      context, usera, documentSnapshot);
                                }

                                if (_user.toString() ==
                                    data['codUser'].toString()) {
                                  dataApontamento =
                                      (data['dataApontamento'] as Timestamp)
                                          .toDate();

                                  if (demoDataFinalApontamento != '') {
                                    if (dataApontamento.isAfter(
                                            selectedDatesApontamento.start) &&
                                        dataApontamento.isBefore(
                                            selectedDatesApontamento.end)) {
                                      return chamaCardApontamento(
                                          _user.toString());
                                    }
                                  } else {
                                    return chamaCardApontamento(
                                        _user.toString());
                                  }
                                }

                                return Container();
                              });
                        }
                        return Center(
                            child: Text(
                                "Ainda não encontramos nenhum exames cadastrados"));
                      }),
                )
                // CardHistoricoApontamento(context, () => null, 'Kelvin', mapa) Card Aqui
              ],
            ),

            /*
            *
            *Aqui muda para o outro Lado
            *
            */

            Column(
              children: [
                Row(children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 12, right: 15, left: 15),
                      child: TextFormField(
                        readOnly: true,
                        controller: dateCtlAbastecimento,
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
                              borderSide: BorderSide(
                                  color: AppColors.stroke, width: 1.0),
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
                              selectedDatesAbastecimento = dateTimeRange;
                              demoDataInicialAbastecimento =
                                  "${selectedDatesAbastecimento.start.day}/${selectedDatesAbastecimento.start.month}/${selectedDatesAbastecimento.start.year}";
                              demoDataFinalAbastecimento =
                                  "${selectedDatesAbastecimento.end.day}/${selectedDatesAbastecimento.end.month}/${selectedDatesAbastecimento.end.year}";
                              dateCtlAbastecimento.text =
                                  "De: ${demoDataInicialAbastecimento} até ${demoDataFinalAbastecimento}";
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
                                selectedDatesAbastecimento = DateTimeRange(
                                    start: DateTime.now(), end: DateTime.now());
                                dateCtlAbastecimento.text = "";
                                demoDataInicialAbastecimento = "";
                                demoDataFinalAbastecimento = "";
                              });
                            },
                            loading: loading),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            order = !order;
                          });
                        },
                        child: Row(
                          children: [
                            Text("Reordenar data"),
                            IconButton(
                              icon: Icon(Icons.date_range_outlined),
                              onPressed: () {
                                setState(() {
                                  order = !order;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('AVP_Abastecimentos')
                          .orderBy('dataAbastecimento', descending: order)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting &&
                            !snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                    snapshot.data!.docs[index];

                                var data = snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;

                                chamaCard(String usera) {
                                  return CardHistoricoAbastecimento(
                                      context, usera, documentSnapshot);
                                }

                                if (_user.toString() ==
                                    data['codUser'].toString()) {
                                  dataAbastecimento =
                                      (data['dataAbastecimento'] as Timestamp)
                                          .toDate();

                                  if (demoDataFinalAbastecimento != '') {
                                    if (dataAbastecimento.isAfter(
                                            selectedDatesAbastecimento.start) &&
                                        dataAbastecimento.isBefore(
                                            selectedDatesAbastecimento.end)) {
                                      return chamaCard(_user.toString());
                                    }
                                  } else {
                                    return chamaCard(_user.toString());
                                  }
                                }

                                return Container();
                              });
                        }
                        return Center(
                            child: Text(
                                "Ainda não encontramos nenhum exames cadastrados"));
                      }),
                )
                // CardHistoricoApontamento(context, () => null, 'Kelvin', mapa) Card Aqui
              ],
            ),
          ])),
    );
  }
}
