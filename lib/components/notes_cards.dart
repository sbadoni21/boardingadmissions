import 'package:flutter/material.dart';

class NotesCards extends StatelessWidget {
  final int itemCount;

  NotesCards({required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: SizedBox(
        height: 153, // Set the desired height for the horizontal list
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: 160, // Set the width of each item
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return NoteCard();
          },
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // Adjust the width of each item
      margin: EdgeInsets.symmetric(horizontal: 10), // Add spacing
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
        child: Card(
          elevation: 5,
          shadowColor: Colors.black26,
          borderOnForeground: true,
          child: Column(
            children: [
              Image.asset('photos/image8.png'),
              Text(
                'Maths',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    overflow: TextOverflow.fade,
                    fontSize: 17,
                    fontWeight: FontWeight.w800),
              ),
              Text("extra data"),
            ],
          ),
        ),
      ),
    );
  }
}
