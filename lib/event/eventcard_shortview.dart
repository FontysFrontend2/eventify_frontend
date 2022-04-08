import 'package:flutter/material.dart';

class EventCardShortView extends StatelessWidget {
  final d;

  EventCardShortView(this.d);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(40),
          onTap: () {},
          child: SizedBox(
            width: double.infinity,
            height: 100,
            child: Column(
              children: [
                Text(d['name'].toString()),
                Text(d['desc'].toString()),
                Text(d['long'].toString()),
                Text(d['lat'].toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
