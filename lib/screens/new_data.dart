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
            Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Título',
                  ),
                  onChanged: (value) {
                    _transaction.title = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                  ),
                  onChanged: (value) => _transaction.description = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Preencha a descrição';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Valor',
                  ),
                  onChanged: (value) =>
                      _transaction.value = double.parse(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Preencha o valor';
                    }
                    return null;
                  },
                ),
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
                        child: Text(e.toString(),
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
