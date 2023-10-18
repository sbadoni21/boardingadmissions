import 'package:boardingadmissions/components/appbar.dart';
import 'package:boardingadmissions/components/notes_cards.dart';
import 'package:boardingadmissions/components/notes_heading.dart';
import 'package:boardingadmissions/components/space_between.dart';
import 'package:flutter/material.dart';

class StudyMaterial extends StatelessWidget {
  const StudyMaterial({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SectionHeader(
                  title: "Class Notes",
                  onSeeAllPressed: () {},
                ),
                NotesCards(itemCount: 10),
                SpaceBetween(
                  verticalPadding:
                      12.0, // Adjust the vertical padding as needed
                  dividerColor:
                      Colors.blueAccent, // Set the desired divider color
                ),
                SectionHeader(
                  title: "Study Material",
                  onSeeAllPressed: () {},
                ),
                NotesCards(itemCount: 10),
                SpaceBetween(
                  verticalPadding:
                      12.0, // Adjust the vertical padding as needed
                  dividerColor:
                      Colors.blueAccent, // Set the desired divider color
                ),
                SectionHeader(
                  title: "Assessments",
                  onSeeAllPressed: () {},
                ),
                NotesCards(itemCount: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
