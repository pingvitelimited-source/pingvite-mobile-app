import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppRichText extends StatelessWidget {
  final List<TextSpanItem> spans;
  final TextStyle? defaultStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppRichText({
    required this.spans,
    this.defaultStyle,
    this.textAlign,
    this.maxLines,
    this.overflow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: spans.map((span) {
          return TextSpan(
            text: span.text,
            style: span.style,
            recognizer: span.onTap != null
                ? (TapGestureRecognizer()..onTap = span.onTap)
                : null,
          );
        }).toList(),
      ),
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
    );
  }
}

class TextSpanItem {
  final String text;
  final TextStyle? style;
  final VoidCallback? onTap;

  const TextSpanItem({required this.text, this.style, this.onTap});
}
