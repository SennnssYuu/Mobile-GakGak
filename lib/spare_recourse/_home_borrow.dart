import 'package:flutter/material.dart';

class BigBorrowWidget extends StatefulWidget {

  final String imageBorrow;

  const BigBorrowWidget({
    super.key,
    required this.imageBorrow,
  });

  @override
  State<BigBorrowWidget> createState() => _BigBorrowWidgetState();
}

class _BigBorrowWidgetState extends State<BigBorrowWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        children: [
          Container(
            width: 475.0,
            height: 250.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                widget.imageBorrow, // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (_isHovered)
            Container(
              width: 475.0,
              height: 250.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white.withOpacity(0.05),
              ),
            ),
        ],
      ),
    );
  }
}
class BorrowWidget extends StatefulWidget {

  final String imageBorrow;

  const BorrowWidget({
    super.key,
    required this.imageBorrow,
  });

  @override
  State<BorrowWidget> createState() => _BorrowWidgetState();
}

class _BorrowWidgetState extends State<BorrowWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        children: [
          Container(
            width: 225.0,
            height: 125.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                widget.imageBorrow, // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (_isHovered)
            Container(
              width: 225.0,
              height: 125.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white.withOpacity(0.10),
              ),
            ),
        ],
      ),
    );
  }
}

class MultiBorrowWidget extends StatefulWidget {

  final String text1; // Big text displayed on the left side
  final String text2; // Medium text displayed on the right upper side
  final String text3; // First lower text on the right side (left of text4)
  final String text4; // Second lower text on the right side (right of text3)
  final Color borderColor; // Color for the border around the widget
  final Color bgColor; // Background color of the widget

  const MultiBorrowWidget({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.borderColor,
    required this.bgColor,
  });

  @override
  State<MultiBorrowWidget> createState() => _MultiBorrowWidgetState();
}

class _MultiBorrowWidgetState extends State<MultiBorrowWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        children: [
          Container(
            width: 225.0,
            height: 125.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: widget.bgColor,
              border: Border.all(color: widget.borderColor, width: 2.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        widget.text1,
                        style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold,color: widget.borderColor),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.text2,
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500,color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.text3, style: TextStyle(fontSize: 14.0,color: Colors.white)),
                            SizedBox(width: 8.0),
                            Text(widget.text4, style: TextStyle(fontSize: 14.0,color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isHovered)
            Container(
              width: 225.0,
              height: 125.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white.withOpacity(0.10),
              ),
            ),
        ],
      ),
    );
  }
}

class ToolWidget extends StatefulWidget {

  final String text;
  final Color borderColor; // Color for the border
  final Color bgColor; // Background color

  const ToolWidget({
    super.key,
    required this.text,
    required this.borderColor,
    required this.bgColor,
  });

  @override
  State<ToolWidget> createState() => _ToolWidgetState();
}

class _ToolWidgetState extends State<ToolWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        children: [
          Container(
            width: 225.0,
            height: 125.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: widget.bgColor,
              border: Border.all(color: widget.borderColor, width: 2.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
          if (_isHovered)
            Container(
              width: 225.0,
              height: 125.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white.withOpacity(0.10),
              ),
            ),
        ],
      ),
    );
  }
}