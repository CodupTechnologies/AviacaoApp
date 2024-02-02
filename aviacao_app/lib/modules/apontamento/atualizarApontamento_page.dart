import 'package:aviacao_app/modules/apontamento/apontamente_controller.dart';
import 'package:aviacao_app/shared/themes/app_colors.dart';
import 'package:aviacao_app/shared/themes/style_guidelines.dart';
import 'package:aviacao_app/shared/widgets/usefull_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

List<String> listaCombustiveis = <String>[
  'Selecione o combustível',
  'Etanol',
  'Avgas',
  'JET A1',
];

class AtualizarApontamentoPage extends StatefulWidget {
  AtualizarApontamentoPage(this.documentSnapshotApontamento, {super.key});
  DocumentSnapshot documentSnapshotApontamento;
  @override
  State<AtualizarApontamentoPage> createState() =>
      _AtualizarApontamentoPageState();
}

class _AtualizarApontamentoPageState extends State<AtualizarApontamentoPage> {
  final veiculoController = TextEditingController();
  final dateController = TextEditingController();
  final aeronaveController = TextEditingController();
  final quantidadeInicialTanqueController = TextEditingController();
  final quantidadeFinalTanqueController = TextEditingController();
  final tipocombustivelController = TextEditingController();
  final KMIncioController = TextEditingController();
  final KMFinalController = TextEditingController();
  final horarioController = TextEditingController();
  final tanqueAeronaveInicialController = TextEditingController();
  final tanqueAeronaveFinalController = TextEditingController();
  final observacaoController = TextEditingController();

  String receberData = '';
  Map<String, dynamic> veiculoMap = {};
  bool setter = false;
  bool editavel = false;
  String uidDocumento = '';

  String codVeiculo = "";
  String codAeronave = "";
  String DropdownVeiculos = "Todos";
  String DropdownAeronaves = "Todos";
  var placaVeiculo = "Todos";
  var aviaoBreve = "Todos";
  String condutor = '';
  String placaDoVeiculo = '';

  DateTime dataSelecionada = DateTime.now();
  final DateTime _date = DateTime.now();
  final _user = FirebaseAuth.instance.currentUser!;
  bool loading = true;
  String dropdownCombustiveis = listaCombustiveis.first;

  carregaCamposAeronave(String codigoAeronave) async {
    await FirebaseFirestore.instance
        .collection("AVP_Aeronaves")
        .doc(codigoAeronave)
        .get()
        .then((DocumentSnapshot document) {
      if (document.exists) {
        final veiche = document.data() as Map<String, dynamic>;
        setState(() {
          aeronaveController.text = veiche['codRegistro'].toString();
        });
      } else {
        setState(() {
          aeronaveController.text = '';
        });
      }
    });
  }

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

  returnPlaca(String cod) async {
    await FirebaseFirestore.instance
        .collection('cod')
        .doc()
        .get()
        .then((DocumentSnapshot dock) {
      if (dock.exists) {
        final veiculos = dock.data() as Map<String, dynamic>;
        setState(() {
          placaVeiculo = veiculos['placa'].toString();
        });
      } else {
        setState(() {
          placaVeiculo = "Todos";
        });
      }
    });
  }

  atribuiDados() async {
    String usu = _user.uid.toString();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(usu)
        .get()
        .then((DocumentSnapshot documento) {
      if (documento.exists) {
        final docOf = documento.data() as Map<String, dynamic>;
        setState(() {
          condutor = docOf['nome'].toString();
          DropdownVeiculos = "Todos";
        });
        showDial(
            context,
            "Veículo em uso:",
            'O veiculo selecionado está sendo utilizado por $condutor, portanto escolha outro veículo da lista',
            'OK');
        // bottomMessage(context, 'O veiculo está aberto com: $condutor', 3);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    veiculoController.dispose();
    dateController.dispose();
    aeronaveController.dispose();
    tipocombustivelController.dispose();
    KMIncioController.dispose();
    KMFinalController.dispose();
    observacaoController.dispose();
    super.dispose();
  }

  LoadDataForControllers() async {
    DateTime data1 =
        (widget.documentSnapshotApontamento['dataApontamento'] as Timestamp)
            .toDate();

    String dataString = (data1.day.toString() +
        '/' +
        data1.month.toString() +
        '/' +
        data1.year.toString());

    setState(() {
      widget.documentSnapshotApontamento['odometroFinal'].toString() != ''
          ? KMFinalController.text =
              widget.documentSnapshotApontamento['odometroFinal'].toString()
          : '';
      widget.documentSnapshotApontamento['odometroFinal'].toString() != ''
          ? editavel = false
          : editavel = true;
      KMIncioController.text =
          widget.documentSnapshotApontamento['odometroInicial'].toString();
      dateController.text = dataString;
      DropdownAeronaves =
          widget.documentSnapshotApontamento['regAeronave'].toString();
      DropdownVeiculos =
          widget.documentSnapshotApontamento['veiculoApontamento'].toString();
      setter = true;
      uidDocumento = widget.documentSnapshotApontamento.id.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (setter == false) LoadDataForControllers();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apontamento KM'),
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
                    '*Apenas os campos que não possuem borda vermelha permitem edição',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                      child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                          child: TextFormField(
                            enabled: false,
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
                                      color: AppColors.stroke, width: 1.0),
                                  borderRadius: BorderRadius.circular(40)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.vermelho2, width: 1.0),
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
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 10),
                        child: Text(
                          "Odômetro Veículo",
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
                              .collection("AVP_Automoveis")
                              .snapshots(),
                          // initialData: initialData,
                          builder: (context, snapshot) {
                            List<DropdownMenuItem> veiculosItens = [];
                            if (!snapshot.hasData) {
                              CircularProgressIndicator();
                            } else {
                              final veiculos = snapshot.data?.docs.toList();
                              veiculosItens.add(DropdownMenuItem(
                                  value: "Todos",
                                  child: Text('Selecione o veículo...')));
                              for (var veiculo in veiculos!) {
                                veiculosItens.add(DropdownMenuItem(
                                    value: veiculo.id,
                                    child: Text(veiculo['placa'])));
                              }
                            }
                            return IgnorePointer(
                              ignoring: true,
                              child: DropdownButtonFormField(
                                items: veiculosItens,
                                onChanged: (VeiculoPlaca) {
                                  setState(() {
                                    DropdownVeiculos = VeiculoPlaca;
                                    returnPlaca(VeiculoPlaca);
                                    codVeiculo = VeiculoPlaca.toString();
                                  });
                                },
                                value: DropdownVeiculos,
                                icon: const Icon(Icons.arrow_drop_down_circle),
                                elevation: 16,
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
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.vermelho2,
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(40)),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: KMIncioController,
                              enabled: false,
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
                                hintText: "KM Inicial: ",
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
                                    borderSide: BorderSide(
                                        color: AppColors.vermelho2, width: 1.0),
                                    borderRadius: BorderRadius.circular(40)),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              enabled: editavel,
                              controller: KMFinalController,
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
                                hintText: "KM Final: ",
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
                                    borderSide: BorderSide(
                                        color: AppColors.vermelho2, width: 1.0),
                                    borderRadius: BorderRadius.circular(40)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 10),
                        child: Text(
                          "Dados Aeronave",
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
                              .collection("AVP_Aeronaves")
                              .snapshots(),
                          // initialData: initialData,
                          builder: (context, snapshot) {
                            List<DropdownMenuItem> avioesItens = [];
                            if (!snapshot.hasData) {
                              CircularProgressIndicator();
                            } else {
                              final avioes = snapshot.data?.docs.toList();
                              avioesItens.add(DropdownMenuItem(
                                  value: "Todos",
                                  child: Text('Selecione a aeronave...')));
                              for (var aviao in avioes!) {
                                avioesItens.add(DropdownMenuItem(
                                    value: aviao.id,
                                    child: Text(aviao['codRegistro'])));
                              }
                            }
                            return DropdownButtonFormField(
                              items: avioesItens,
                              onChanged: (AviaoBreve) {
                                setState(() {
                                  DropdownAeronaves = AviaoBreve;
                                  codAeronave = AviaoBreve.toString();
                                  carregaCamposAeronave(AviaoBreve.toString());
                                });
                              },
                              value: DropdownAeronaves,
                              icon: const Icon(Icons.arrow_drop_down_circle),
                              elevation: 16,
                              style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.fundoCard,
                                contentPadding:
                                    const EdgeInsets.only(left: 20, right: 10),
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
                            );
                          },
                        ),
                      ),
                      Row(children: [
                        Expanded(
                          child: TextField(
                            controller: observacaoController,
                            keyboardType: TextInputType.multiline,
                            minLines: 5,
                            maxLines: 7,
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
                              hintText: "Observações:",
                              filled: true,
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
                      SizedBox(
                        height: 10,
                      ),
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
                              atualizarApontamento(
                                  _date,
                                  uidDocumento,
                                  KMFinalController.text.toString(),
                                  DropdownAeronaves,
                                  observacaoController.text,
                                  DropdownVeiculos,
                                  aeronaveController.text,
                                  _user.uid.toString(),
                                  context);
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
