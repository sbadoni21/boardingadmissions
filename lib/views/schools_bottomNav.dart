import 'package:boardingadmissions/components/topschool_component_schools.dart';
import 'package:boardingadmissions/components/appbar.dart';
import 'package:boardingadmissions/components/gridview_component.dart';
import 'package:boardingadmissions/components/notes_cards.dart';
import 'package:boardingadmissions/components/notes_heading.dart';
import 'package:boardingadmissions/components/search_bar.dart';
import 'package:boardingadmissions/components/space_between.dart';
import 'package:boardingadmissions/views/topSchoolsdetail_page.dart';
import 'package:flutter/material.dart';

class SchoolsBottomNavBar extends StatelessWidget {
  const SchoolsBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWithButton(hintText: "Search..."),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SectionHeader(
                      title: "Top Schools",
                      onSeeAllPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return DescriptionPage(); // Instantiate and return DescriptionPage
                          }),
                        );
                      }),
                  const TopSchoolCards(itemCount: 10),
                  const SpaceBetween(
                    verticalPadding: 12.0,
                    dividerColor: Colors.blueAccent,
                  ),
                  SectionHeader(
                    title: "Top Courses",
                    onSeeAllPressed: () {},
                  ),
                  const TopSchoolCards(itemCount: 10),
                  const SpaceBetween(
                    verticalPadding: 12.0,
                    dividerColor: Colors.blueAccent,
                  ),
                  SectionHeader(
                    title: "Exams",
                    onSeeAllPressed: () {},
                  ),
                  const TopSchoolCards(itemCount: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
