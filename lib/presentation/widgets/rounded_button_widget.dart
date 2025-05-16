import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color textColor;
  final Color? borderColor;
  final String? imagePath;
  final double buttonTextSize;
  final double? height;
  final double? width; 
  final EdgeInsetsGeometry? padding; 
  final VoidCallback? onPressed;
  final ShapeBorder shape;

  const RoundedButtonWidget({
    Key? key,
    this.buttonText,
    this.buttonColor,
    this.textColor = Colors.white,
    this.onPressed,
    this.imagePath,
    this.borderColor,
    this.shape = const StadiumBorder(),
    this.buttonTextSize = 14.0,
    this.height,
    this.width, 
    this.padding, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        width: width,
        height: height,
        child: MaterialButton(
          key: key,
          color: buttonColor,
          shape: borderColor != null
              ? StadiumBorder(side: BorderSide(color: borderColor!))
              : shape,
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (imagePath != null)
                Image.asset(
                  imagePath!,
                  height: 15.0,
                ),
              if (imagePath != null) SizedBox(width: 5.0),
              Text(
                buttonText ?? '',
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: buttonTextSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
