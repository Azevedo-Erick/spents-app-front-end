import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/transactions_overview_controller.dart';
import '../widgets/category_widget.dart';
import '../widgets/transaction_widget.dart';

class TransactionsOverview extends StatefulWidget {
  const TransactionsOverview({Key? key}) : super(key: key);

  @override
  State<TransactionsOverview> createState() => _TransactionsOverviewState();
}

class _TransactionsOverviewState extends State<TransactionsOverview> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionOverviewController>(context, listen: false)
        .transactions;
  }

  @override
  Widget build(BuildContext context) {
    TransactionOverviewController controller =
        Provider.of<TransactionOverviewController>(context);
    bool showingAll = true;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Gastos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/new-data'),
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
              controller.categories.isNotEmpty
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
                          return TextButton(
                              onPressed: (() {
                                controller.filterTransactionsByCategory(
                                    controller.categories[index]);
                                setState(() {
                                  showingAll = false;
                                });
                                ;
                              }),
                              child: CategoryWidget(
                                  name: controller.categories[index].name));
                        },
                        itemCount: controller.categories.length,
                      ),
                    )
                  : Container(),
              const SizedBox(height: 20),
              Expanded(
                flex: 6,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: ListView.separated(
                    itemBuilder: (context, index) => TransactionWidget(
                      transaction: showingAll
                          ? controller.transactions[index]
                          : controller.transactionsFiltered[index],
                    ),
                    itemCount: showingAll
                        ? controller.transactions.length
                        : controller.transactionsFiltered.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}