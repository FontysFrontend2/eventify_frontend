import 'package:flutter/material.dart';

class EventCardShortView extends StatelessWidget {
  final d;
  final VoidCallback cb;

  const EventCardShortView(this.d, this.cb);

  @override
  Widget build(BuildContext context) {
    //bool locationBased = d.locationBased as bool;
    //bool limitedPeople = d.maxPeople != 0;
    return Center(
      child: Card(
        color: Colors.pinkAccent,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(40),
          onTap: cb,
          child: SizedBox(
            width: double.infinity,
            height: 120,
            child: Column(
              children: [
                //Event title
                Text(
                  d.title.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //Event Description
                Text(
                  d.description.toString(),
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                //Event time
                Text(
                  d.startEvent.split('T').toString(),
                ),
                //Event participant count and max participants
                /*(limitedPeople)
                    ? (Text(d['members'].length.toString() +
                        '/' +
                        d['maxPeople'].toString()))
                    : (Container())*/
                /*
                //Small map to show location in small scale.
                (locationBased)
                    ? (SizedBox(
                        height: 80,
                        child: EventLocation(d['latitude'], d['longitude'])))
                    : (Container()),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
