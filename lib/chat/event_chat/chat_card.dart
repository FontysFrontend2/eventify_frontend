import 'package:flutter/material.dart';
import 'chat_view.dart';

class ChatCard extends StatelessWidget {
  final event;

  const ChatCard(this.event, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Color.fromARGB(255, 152, 190, 154),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: InkWell(
          splashColor: Colors.green,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChatView(
                  id: event.id, hostId: event.hostID, room: event.title);
            }));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: SizedBox(
                height: 110,
                width: double.infinity,
                child: Column(
                  children: [
                    Text(event.title.toString()),
                    const SizedBox(height: 10),
                    Text(
                      event.description.toString(),
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
