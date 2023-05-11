import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String text;
  final String title;

  TextFieldWidget(
    this.title,
    this.text,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          maxLines: 1,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 16.0,
          ),
        )
      ],
    );
  }
}
