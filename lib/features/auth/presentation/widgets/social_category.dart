
import 'package:flutter/material.dart';

class SocialImage extends StatelessWidget {
  final String asset;
  final VoidCallback onTap;

  const SocialImage({super.key, required this.asset, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: 
        ClipOval(child: Image.asset(asset, fit: BoxFit.cover)),
      ),
    );
  }
}
