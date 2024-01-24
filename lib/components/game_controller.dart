import 'package:flutter/material.dart';

import 'action_button.dart';

const Color _kPrimaryColor = Color(0xFFC2E0E3);

class GameController extends StatelessWidget {
  final String aboveLabel;
  final void Function() onAbovePressed;

  final String correctLabel;
  final void Function() onCorrectPressed;

  final String belowLabel;
  final void Function() onBelowPressed;

  const GameController({
    super.key,
    required this.aboveLabel,
    required this.onAbovePressed,
    required this.correctLabel,
    required this.onCorrectPressed,
    required this.belowLabel,
    required this.onBelowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: double.infinity,
          child: ActionButton(
            label: aboveLabel,
            onPressed: onAbovePressed,
          ),
        ),
        SizedBox(
            width: double.infinity,
            child: ActionButton(
              label: correctLabel,
              onPressed: onCorrectPressed,
              backgroundColor: _kPrimaryColor,
              foregroundColor: Colors.black,
              isBold: true,
            )),
        SizedBox(
          width: double.infinity,
          child: ActionButton(
            label: belowLabel,
            onPressed: onBelowPressed,
          ),
        ),
      ],
    );
  }
}
