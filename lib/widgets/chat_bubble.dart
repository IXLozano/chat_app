import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String uid;
  final String message;
  final AnimationController animationcontroller;

  const ChatBubble({
    required this.uid,
    required this.message,
    required this.animationcontroller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationcontroller,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationcontroller, curve: Curves.easeOut),
        child: Container(child: uid == '123' ? _sender() : _receiver()),
      ),
    );
  }

  Widget _sender() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 5, left: 50, right: 5),
        decoration: BoxDecoration(
          color: const Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _receiver() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 5, left: 5, right: 50),
        decoration: BoxDecoration(
          color: const Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
