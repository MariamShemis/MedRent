import 'package:flutter/material.dart';

class ProfileMenuItem {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final bool isLanguage;
  final String? textLanguage;

  ProfileMenuItem({
    required this.icon,
    required this.text,
    required this.onPressed,
    this.isLanguage = false,
    this.textLanguage,
  });
}
