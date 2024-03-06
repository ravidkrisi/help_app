import 'package:flutter/material.dart';
import 'package:help_app/view_model/welcome_page_view_model.dart';
import 'package:provider/provider.dart';

class WelcomButton extends StatelessWidget {
  final String _buttonText;
  final Color? _color;
  final Color? _textColor;

  const WelcomButton(this._buttonText, this._color, this._textColor);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WelcomePageViewModel>(context);
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (e) => onTap!));
        if (_buttonText == "sign in") {
          viewModel.navigateToSignIn(context);
        } else if (_buttonText == "sign up") {
          viewModel.navigateToSignUp(context);
        }
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
