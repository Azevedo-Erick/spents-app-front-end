import 'package:flutter/material.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({Key? key}) : super(key: key);

  @override
  _BarChartWidgetState createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
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
      children: [
        const Text(
          'R\$ {amountSpent.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          height: barHeight,
          width: 18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ],
    );
  }
}
