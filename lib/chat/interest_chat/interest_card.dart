import 'package:eventify_frontend/chat/interest_chat/interest_view.dart';
import 'package:flutter/material.dart';

class InterestCard extends StatelessWidget {
  final interest;

  const InterestCard(this.interest, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: const Color.fromARGB(255, 152, 190, 154),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: InkWell(
          splashColor: Colors.green,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return InterestChatView(id: int.parse(interest), room: interest);
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
                    Text(interest.toString()),
                    const SizedBox(height: 10),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
