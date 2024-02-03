import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entidades/mensaje.dart';
import 'package:yes_no_app/presentacion/Providers/chat_provider.dart';
import 'package:yes_no_app/presentacion/widgets/chat/mi_burbuja_chat.dart';
import 'package:yes_no_app/presentacion/widgets/chat/su_burbuja_chat.dart';
import 'package:yes_no_app/presentacion/widgets/shared/caja_de_mesajeria.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRI4iPyewrQaFilcbmjOG3NCmuQmYW7qTQbXVwQRhdI-5AnyTOdnsR7mQ1HUTXHHKJhUrE&usqp=CAU'),
          ),
        ),
        title: const Text('Mi amor'),
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatProvider.chatScrollController,
                itemCount: chatProvider.listaMensaje.length,
                itemBuilder: (context, index) {
                  final message = chatProvider.listaMensaje[index];
                  return (message.fromWho == FromWho.hers)
                      ? HerMessageBubble(
                          message: message,
                        )
                      : MyMessageBubble(
                          message: message,
                        );
                },
              ),
            ),
            // MessageFieldBox(
            // onValue: (value) => chatProvider.enviarMensaje(value),
            //  )
            //ambos son identicos

            MessageFieldBox(onValue: chatProvider.enviarMensaje)
          ],
        ),
      ),
    );
  }
}
