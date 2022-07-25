import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spents_app/controllers/transactions_overview_controller.dart';

import '../models/week_expenses_model.dart';

class BarChartWidget extends StatefulWidget {
  BarChartWidget({Key? key}) : super(key: key);

  @override
  _BarChartWidgetState createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  bool _isCollapsed = false;
  DateTime _selectedDate = DateTime.parse('2022-07-18');
  bool _seeingDate = false;
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionOverviewController>(context, listen: false)
        .getOneWeekTransactions(_selectedDate);
  }

  double _calcMostExpensiveTransaction(
      TransactionOverviewController controller) {
    double mostExpensive = 0;
    for (var element in controller.weekExpenses) {
      double oneDayTotal = 0;
      for (var transaction in element.transactions) {
        oneDayTotal += transaction.value;
      }
      if (oneDayTotal > mostExpensive) {
        mostExpensive = oneDayTotal;
      }
    }
    return mostExpensive;
  }

  Widget _getTitleHeader() {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          _isCollapsed = !_isCollapsed;
        });
      },
      onTap: () {
        setState(() {
          _seeingDate = !_seeingDate;
        });
      },
      onLongPress: (() {
        setState(() {
          _selectedDate = DateTime.now();
        });
      }),
      child: Text(
        _seeingDate
            ? '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'
            : 'Gasto Semanal',
        style: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 21,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionOverviewController>(
        builder: (context, value, child) {
      double mostExpensive = _calcMostExpensiveTransaction(value);

      return GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity == 0) {
              return;
            }
            if (details.primaryVelocity! < 0) {
              setState(() {
                _selectedDate = _selectedDate.add(Duration(days: 7));
              });
            } else {
              setState(() {
                _selectedDate = _selectedDate.subtract(Duration(days: 7));
              });
            }
            Provider.of<TransactionOverviewController>(context, listen: false)
                .reloadWeekExpenses();
            Provider.of<TransactionOverviewController>(context, listen: false)
                .getOneWeekTransactions(_selectedDate);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade900,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: _isCollapsed
                ? Center(
                    child: _getTitleHeader(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _getTitleHeader(),
                      const SizedBox(height: 10),
                      value.weekExpenses.isEmpty
                          ? Text(
                              'Nenhum gasto registrado',
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ...value.weekExpenses.map((e) {
                                  double amountSpent = 0;
                                  e.transactions.forEach((value) {
                                    amountSpent += value.value;
                                  });
                                  return _BarWidget(
                                    mostExpensive: mostExpensive,
                                    label: e.weekDay.substring(0, 3),
                                    amountSpent: amountSpent,
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  );
                                }).toList()
                              ],
                            )
                    ],
                  ),
          ));
    });
  }
}

class _BarWidget extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;
  final double width;
  final double _maxHeight = 150;

  const _BarWidget(
      {Key? key,
      required this.label,
      required this.amountSpent,
      required this.mostExpensive,
      required this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final barHeight =
        amountSpent / (mostExpensive == 0 ? 1 : mostExpensive) * _maxHeight;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'R\$ ${amountSpent.toStringAsFixed(2)}',
          style: GoogleFonts.nunito(
              fontWeight: FontWeight.w300, color: Colors.white),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          width: width,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 250, 250, 250),
            borderRadius: BorderRadius.circular(8),
          ),
          height: _maxHeight,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: barHeight,
              width: width,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.nunito(
              fontWeight: FontWeight.w300, fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}

class _ChangeWeekButton extends StatelessWidget {
  final IconData icon;

  const _ChangeWeekButton({Key? key, required this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.5),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(icon, size: 18, color: Colors.green.shade800),
    );
  }
}
