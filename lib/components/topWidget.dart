import 'package:flutter/material.dart';

class TopWidget extends StatelessWidget {
  final String subText;
  final String title;
  const TopWidget({required this.subText, required this.title, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff73BA9B),
      child: Column(
        children: [
          PrintandCircle(pawcolor: Color(0xff4F759B),),
          Text(
            style: const TextStyle(
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
            subText,
          ),
          Text(
            style: const TextStyle(
              fontSize: 40,
            ),
            textAlign: TextAlign.center,
            title,
          ),
        ],
      ),
    );
  }
}

class PrintandCircle extends StatelessWidget {
  final Color pawcolor;
  const PrintandCircle({super.key, required this.pawcolor});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Flexible(
          flex: 1,
          child: SizedBox(
            height: 250,
            width: 200,
            child: PawPrint(pawColor: pawcolor,),
          ),
        ),
        const Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, top: 50.0),
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/Pet.png"),
            ),
          ),
        )
      ],
    );
  }
}

class PawPrint extends StatelessWidget {
  final Color pawColor;
  const PawPrint({
    super.key,
    required this.pawColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: pawColor,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(500),
            ),
          ),
        ),
        Positioned(
          top: 150,
          left: 20,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: pawColor, shape: BoxShape.circle),
          ),
        ),
        Positioned(
          top: 110,
          left: 95,
          child: Container(
            width: 50,
            height: 50,
            decoration:  BoxDecoration(
                color: pawColor, shape: BoxShape.circle),
          ),
        ),
        Positioned(
          top: 50,
          left: 140,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: pawColor, shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }
}
