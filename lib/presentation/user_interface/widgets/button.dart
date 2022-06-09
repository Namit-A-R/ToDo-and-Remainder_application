import 'package:flutter/material.dart';
import 'package:remainder_application/presentation/resources/color_manager.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function() onTap;

  const MyButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorManager.primaryLight,
        ),
      ),
    );
  }
}

class TextBtn extends StatelessWidget {
  final Function() onPressed;
  final String label;
  final IconData? icon;
  final double? elevation;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? primary;
  final Color? onSurface;
  final Color? textColor;
  final OutlinedBorder? shape;
  final double padding;

  const TextBtn(
      {Key? key,
        required this.padding,
        required this.onPressed,
        required this.label,
        this.icon,
        this.elevation,
        this.backgroundColor,
        this.shadowColor,
        this.primary,
        this.onSurface,
        this.shape,
        this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return icon == null ? _textButtonWithoutIcon() : _textButtonWithIcon();
  }

  _textButtonWithoutIcon() => TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
      animationDuration: const Duration(
        milliseconds: 500,
      ),

      // elevation: elevation ?? 0,
      // backgroundColor: backgroundColor ?? Colors.blue,
      // shadowColor: shadowColor ?? Colors.red,
      // primary: primary ?? Colors.deepPurple,
      // onSurface: onSurface ?? Colors.orange,
    ),
    child: Padding(
      padding: EdgeInsets.all(padding),
      child: Text(
        label,
        style: TextStyle(
          color: textColor ?? Colors.white,
        ),
      ),
    ),
  );

  _textButtonWithIcon() => TextButton.icon(
    onPressed: onPressed,
    icon: Icon(icon),
    style: TextButton.styleFrom(
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
      animationDuration: const Duration(
        milliseconds: 500,
      ),
      // elevation: elevation ?? 0,
      // backgroundColor: backgroundColor ?? Colors.blue,
      // shadowColor: shadowColor ?? Colors.red,
      // primary: primary ?? Colors.deepPurple,
      // onSurface: onSurface ?? Colors.orange,
    ),
    label: Text(
      label,
      style: TextStyle(
        color: textColor ?? Colors.white,
      ),
    ),
  );
}

class ElevatedBtn extends StatelessWidget {
  final Function() onPressed;
  final String label;
  final IconData? icon;
  final double? elevation;
  final Color? onPrimary;
  final Color? shadowColor;
  final Color? primary;
  final Color? onSurface;
  final Color? textColor;
  final OutlinedBorder? shape;
  final EdgeInsetsGeometry? padding;

  const ElevatedBtn(
      {Key? key,
        required this.onPressed,
        required this.label,
        this.icon,
        this.elevation,
        this.shadowColor,
        this.primary,
        this.onSurface,
        this.textColor,
        this.shape,
        this.onPrimary, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return icon == null?_elevatedButtonWithoutIcon():_elevatedButtonWithIcon();
  }
  _elevatedButtonWithoutIcon() =>
      ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
          animationDuration: const Duration(
            milliseconds: 500,
          ),
          // elevation: elevation ?? 0,
          // onPrimary: onPrimary ?? Colors.blue,
          // shadowColor: shadowColor ?? Colors.red,
          // primary: primary ?? Colors.deepPurple,
          // onSurface: onSurface ?? Colors.orange,
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(20),
          child: Text(
            label,
            // style: TextStyle(
            //   color: textColor ?? Colors.white,
            // ),
          ),
        ),
      );

  _elevatedButtonWithIcon() =>
      ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
          animationDuration: const Duration(
            milliseconds: 500,
          ),
          // elevation: elevation ?? 0,
          // onPrimary: onPrimary ?? Colors.blue,
          // shadowColor: shadowColor ?? Colors.red,
          // primary: primary ?? Colors.deepPurple,
          // onSurface: onSurface ?? Colors.orange,
        ),
        icon: Icon(icon),
        label: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            label,
            // style: TextStyle(
            //   color: textColor ?? Colors.white,
            // ),
          ),
        ),
      );
}
