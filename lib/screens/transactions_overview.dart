import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spents_app/models/week_expenses_model.dart';
import 'package:spents_app/widgets/bar_chart_widget.dart';
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

  bool showingAll = true;
  bool seeingWeekExpenses = true;
  @override
  Widget build(BuildContext context) {
    TransactionOverviewController controller =
        Provider.of<TransactionOverviewController>(context);

    controller.getOneWeekTransactions(DateTime.parse('2022-07-13'));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          title: const Text('Meus Gastos'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => Navigator.pushNamed(context, '/new-data'),
            ),
          ],
        ),
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
          seeingWeekExpenses
              ? Stack(children: [
                  BarChartWidget(weekExpenses: controller.weekExpenses),
                  Positioned(
                      top: 1,
                      right: 2,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              seeingWeekExpenses = false;
                            });
                          },
                          icon: Icon(Icons.close),
                          iconSize: 20,
                          color: Colors.white)),
                ])
              : Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade900,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Stack(
                    children: [
                      Positioned(
                          top: -10,
                          right: -10,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  seeingWeekExpenses = true;
                                });
                              },
                              icon: Icon(Icons.crop_square_rounded),
                              iconSize: 20,
                              color: Colors.white)),
                      Center(
                        child: Text(
                          'Gasto Semanal',
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  )),
          const SizedBox(height: 20),
          Expanded(
            child: Column(children: [
              controller.categories.isNotEmpty
                  ? Expanded(
                      flex: seeingWeekExpenses ? 2 : 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          color: Colors.blueGrey.shade900,
                        ),
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
                                    showingAll = !showingAll;
                                  });
                                }),
                                child: CategoryWidget(
                                  name: controller.categories[index].name,
                                  color: controller.categories[index].color,
                                ));
                          },
                          itemCount: controller.categories.length,
                        ),
                      ))
                  : Container(
                      child: Text("Nenhuma categoria cadastrada"),
                    ),
              const SizedBox(height: 20),
              Expanded(
                flex: 9,
                child: Ink(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
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
                      separatorBuilder: (context, index) => const Divider(
                            height: 10,
                          )),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
