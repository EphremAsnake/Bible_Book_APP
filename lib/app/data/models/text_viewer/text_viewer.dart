import 'package:flutter/material.dart';

typedef OnErrorCallback = void Function(String error);

class TextViewer {
  final String? assetPath;

  final String? filePath;

  final String? textContent;

  final TextStyle textStyle;

  final TextStyle highLightTextStyle;

  final TextStyle focusTextStyle;

  final Color highLightColor;

  final Color focusColor;

  final bool ignoreCase;

  final OnErrorCallback? onErrorCallback;

  const TextViewer._({
    this.assetPath,
    this.filePath,
    this.textContent,
    this.onErrorCallback,
    required this.textStyle,
    required this.focusTextStyle,
    required this.highLightTextStyle,
    required this.highLightColor,
    required this.focusColor,
    required this.ignoreCase,
  });

  factory TextViewer.asset(
    String assetPath, {
    TextStyle textStyle = const TextStyle(),
    TextStyle? highLightTextStyle,
    TextStyle? focusTextStyle,
    Color highLightColor = Colors.yellow,
    Color focusColor = Colors.amber,
    bool ignoreCase = true,
    OnErrorCallback? onErrorCallback,
  }) {
    return TextViewer._(
        assetPath: assetPath,
        textStyle: textStyle,
        highLightTextStyle: highLightTextStyle ??
            textStyle.copyWith(background: Paint()..color = highLightColor),
        focusTextStyle: focusTextStyle ??
            textStyle.copyWith(background: Paint()..color = focusColor),
        highLightColor: highLightColor,
        focusColor: focusColor,
        ignoreCase: ignoreCase,
        onErrorCallback: onErrorCallback);
  }

  factory TextViewer.file(
    String filePath, {
    TextStyle textStyle = const TextStyle(),
    TextStyle? highLightTextStyle,
    TextStyle? focusTextStyle,
    Color highLightColor = Colors.yellow,
    Color focusColor = Colors.amber,
    bool ignoreCase = true,
    OnErrorCallback? onErrorCallback,
  }) {
    return TextViewer._(
      filePath: filePath,
      textStyle: textStyle,
      highLightTextStyle: highLightTextStyle ??
          textStyle.copyWith(background: Paint()..color = highLightColor),
      focusTextStyle: focusTextStyle ??
          textStyle.copyWith(background: Paint()..color = focusColor),
      highLightColor: highLightColor,
      focusColor: focusColor,
      ignoreCase: ignoreCase,
      onErrorCallback: onErrorCallback,
    );
  }

  factory TextViewer.textValue(
    String textContent, {
    TextStyle textStyle = const TextStyle(),
    TextStyle? highLightTextStyle,
    TextStyle? focusTextStyle,
    Color highLightColor = Colors.yellow,
    Color focusColor = Colors.amber,
    bool ignoreCase = true,
    OnErrorCallback? onErrorCallback,
  }) {
    return TextViewer._(
        textContent: textContent,
        textStyle: textStyle,
        highLightTextStyle: highLightTextStyle ??
            textStyle.copyWith(background: Paint()..color = highLightColor),
        focusTextStyle: focusTextStyle ??
            textStyle.copyWith(background: Paint()..color = focusColor),
        highLightColor: highLightColor,
        focusColor: focusColor,
        ignoreCase: ignoreCase,
        onErrorCallback: onErrorCallback);
  }
}
