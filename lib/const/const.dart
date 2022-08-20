import 'package:flutter/material.dart';

var personAppbar = Container(
  height: 50,
  width: 50,
  decoration: const BoxDecoration(
    shape: BoxShape.circle,
  ),
  child: Image.asset(
    'assets/images/profile.png',
    fit: BoxFit.cover,
  ),
);
