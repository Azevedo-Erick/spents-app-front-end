import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spents_app/models/transaction_model.dart';
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
  Transaction? _selectedTransaction;
  void selectTransaction(Transaction? transaction) {
    setState(() {
      _selectedTransaction = transaction;
      showModalBottomSheet(
          context: context,
          backgroundColor: Colors.blueGrey.shade900,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedTransaction?.title ?? '',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                      ),
                      Text(
                        _selectedTransaction?.date.toIso8601String() ?? '',
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      CategoryWidget(
                          name: _selectedTransaction!.category.name,
                          color: _selectedTransaction!.category.color)
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: Colors.black,
                      ),
                      Text(
                        _selectedTransaction?.value.toStringAsFixed(2) ?? '',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      _selectedTransaction?.description ?? '',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  //Container for the description of the transaction if it exists
                  SizedBox(height: 16),
                  Container(
                    height: _selectedTransaction?.description != null
                        ? MediaQuery.of(context).size.height * 0.12
                        : 0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade600,
                    ),
                    child: Center(
                      child: Text(
                        _selectedTransaction?.description ?? '',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.yellow,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    TransactionOverviewController controller =
        Provider.of<TransactionOverviewController>(context);

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            BarChartWidget(),
            const SizedBox(height: 20),
            Expanded(
                child: Column(children: [
              controller.categories.isNotEmpty
                  ? Expanded(
                      flex: 2,
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
                            parent: BouncingScrollPhysics(),
                          ),
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
                              ),
                            );
                          },
                          itemCount: controller.categories.length,
                        ),
                      ),
                    )
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
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: ListView.separated(
                    itemBuilder: (context, index) => TransactionWidget(
                      transaction: showingAll
                          ? controller.transactions[index]
                          : controller.transactionsFiltered[index],
                      selectTransaction: selectTransaction,
                      selectedTransaction: _selectedTransaction,
                    ),
                    itemCount: showingAll
                        ? controller.transactions.length
                        : controller.transactionsFiltered.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 10,
                    ),
                  ),
                ),
              ),
            ]))
          ],
        ),
      ),
    );
  }
}
