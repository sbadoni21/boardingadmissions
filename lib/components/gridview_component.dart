import 'package:flutter/material.dart';

class ItemGrid extends StatelessWidget {
  final int itemCount; // The total number of items

  ItemGrid({required this.itemCount}); // Constructor to accept itemCount

  @override
  Widget build(BuildContext context) {
    // Number of items in each row
    final itemsInRow = 3;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: itemsInRow,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GridTile(
          child: ItemCard(index + 1),
        );
      },
      itemCount: itemCount,
    );
  }
}

class ItemCard extends StatelessWidget {
  final int itemNumber;

  ItemCard(this.itemNumber);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // Adjust the width of each item
      margin: const EdgeInsets.fromLTRB(12, 9, 12, 9),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)),
        child: Card(
            elevation: 5,
            shadowColor: Colors.black26,
            borderOnForeground: true,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors
                    .transparent, // Set the button's background color to transparent
                // Adjust the padding as needed
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
