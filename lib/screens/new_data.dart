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
    value: 0,
    type: Type.SPENT,
    category: Category(
      id: '',
      name: '',
    ),
  );
  Category _category = Category(
    id: '',
    name: '',
  );
  int _index = 0;
  final _formKey = GlobalKey<FormState>();
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
              child: Column(
                children: [
                  SafeArea(child: SizedBox(height: 20)),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Título',
                      icon: Icon(Icons.title),
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      _transaction.title = value;
                    },
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
                    onChanged: (value) => _transaction.description = value,
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
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => TextButton(
                        onPressed: () {
                          setState(() {
                            _transaction.category =
                                newDataController.categories[index];
                          });
                        },
                        child: Text(
                          newDataController.categories[index].name,
                          style: TextStyle(
                            color: _transaction.category ==
                                    newDataController.categories[index]
                                ? Colors.blue
                                : null,
                          ),
                        ),
                      ),
                      itemCount: newDataController.categories.length,
                      separatorBuilder: (context, index) => const Divider(),
                    ),
                  ),
                  ...Type.values
                      .map((e) => TextButton(
                          onPressed: () {
                            setState(() {
                              _transaction.type = e;
                            });
                          },
                          child: Text(e.name,
                              style: TextStyle(
                                color:
                                    _transaction.type == e ? Colors.blue : null,
                              ))))
                      .toList(),
                  TextButton(
                      onPressed: () => {
                            newDataController.addTransaction(_transaction),
                            transactionOverviewController.reloadData()
                          },
                      child: Text("Criar"))
                ],
              ),
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
                TextButton(
                    onPressed: () => {
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
