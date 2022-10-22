import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function()? press;
   
  const RoundedButton({
    Key? key,
 
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
          primary: Colors.redAccent,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: const TextStyle(
              color: Color.fromARGB(255, 224, 212, 212),
              fontSize: 18,
              fontWeight: FontWeight.w500)),
      child: Text(
        text,
        style: const TextStyle(
          color: Color.fromARGB(255, 233, 217, 217),
        ),
      ),
    );
  }
}
