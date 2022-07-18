import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:spents_app/models/category_model.dart';
import 'package:spents_app/repositories/category_repository.dart';
import 'package:spents_app/repositories/transaction_repository.dart';

import '../widgets/category_widget.dart';
import '../widgets/transaction_widget.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryRepository>(context, listen: false).getAllCategories();
    Provider.of<TransactionRepository>(context, listen: false)
        .getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    CategoryRepository repo = Provider.of<CategoryRepository>(context);
    TransactionRepository transactionRepo =
        Provider.of<TransactionRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Gastos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/new-spent'),
          ),
        ],
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Meus Gastos',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: ListTile(
                    title: const Text('Meu Perfil'),
                    trailing: const Icon(Icons.person),
                  )),
              TextButton(
                child: const ListTile(
                  title: Text('Sair'),
                  trailing: Icon(Icons.exit_to_app),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/new_spent');
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(children: [
          Expanded(
            child: Column(children: [
              repo.categories.isNotEmpty
                  ? Expanded(
                      flex: 1,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 10,
                        ),
                        scrollDirection: Axis.horizontal,
                        physics: const ScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        itemBuilder: (BuildContext context, int index) {
                          return CategoryWidget(
                              name: repo.categories[index].name);
                        },
                        itemCount: repo.categories.length,
                      ),
                    )
                  : Container(),
              const SizedBox(height: 20),
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    child: Column(
                      children: [
                        for (var transaction in transactionRepo.transactions)
                          TransactionWidget(
                            transaction: transaction,
                          ),
                      ],
                    ),
                  ),
                ),
              )
            ]),
          ),
        ]),
      ),
    );
  }
}
