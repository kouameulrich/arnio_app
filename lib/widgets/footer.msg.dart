import 'package:flutter/material.dart';

class QRResult extends StatelessWidget {
  final IconData? qrIcon;
  final String qrResult;

  const QRResult({super.key, required this.qrIcon, required this.qrResult});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (qrIcon != null)
          Icon(
            qrIcon,
            color: qrIcon == Icons.warning_amber_rounded
                ? Colors.red
                : Colors.green,
            size: 30,
          ),
        const SizedBox(width: 15),
        Text(qrResult),
      ],
    );
  }
}
