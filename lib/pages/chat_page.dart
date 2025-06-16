import 'dart:io';

import 'package:chat/widgets/chat_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  @override
  void dispose() {
    // TODO : socket off

    for (ChatBubble message in _messages) message.animationcontroller.dispose();
    super.dispose();
  }

  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  var _isUserTyping = false;
  final _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Column(
          children: [
            CircleAvatar(
              maxRadius: 14,
              child: Text('Li', style: TextStyle(fontSize: 12)),
            ),
            SizedBox(height: 3),
            Text(
              'Liliana',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: _messages.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              ),
            ),
            const Divider(height: 1),

            // TODO : Text Box
            _inputChat(),
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (text) {
                  //TODO : validation
                  setState(
                    () => text.trim().isNotEmpty ? _isUserTyping = true : _isUserTyping = false,
                  );
                },
                decoration: const InputDecoration.collapsed(hintText: 'Type message'),
                focusNode: _focusNode,
              ),
            ),
            //* Send Button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
                  ? CupertinoButton(
                      onPressed: _isUserTyping
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                      child: const Text('Send'),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: _isUserTyping
                            ? () => _handleSubmit(_textController.text.trim())
                            : null,
                        icon: const Icon(Icons.send),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmit(String message) {
    if (message.isEmpty) return;
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatBubble(
      uid: '123',
      message: message,
      animationcontroller: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      ),
    );
    _messages.insert(0, newMessage);
    newMessage.animationcontroller.forward();
    setState(() => _isUserTyping = false);
  }
}
