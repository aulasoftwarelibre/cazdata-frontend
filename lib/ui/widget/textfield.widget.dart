import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({this.header, this.content});

  final String header;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AutoSizeText(
            header,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
            minFontSize: 10,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          AutoSizeText(
            content,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
