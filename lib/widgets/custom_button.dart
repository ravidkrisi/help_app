import 'package:flutter/material.dart';

class WelcomButton extends StatelessWidget {
  final String _buttonText;
  final Widget? onTap;
  final Color? _color;
  final Color? _textColor;

  const WelcomButton(
      this._buttonText, this.onTap, this._color, this._textColor);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (e) => onTap!));
      },
      child: Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
              color: _color,
              borderRadius:
                  const BorderRadius.only(topLeft: Radius.circular(50))),
          child: Text(
            _buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: _textColor,
            ),
          )),
    );
  }
}