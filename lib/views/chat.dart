import 'package:boardingadmissions/components/appbar.dart';
import 'package:flutter/material.dart' hide VoidCallback;
import 'package:flutter/widgets.dart' show VoidCallback;

class Chat extends StatefulWidget {
  Chat({Key? key}) : super(key: key);

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  int selectedQueryIndex = 0;
  final List<String> schoolNames = [
    'School 1',
    'School 2',
    'School 3',
    'School 4',
    // Add more school names as needed
  ];
  final List<String> queries = [
    'Q 1',
    'Q 2',

    // Add more school names as needed
  ];

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Enquire Now",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      return schoolNames
                          .where((String option) => option
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()))
                          .toList();
                    },
                    onSelected: (String selectedSchool) {
                      textEditingController.text = selectedSchool;
                    },
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted) {
                      return TextFormField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        onFieldSubmitted: (String value) {
                          // Handle field submission
                        },
                        decoration: const InputDecoration(
                          labelText: 'Select a school',
                        ),
                      );
                    },
                    optionsViewBuilder: (BuildContext context,
                        AutocompleteOnSelected<String> onSelected,
                        Iterable<String> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 4.0,
                          child: Container(
                            width: double.infinity,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final String option = options.elementAt(index);
                                return ListTile(
                                  title: Text(option),
                                  onTap: () {
                                    onSelected(option);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextField()),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(180, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Your queries",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: selectedQueryIndex == 0
                              ? 2
                              : 0, // Elevate when selectedQueryIndex is 0
                        ),
                        onPressed: () {
                          setState(() {
                            selectedQueryIndex =
                                0; // Set selectedQueryIndex to 0
                          });
                        },
                        child: const Text(
                          "Your Queries",
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: selectedQueryIndex == 1
                              ? 2
                              : 0, // Elevate when selectedQueryIndex is 1
                        ),
                        onPressed: () {
                          setState(() {
                            selectedQueryIndex =
                                1; // Set selectedQueryIndex to 1
                          });
                        },
                        child: const Text(
                          "Resolved Queries",
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 300, // Set the height to 100 pixels
                  child: PageView.builder(
                    itemCount: queries.length,
                    controller: PageController(
                      initialPage: selectedQueryIndex, // Set the initial page
                      viewportFraction: 1.0, // Display one page at a time
                      keepPage: false, // Do not keep pages in memory
                    ),
                    onPageChanged: (int index) {
                      setState(() {
                        selectedQueryIndex = index; // Update the selected index
                      });
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context)
                              .size
                              .width, // Full screen width
                          color: Colors
                              .greenAccent, // Background color for the selected query
                          child: Center(
                            child: Text(
                              queries[index],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  children: [],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
