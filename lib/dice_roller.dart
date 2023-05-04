import 'package:flutter/material.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  var activeDiceSide = 'assets/images/dice-1.png';

  void rollDice() {
    activeDiceSide = 'assets/images/dice-1.png';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          activeDiceSide,
          width: 200,
        ),
        const SizedBox(
          height: 8,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              rollDice();
            });
          },
          style: TextButton.styleFrom(
            //padding: const EdgeInsets.all(8.0),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
          child: const Text('Roll Dice'),
        ),
      ],
    );
  }
}
