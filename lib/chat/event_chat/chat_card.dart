import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final int id;

  const ChatCard(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Color.fromARGB(255, 152, 190, 154),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Container(
            height: 110,
            child: Row(
              children: [
                Column(
                  children: const [
                    Text('Event Title'),
                    SizedBox(height: 10),
                    Text('Event Description'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
