import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthRichText extends StatelessWidget {
  final String title;
  final String link;
  final VoidCallback onTap;

  const AuthRichText({
    required this.title,
    required this.link,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: Theme.of(context).textTheme.bodyLarge,
        children: [
          TextSpan(
            text: link,
            style: const  TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap
          )
        ]
      )
    );
  }
}