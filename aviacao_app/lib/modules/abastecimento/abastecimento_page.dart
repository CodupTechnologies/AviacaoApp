import 'package:aviacao_app/modules/abastecimento/abatecimento_controller.dart';
import 'package:aviacao_app/shared/themes/app_inputDecoration.dart';
import 'package:aviacao_app/shared/themes/app_text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../shared/themes/app_colors.dart';
import '../../shared/themes/style_guidelines.dart';
import '../../shared/widgets/card_apontamento.dart';

const List<String> tipoAbastecimento = <String>[
  'Selecione o tipo',
  'Transferência',
  'Abastecimento Aeronave',
  'Abastecimento Veículo'
];

class AbastecimentoPage extends StatefulWidget {
  const AbastecimentoPage({super.key});

  @override
  State<AbastecimentoPage> createState() => _AbastecimentoPageState();
}

class _AbastecimentoPageState extends State<AbastecimentoPage> {
  final dateController = TextEditingController();
  final quantidadeController = TextEditingController();
  final combustivelController = TextEditingController();
  final horaController = TextEditingController();
  final tipoController = TextEditingController();
  final odometroIncioController = TextEditingController();
  final odometroFinalcontroller = TextEditingController();
  final origemController = TextEditingController();
  final destinoController = TextEditingController();
  final observacaoController = TextEditingController();
  var nome = "0";
  DateTime dataSelecionada = DateTime.now();
  final DateTime _date = DateTime.now();

  final _user = FirebaseAuth.instance.currentUser!;
  bool loading = true;
  String dropdownCombustiveis = "0";
  String dropdownAbastecimento = tipoAbastecimento.first;
  String estoqueOrigem = '220';
  String estoqueDestino = '420';

  Future<Null> _selectcDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
      helpText: 'Escolha uma data.',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.grey,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.vermelho2,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _date) {
      setState(() {
        dataSelecionada = picked;
        dateController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  returnCombustiveis(String cod) async {
    await FirebaseFirestore.instance
        .collection('cod')
        .doc()
        .get()
        .then((DocumentSnapshot dock) {
      if (dock.exists) {
        final combustivel = dock.data() as Map<String, dynamic>;
        setState(() {
          nome = combustivel['nome'].toString();
        });
      } else {
        setState(() {
          nome = "0";
        });
      }
    });
  }

  // Future BringDataFromFirebase() async {
  //   var data = Map();
  //   await FirebaseFirestore.instance.collection('users').doc(_user).get().then(
  //       (DocumentSnapshot doc) {
  //     data = doc.data() as Map<String, dynamic>;
  //   }, onError: (e) => print("Erro de download de dados"));
  //   setState(() {
  //     CRMControler = data['UserCRM'].toString();
  //     MedicoControler = data['UserFirstName'].toString();
  //   });
  // }

  void dispose() {
    quantidadeController.dispose();
    dateController.dispose();
    combustivelController.dispose();
    horaController.dispose();
    tipoController.dispose();
    odometroFinalcontroller.dispose();
    odometroIncioController.dispose();
    origemController.dispose();
    destinoController.dispose();
    observacaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: const Text('Abastecimento'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    '*Preencha os dados do apontamento',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, right: 10, left: 10),
                  child: Form(
                      child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: size.width * 0.15),
                            Expanded(
                              child: TextFormField(
                                controller: dateController,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 84, 85, 85),
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 20),
                                  fillColor: AppColors.fundoCard,
                                  isDense: true,
                                  hintText: "Data: ",
                                  filled: true,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Icon(
                                      Icons.calendar_month,
                                      size: 25,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.fundoCard,
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(40)),
                                ),
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  _selectcDate(context);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(width: size.width * 0.15),
                          ]),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Responsável: ",
                              style: AppTextStyles.chamaUser,
                            ),
                            Text(
                              _user.email.toString(),
                              style: AppTextStyles.userText,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Propriedades",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("AVP_Combustiveis")
                              .snapshots(),
                          // initialData: initialData,
                          builder: (context, snapshot) {
                            List<DropdownMenuItem> combustivelItens = [];
                            if (!snapshot.hasData) {
                              CircularProgressIndicator();
                            } else {
                              final combustiveis = snapshot.data?.docs.toList();
                              combustivelItens.add(DropdownMenuItem(
                                  value: "0",
                                  child: Text('Selecione o combustível...')));
                              for (var combustivel in combustiveis!) {
                                combustivelItens.add(DropdownMenuItem(
                                    value: combustivel.id,
                                    child:
                                        Text(combustivel['nome'].toString())));
                              }
                            }
                            return DropdownButtonFormField(
                              items: combustivelItens,
                              onChanged: (nome) {
                                setState(() {
                                  dropdownCombustiveis = nome;
                                  returnCombustiveis(nome);
                                });
                              },
                              value: dropdownCombustiveis,
                              icon: const Icon(Icons.arrow_drop_down_circle),
                              elevation: 16,
                              style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                              decoration: AppInputDecoration.mainDecorator,
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("AVP_Combustiveis")
                                  .snapshots(),
                              // initialData: initialData,
                              builder: (context, snapshot) {
                                List<DropdownMenuItem> combustivelItens = [];
                                if (!snapshot.hasData) {
                                  CircularProgressIndicator();
                                } else {
                                  final combustiveis =
                                      snapshot.data?.docs.toList();
                                  combustivelItens.add(DropdownMenuItem(
                                      value: "0", child: Text('Origem: ')));
                                  for (var combustivel in combustiveis!) {
                                    combustivelItens.add(DropdownMenuItem(
                                        value: combustivel.id,
                                        child: Text(
                                            combustivel['nome'].toString())));
                                  }
                                }
                                return Container(
                                  height: 48,
                                  width: size.width * 0.42,
                                  child: DropdownButtonFormField(
                                      items: combustivelItens,
                                      onChanged: (nome) {
                                        setState(() {
                                          dropdownCombustiveis = nome;
                                          returnCombustiveis(nome);
                                        });
                                      },
                                      value: dropdownCombustiveis,
                                      icon: const Icon(
                                          Icons.arrow_drop_down_circle),
                                      elevation: 14,
                                      style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.fundoCard,
                                        contentPadding: const EdgeInsets.only(
                                            left: 20, right: 10),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      )),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10, left: 10),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("AVP_Combustiveis")
                                  .snapshots(),
                              // initialData: initialData,
                              builder: (context, snapshot) {
                                List<DropdownMenuItem> combustivelItens = [];
                                if (!snapshot.hasData) {
                                  CircularProgressIndicator();
                                } else {
                                  final combustiveis =
                                      snapshot.data?.docs.toList();
                                  combustivelItens.add(DropdownMenuItem(
                                      value: "0", child: Text('Destino:')));
                                  for (var combustivel in combustiveis!) {
                                    combustivelItens.add(DropdownMenuItem(
                                        value: combustivel.id,
                                        child: Text(
                                            combustivel['nome'].toString())));
                                  }
                                }
                                return Container(
                                  height: 48,
                                  width: size.width * 0.42,
                                  child: DropdownButtonFormField(
                                      items: combustivelItens,
                                      onChanged: (nome) {
                                        setState(() {
                                          dropdownCombustiveis = nome;
                                          returnCombustiveis(nome);
                                        });
                                      },
                                      value: dropdownCombustiveis,
                                      icon: const Icon(
                                          Icons.arrow_drop_down_circle),
                                      elevation: 14,
                                      style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.fundoCard,
                                        contentPadding: const EdgeInsets.only(
                                            left: 20, right: 10),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      )),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: odometroIncioController,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 84, 85, 85),
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 15, top: 20),
                                fillColor: AppColors.fundoCard,
                                isDense: true,
                                hintText: "Inicial: ",
                                filled: true,
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Icon(
                                    Icons.speed_sharp,
                                    size: 25,
                                  ),
                                ),
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
                          SizedBox(width: 15),
                          Expanded(
                            child: TextFormField(
                              controller: odometroFinalcontroller,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 84, 85, 85),
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 15, top: 20),
                                fillColor: AppColors.fundoCard,
                                isDense: true,
                                hintText: "Final: ",
                                filled: true,
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Icon(
                                    Icons.speed_sharp,
                                    size: 25,
                                  ),
                                ),
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
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: size.width * 0.9,
                          child: TextFormField(
                            controller: quantidadeController,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 84, 85, 85),
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 20, top: 20, right: 15),
                              fillColor: AppColors.fundoCard,
                              isDense: true,
                              hintText: "Quantidade: ",
                              filled: true,
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Icon(
                                  Icons.gas_meter,
                                  size: 25,
                                ),
                              ),
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Estoque',
                                style: AppTextStyles.innerTitle,
                              )
                            ]),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Origem: ",
                                style: AppTextStyles.labelStoc,
                              ),
                              Text(
                                estoqueOrigem + 'L',
                                style: AppTextStyles.labelResultStock,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Destino: ",
                                style: AppTextStyles.labelStoc,
                              ),
                              Text(
                                estoqueDestino + 'L',
                                style: AppTextStyles.labelResultStock,
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        Expanded(
                          child: TextField(
                            controller: observacaoController,
                            keyboardType: TextInputType.multiline,
                            minLines: 4,
                            maxLines: 7,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 84, 85, 85),
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 20, top: 30),
                              fillColor: AppColors.fundoCard,
                              isDense: true,
                              hintText: "Observações:",
                              filled: true,
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Icon(
                                  Icons.remove_red_eye_outlined,
                                  size: 22,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                            child: Text('Excluir'),
                            style: exluirButton,
                            onPressed: () {},
                          )),
                          SizedBox(width: 20),
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {
                              if (dateController != '' &&
                                  horaController != '') {
                                saveAbastecimento(
                                    dataSelecionada,
                                    horaController.text,
                                    dropdownAbastecimento,
                                    dropdownCombustiveis,
                                    odometroIncioController.text,
                                    odometroFinalcontroller.text,
                                    origemController.text,
                                    destinoController.text,
                                    quantidadeController.text,
                                    context);
                                Future.delayed(const Duration(seconds: 2), () {
                                  Navigator.pop(context);
                                  print(
                                      'One second has passed.'); // Prints after 1 second.
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Os campos de Data e hora são obrigatórios')));
                              }
                            },
                            child: Text('Salvar'),
                            style: saveButton,
                          )),
                        ],
                      )
                    ],
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
