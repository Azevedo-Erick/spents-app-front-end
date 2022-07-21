import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spents_app/controllers/new_data_controller.dart';
import 'package:spents_app/controllers/transactions_overview_controller.dart';

import '../models/category_model.dart';
import '../models/transaction_model.dart';
import '../models/type_enum.dart';

class NewData extends StatefulWidget {
  const NewData({Key? key}) : super(key: key);
  @override
  _NewDataState createState() => _NewDataState();
}

class _NewDataState extends State<NewData> {
  Transaction _transaction = Transaction(
    id: '',
    title: '',
    description: '',
    date: DateTime.now(),
    value: 0,
    type: Type.SPENT,
    category: Category(
      id: '',
      color: '',
      name: '',
    ),
  );
  Category _category = Category(
    id: '',
    color: '',
    name: '',
  );
  int _index = 0;

  double _red = 0, _green = 0, _blue = 0;

  final _formKey = GlobalKey<FormState>();

  String rgbToHex(double color) {
    List<String> elements = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "A",
      "B",
      "C",
      "D",
      "E",
      "F"
    ];
    if (color == "0") {
      return "00";
    }
    double value = color / 16;
    //get only decimal part
    double decimalPart = value - value.floor();
    //get only integer part
    int integerPart = value.floor();
    String hex = "";

    if (integerPart > elements.length - 1) {
      integerPart = elements.length - 1;
    }
    hex += elements[integerPart];

    if (decimalPart * 16 > elements.length - 1) {
      decimalPart = elements.length - 1;
    }
    hex += elements[decimalPart.toInt()];

    return hex;
  }

  @override
  void initState() {
    super.initState();
    Provider.of<NewDataController>(context, listen: false).categories;
  }

  @override
  Widget build(BuildContext context) {
    NewDataController newDataController =
        Provider.of<NewDataController>(context);
    TransactionOverviewController transactionOverviewController =
        Provider.of<TransactionOverviewController>(context);
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          centerTitle: true,
          elevation: 10,
          title: const Text('Adicionando...'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Transação',
              ),
              Tab(
                text: 'Categoria',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey.shade900,
                        ),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => TextButton(
                            onPressed: () {
                              setState(() {
                                _transaction.category =
                                    newDataController.categories[index];
                              });
                            },
                            child: Container(
                              width: 110,
                              height: 33,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: _transaction.category ==
                                        newDataController.categories[index]
                                    ? Colors.greenAccent.shade700
                                    : Colors.green.shade600,
                              ),
                              child: Text(
                                textAlign: TextAlign.center,
                                newDataController.categories[index].name,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          itemCount: newDataController.categories.length,
                          separatorBuilder: (context, index) =>
                              const Divider(color: Colors.black, height: 20),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 5,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Título',
                                        icon: Icon(Icons.title),
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        _transaction.title = value;
                                      },
                                    )),
                                SizedBox(width: 10),
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 3,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blueGrey.shade900,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ...Type.values
                                              .map((e) => GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _transaction.type = e;
                                                    });
                                                  },
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 8),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color:
                                                            _transaction.type ==
                                                                    e
                                                                ? Colors
                                                                    .greenAccent
                                                                    .shade700
                                                                : Colors.green
                                                                    .shade600,
                                                      ),
                                                      child: Text(e.name,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)))))
                                              .toList(),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Descrição',
                                icon: Icon(Icons.description),
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) =>
                                  _transaction.description = value,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Preencha a descrição';
                                }
                                return null;
                              },
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.attach_money),
                                    labelText: 'Valor',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    _transaction.value = double.parse(value);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Preencha o valor';
                                    }
                                    return null;
                                  },
                                )),
                            Center(
                                child: GestureDetector(
                                    onTap: () => {
                                          newDataController
                                              .addTransaction(_transaction),
                                          transactionOverviewController
                                              .reloadData()
                                        },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.9),
                                                blurRadius: 10,
                                                offset: Offset(0, 5),
                                              )
                                            ],
                                            color: Colors.greenAccent.shade700),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Center(
                                            child: Text(
                                          "Adicionar",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )))))
                          ],
                        ))
                  ]),
            ),
            Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  onChanged: (value) => _category.name = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Preencha o nome';
                    }
                    return null;
                  },
                ),
                Slider(
                    value: _red,
                    onChanged: (value) {
                      setState(() {
                        _red = value;
                      });
                    },
                    min: 0,
                    max: 255,
                    label: 'R'),
                Slider(
                    value: _green,
                    onChanged: (value) {
                      setState(() {
                        _green = value;
                      });
                    },
                    min: 0,
                    max: 255,
                    label: 'G'),
                Slider(
                    value: _blue,
                    onChanged: (value) {
                      setState(() {
                        _blue = value;
                      });
                    },
                    min: 0,
                    max: 255,
                    label: 'B'),
                Container(
                  height: 30,
                  width: 30,
                  child: Text(
                      "${rgbToHex(_red)}${rgbToHex(_green)}${rgbToHex(_blue)}"),
                  decoration: BoxDecoration(
                      color: Color(int.parse(
                          "0XFF${rgbToHex(_red)}${rgbToHex(_green)}${rgbToHex(_blue)}"))),
                ),
                TextButton(
                    onPressed: () => {
                          _category.color =
                              "#${rgbToHex(_red)}${rgbToHex(_green)}${rgbToHex(_blue)}",
                          newDataController.addCategory(_category),
                          transactionOverviewController.reloadData()
                        },
                    child: Text("Criar"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
