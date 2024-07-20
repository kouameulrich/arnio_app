import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/arvnio.png'),
                  ),
                ),
                width: 90,
                height: 99,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                color: const Color(0xFF000000),
                width: 1,
                height: 80,
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'A.\nF  O  F  A  N  A\n',
                    style: TextStyle(
                      fontFamily: 'Inria Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF000000),
                    ),
                  ),
                  Text(
                    '15.000 FCFA',
                    style: TextStyle(
                      fontFamily: 'Inria Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF000000),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo_blanc_copie_2.png'),
                    ),
                  ),
                  width: 50,
                  height: 79,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Ajoutez de l'argent",
                style: TextStyle(
                  fontFamily: 'Inria Sans',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Color(0xFF000000),
                ),
              ),
              const SizedBox(width: 4.5),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_circle_outline_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
