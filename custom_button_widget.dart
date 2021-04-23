import 'package:flutter/material.dart';
import 'package:qrcode/app/style/app_style.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final CustomButtonStyle style;
  final Function onTap;
  final String adText;
  CustomButtonWidget({this.style = CustomButtonStyle.accent, @required this.text, @required this.onTap,
   this.adText = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      height: 50,
      decoration: BoxDecoration(
        color: style == CustomButtonStyle.accent ? accentColor : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [ style == CustomButtonStyle.accent ? defaultBoxShadowAccent : defaultBoxShadow ] 
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          splashColor: splashColor,
          child: Stack(
            children: [
              Center(
                child: Text("$text",
                  style: TextStyle(
                    color: style == CustomButtonStyle.accent ? Colors.white : accentColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              Positioned(
                right: 12,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text("$adText",
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.w700
                    )
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum CustomButtonStyle {accent, normal}
