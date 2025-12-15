import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/custom_widgets/app_rich_text.dart';

enum TextType { simple, rich }

class AppTextFactory {
  // For simple text
  static Widget build({
    required TextType type,
    String? text,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    List<TextSpanItem>? spans,
  }) {
    switch (type) {
      case TextType.simple:
        return AppTexts(
          text: text!,
          style: style,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );

      case TextType.rich:
        return AppRichText(
          spans: spans!,
          defaultStyle: style,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );
    }
  }
}
