import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key, required this.name, required this.color})
      : super(key: key);
  final String name;
  final String color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color:
            Color(int.parse("0XFF${color.replaceAll('#', '').toUpperCase()}")),
        borderRadius: BorderRadius.circular(50),
      ),
      alignment: Alignment.center,
      child: Text(
        overflow: TextOverflow.ellipsis,
        name,
        style: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
      ),
    );
  }
}
