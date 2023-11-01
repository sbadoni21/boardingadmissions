import 'package:boardingadmissions/views/pdfView_page.dart';
import 'package:flutter/material.dart';

class TopSchoolCards extends StatelessWidget {
  final int itemCount;

  const TopSchoolCards({super.key, required this.itemCount});

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
            return const NoteCard();
          },
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // Adjust the width of each item
      margin: const EdgeInsets.symmetric(horizontal: 10), // Add spacing
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)),
        child: Card(
            elevation: 5,
            shadowColor: Colors.black26,
            borderOnForeground: true,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors
                    .transparent, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Adjust the border radius as needed
                ),
              ),
              onPressed: () {},
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) =>  PDFViewerPage()));
              // },
              child: Container(
                constraints: BoxConstraints.tight(Size.infinite),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.white30,
                      Colors.white70
                    ], // Define your gradient colors
                    begin: Alignment
                        .bottomCenter, // Adjust the start point as needed
                    end: Alignment.topCenter, // Adjust the end point as needed
                  ),
                  borderRadius: BorderRadius.circular(
                      10), // Match the button's border radius
                ),
                child: Column(
                  children: [
                    Image.asset('assets/photos/image8.png'),
                    const Text(
                      'Maths',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        overflow: TextOverflow.fade,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Text("extra data"),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
