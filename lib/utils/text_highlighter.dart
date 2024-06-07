import 'package:flutter/material.dart';

class TextHighlighter {
  static Widget highlightText(String text, String searchQuery) {
    final List<TextSpan> spans = [];
    final String lowerCaseText = text.toLowerCase();
    final String lowerCaseSearchQuery = searchQuery.toLowerCase();

    int startIndex = 0;
    while (startIndex < lowerCaseText.length) {
      final int indexOfQuery = lowerCaseText.indexOf(lowerCaseSearchQuery, startIndex);
      if (indexOfQuery == -1) {
        // Không tìm thấy từ khóa nữa
        spans.add(
          TextSpan(
            text: text.substring(startIndex),
          ),
        );
        break;
      } else {
        // Tìm thấy từ khóa, thêm các phần trước từ khóa vào spans
        if (indexOfQuery > startIndex) {
          spans.add(
            TextSpan(
              text: text.substring(startIndex, indexOfQuery),
            ),
          );
        }

        // Tìm thấy từ khóa, tô màu từ khóa
        final int endIndex = indexOfQuery + searchQuery.length;
        spans.add(
          TextSpan(
            text: text.substring(indexOfQuery, endIndex),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        );
        startIndex = endIndex;
      }
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }
}
