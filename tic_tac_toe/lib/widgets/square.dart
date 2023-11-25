import 'package:flutter/material.dart';

class SquareWidget extends StatefulWidget {
  const SquareWidget({
    super.key,
    required this.backgroundColor,
    required this.assetImage,
    required this.onTap,
  });

  final Color backgroundColor;
  final String assetImage;
  final Function() onTap;

  @override
  State<SquareWidget> createState() => _SquareState();
}

class _SquareState extends State<SquareWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin:
            const EdgeInsets.all(1.0), // Ajusta el valor según tus necesidades
        padding:
            const EdgeInsets.all(18.0), // Ajusta el valor según tus necesidades
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        child: Image(
          image: AssetImage(widget.assetImage),
        ),
      ),
    );
  }
}
