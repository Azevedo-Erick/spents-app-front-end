import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spents_app/models/type_enum.dart';

import '../models/transaction_model.dart';

class TransactionWidget extends StatefulWidget {
  final Transaction transaction;
  final Function selectTransaction;
  final Transaction? selectedTransaction;
  const TransactionWidget(
      {Key? key,
      required this.transaction,
      required this.selectTransaction,
      required this.selectedTransaction})
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

  void _selectTransaction() {
    setState(() {
      widget.selectTransaction(widget.transaction);
      _togglePrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
          color: Colors.blueGrey.shade900),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                widget.transaction.title,
                style: GoogleFonts.roboto(
                  color: Colors.white,
                ),
              ),
              Text(
                widget.transaction.category.name,
                style: GoogleFonts.comfortaa(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 400),
              firstCurve: Curves.easeInBack,
              secondCurve: Curves.easeInBack,
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
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade800,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        '${widget.transaction.type == Type.INCOME ? "+" : "-"} R\$ ${widget.transaction.value.toStringAsFixed(2)}',
                        style: GoogleFonts.robotoMono(
                            fontSize: 16, color: Colors.white),
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
                      onPressed: () => _selectTransaction(),
                      child: Icon(Icons.search_rounded)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
