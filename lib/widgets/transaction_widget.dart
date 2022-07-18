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
      padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 18.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.transaction.title,
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  widget.transaction.category.name,
                  style: GoogleFonts.comfortaa(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ]),
          SizedBox(
            width: 120,
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
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      'R\$ ${widget.transaction.value.toString()}',
                      style: GoogleFonts.robotoMono(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: widget.transaction.type == Type.INCOME
                              ? Colors.green
                              : Colors.red),
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
