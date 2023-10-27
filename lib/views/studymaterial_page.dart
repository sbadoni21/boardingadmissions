import 'package:boardingadmissions/components/appbar.dart';
import 'package:boardingadmissions/components/notes_cards.dart';
import 'package:boardingadmissions/components/notes_heading.dart';
import 'package:boardingadmissions/components/space_between.dart';
import 'package:flutter/material.dart';

class StudyMaterial extends StatelessWidget {
  const StudyMaterial({super.key, Key? keys});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
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
                  const NotesCards(itemCount: 10),
                  const SpaceBetween(
                    verticalPadding:
                        12.0, // Adjust the vertical padding as needed
                    dividerColor:
                        Colors.blueAccent, // Set the desired divider color
                  ),
                  SectionHeader(
                    title: "Study Material",
                    onSeeAllPressed: () {},
                  ),
                  const NotesCards(itemCount: 10),
                  const SpaceBetween(
                    verticalPadding:
                        12.0, // Adjust the vertical padding as needed
                    dividerColor:
                        Colors.blueAccent, // Set the desired divider color
                  ),
                  SectionHeader(
                    title: "Assessments",
                    onSeeAllPressed: () {},
                  ),
                  const NotesCards(itemCount: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
