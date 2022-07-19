import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spents_app/models/type_enum.dart';

import '../models/transaction_model.dart';

class TransactionWidget extends StatefulWidget {
  final Transaction transaction;
  const TransactionWidget({Key? key, required this.transaction})
      : super(key: key);

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  bool _showingPrice = true;

  void _togglePrice() {
    setState(() {
      _showingPrice = !_showingPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
          color: Colors.indigo),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                widget.transaction.title,
                style: GoogleFonts.roboto(),
              ),
              Text(
                widget.transaction.category.name,
                style: GoogleFonts.comfortaa(),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 500),
              crossFadeState: _showingPrice
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _togglePrice,
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        'R\$ ${widget.transaction.value.toStringAsFixed(2)}',
                        style: GoogleFonts.robotoMono(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: widget.transaction.type == Type.INCOME
                                ? Colors.green
                                : Colors.red),
                      ),
                    ),
                  )
                ],
              ),
              secondChild: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: _togglePrice,
                      child: Icon(Icons.cancel_rounded)),
                  TextButton(
                      onPressed: () => {}, child: Icon(Icons.search_rounded)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
