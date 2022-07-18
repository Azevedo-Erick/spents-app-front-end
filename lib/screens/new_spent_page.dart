import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category_model.dart';
import '../models/transaction_model.dart';
import '../models/type_enum.dart';
import '../repositories/category_repository.dart';
import '../repositories/transaction_repository.dart';
import '../widgets/category_widget.dart';

class NewSpentPage extends StatefulWidget {
  const NewSpentPage({Key? key}) : super(key: key);
  @override
  _NewSpentPageState createState() => _NewSpentPageState();
}

class _NewSpentPageState extends State<NewSpentPage> {
  Transaction _transaction = Transaction(
    id: '',
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
    Provider.of<CategoryRepository>(context, listen: false).getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    CategoryRepository categoryRepository =
        Provider.of<CategoryRepository>(context);
    TransactionRepository transactionRepo =
        Provider.of<TransactionRepository>(context);
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
                              categoryRepository.categories[index];
                        });
                      },
                      child: Text(
                        categoryRepository.categories[index].name,
                        style: TextStyle(
                          color: _transaction.category ==
                                  categoryRepository.categories[index]
                              ? Colors.blue
                              : null,
                        ),
                      ),
                    ),
                    itemCount: categoryRepository.categories.length,
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
                    onPressed: () =>
                        transactionRepo.createTransaction(_transaction),
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
                    onPressed: () =>
                        categoryRepository.createCategory(_category),
                    child: Text("Criar"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
