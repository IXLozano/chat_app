import 'package:flutter/material.dart';

class Lables extends StatelessWidget {
  final String route;
  final String title;
  final String subtitle;

  const Lables({
    required this.route,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            child: Text(
              subtitle,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, route);
            },
          ),
          const SizedBox(height: 50),
          const Text(
            'Terms & Conditions',
            style: TextStyle(
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }
}
