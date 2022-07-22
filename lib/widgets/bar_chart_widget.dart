import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/week_expenses_model.dart';

class BarChartWidget extends StatefulWidget {
  List<WeekExpenses> weekExpenses;

  BarChartWidget({Key? key, required this.weekExpenses}) : super(key: key);

  @override
  _BarChartWidgetState createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  bool _isCollapsed = false;
  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    for (var element in widget.weekExpenses) {
      double oneDayTotal = 0;
      for (var transaction in element.transactions) {
        oneDayTotal += transaction.value;
      }
      if (oneDayTotal > mostExpensive) {
        mostExpensive = oneDayTotal;
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: _isCollapsed
          ? Center(
              child: GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    _isCollapsed = !_isCollapsed;
                  });
                },
                child: Text(
                  'Gasto Semanal',
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            )
          : Stack(children: [
              Positioned(
                top: MediaQuery.of(context).size.height * 0.17,
                width: MediaQuery.of(context).size.width - 48,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _ChangeWeekButton(icon: Icons.arrow_back),
                    _ChangeWeekButton(icon: Icons.arrow_forward),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onDoubleTap: () {
                      setState(() {
                        _isCollapsed = !_isCollapsed;
                      });
                    },
                    child: Text(
                      'Gasto Semanal',
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...widget.weekExpenses.map((e) {
                        double amountSpent = 0;
                        e.transactions.forEach((value) {
                          amountSpent += value.value;
                        });
                        return _BarWidget(
                          mostExpensive: mostExpensive,
                          label: e.weekDay.substring(0, 3),
                          amountSpent: amountSpent,
                          width: MediaQuery.of(context).size.width * 0.02,
                        );
                      }).toList()
                    ],
                  )
                ],
              )
            ]),
    );
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
    final barHeight = amountSpent / mostExpensive * _maxHeight;
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
          height: barHeight,
          width: width,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8),
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
