import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class ButtonNavigator extends StatelessWidget {
  final button;
  ButtonNavigator(this.button);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 330,
      child: Row(
        children: [
          Image.asset(button.ImgUrl),
          SizedBox(
            width: 7,
          ),
          Text(
            button.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          )
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Color.fromARGB(255, 36, 153, 155),
      ),
    );
  }
}
