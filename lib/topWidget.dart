import 'package:flutter/material.dart';

class TopWidget extends StatelessWidget {
  final String subText;
  final String title;
  const TopWidget({required this.subText, required this.title, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 95, 196, 98),
      child: Column(
        children: [
          const PrintandCircle(),
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
  const PrintandCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Flexible(
          flex: 1,
          child: SizedBox(
            height: 250,
            width: 200,
            child: PawPrint(),
          ),
        ),
        Flexible(
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
  const PawPrint({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
            color: Colors.brown,
            borderRadius: BorderRadius.only(
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
            decoration: const BoxDecoration(
                color: Colors.brown, shape: BoxShape.circle),
          ),
        ),
        Positioned(
          top: 110,
          left: 95,
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.brown, shape: BoxShape.circle),
          ),
        ),
        Positioned(
          top: 50,
          left: 140,
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.brown, shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }
}
