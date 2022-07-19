import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({Key? key}) : super(key: key);

  @override
  _BarChartWidgetState createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  List<Map<String, Set>> expenses = [
    {
      'Monday': {
        {
          'name': 'Cafe',
          'value': 72,
        },
        {
          'name': 'Lanche',
          'value': 20,
        },
        {
          'name': 'Almoço',
          'value': 30,
        },
      },
    },
    {
      'Tuesday': {
        {
          'name': 'Cafe',
          'value': 10,
        },
        {
          'name': 'Lanche',
          'value': 35,
        },
        {
          'name': 'Almoço',
          'value': 30,
        },
      },
    },
    {
      'Wednesday': {
        {
          'name': 'Cafe',
          'value': 10,
        },
        {
          'name': 'Lanche',
          'value': 20,
        },
        {
          'name': 'Almoço',
          'value': 30,
        },
      },
    },
    {
      'Thursday': {
        {
          'name': 'Cafe',
          'value': 10,
        },
        {
          'name': 'Lanche',
          'value': 20,
        },
        {
          'name': 'Almoço',
          'value': 40,
        },
      },
    },
    {
      'Friday': {
        {
          'name': 'Cafe',
          'value': 10,
        },
        {
          'name': 'Lanche',
          'value': 110,
        },
        {
          'name': 'Almoço',
          'value': 30,
        },
      },
    },
    {
      'Saturday': {
        {
          'name': 'Cafe',
          'value': 70,
        },
        {
          'name': 'Lanche',
          'value': 20,
        },
        {
          'name': 'Almoço',
          'value': 30,
        },
      },
    },
    {
      'Sunday': {
        {
          'name': 'Cafe',
          'value': 10,
        },
        {
          'name': 'Lanche',
          'value': 20,
        },
        {
          'name': 'Almoço',
          'value': 30,
        },
      },
    },
  ];
  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    expenses.forEach((day) {
      day.forEach((key, value) {
        double total = 0;
        for (var expense in value) {
          total += expense['value'];
        }
        if (total > mostExpensive) {
          mostExpensive = total;
        }
      });
    });
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          Text(
            'Gasto Semanal',
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...expenses.map((e) {
                double amountSpent = 0;
                e.forEach((key, value) {
                  value.forEach((expense) {
                    amountSpent += expense['value'];
                  });
                });
                return _BarWidget(
                    mostExpensive: mostExpensive,
                    label: e.keys.first.substring(0, 3),
                    amountSpent: amountSpent);
              }).toList()
            ],
          )
        ],
      ),
    );
  }
}

class _BarWidget extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;

  final double _maxHeight = 150;

  const _BarWidget(
      {Key? key,
      required this.label,
      required this.amountSpent,
      required this.mostExpensive})
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
          width: 16,
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
