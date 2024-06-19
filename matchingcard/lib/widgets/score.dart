import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget scoreBoard(String title, String info) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(26.0),
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius : BorderRadius.circular(12.4),
      ),
      child: Column(children: [
        Text(
          title,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6.0),
        Text(info,
            style: const TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold)),
      ]),
    ),
  );
}
