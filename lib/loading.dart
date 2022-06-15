import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        AutoSizeText(
          "Loading...",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
          maxLines: 12,
        )
      ],
    );
  }
}
