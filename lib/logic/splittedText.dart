import 'dart:ui';
import 'package:flutter/cupertino.dart';

abstract class SplittedText {
  List<String> getSplittedText(Size pageSize, TextStyle textStyle, String text);
}

class SplittedTextImpl extends SplittedText {
  @override
  List<String> getSplittedText(
      Size pageSize, TextStyle textStyle, String text) {
    final List<String> _pageTexts = [];
    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: pageSize.width,
    );

    List<LineMetrics> lines = textPainter.computeLineMetrics();
    double currentPageBottom = pageSize.height;
    int currentPageStartIndex = 0;
    int currentPageEndIndex = 0;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      final left = line.left;
      final top = line.baseline - line.ascent;
      final bottom = line.baseline + line.descent;

      if (currentPageBottom < bottom) {
        currentPageEndIndex =
            textPainter.getPositionForOffset(Offset(left, top)).offset;
        final pageText =
            text.substring(currentPageStartIndex, currentPageEndIndex) ?? "";
        _pageTexts.add(pageText);

        currentPageStartIndex = currentPageEndIndex;
        currentPageBottom = top + pageSize.height;
      }
    }

    final lastPageText = text.substring(currentPageStartIndex) ?? "";
    _pageTexts.add(lastPageText);
    return _pageTexts;
  }
}
