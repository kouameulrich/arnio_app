import 'package:flutter/material.dart';

class CustomInfoWindow extends StatelessWidget {
  final String title;
  final String chargerType;
  final String power;
  final String connectorType;
  final String price;
  final String status;

  const CustomInfoWindow({super.key, 
    required this.title,
    required this.chargerType,
    required this.power,
    required this.connectorType,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(chargerType),
          const SizedBox(height: 4),
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(text: '22 KW ', style: TextStyle(color: Colors.red)),
                TextSpan(text: 'et puissance'),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(connectorType),
          const SizedBox(height: 4),
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(text: '100 F ', style: TextStyle(color: Colors.red)),
                TextSpan(text: '/ Min'),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: 'Statut: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'Libre', style: TextStyle(color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
