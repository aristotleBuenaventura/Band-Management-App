import 'package:flutter/material.dart';
import 'package:restaurant_review/sql_helper.dart';

import 'main.dart';

class band_member extends StatefulWidget {
  final int id;
  const band_member({Key? key, required this.id}) : super(key: key);

  @override
  _band_memberState createState() => _band_memberState();
}

class _band_memberState extends State<band_member> {
  String? _memberName;
  String? _instrumentName;

  Future<void> _updateItemMember(int id) async {
    await SQLHelper.createItemMember(
        id, _memberName!, _instrumentName!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: const Center(
          child: Text("Band Member Entry"),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Enter the Band Member name',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _memberName = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                height: 60.0,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                    child: DropdownButton<String>(
                      value: _instrumentName,
                      onChanged: (String? newValue) {
                        setState(() {
                          _instrumentName = newValue;
                        });
                      },
                      hint: const Text('Instrument'),
                      items: <String>[
                        "Vocal",
                        "Guitar",
                        "Bass",
                        "Keyboard",
                        "Drums",
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Show a confirmation dialog before saving
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirmation"),
                          content: Text("Are you sure you want to save?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                // Close the dialog and save the item if genre and bandName are not null
                                if (_memberName != null && _instrumentName != null) {
                                  Navigator.of(context).pop();
                                  _updateItemMember(widget.id);
                                  Navigator.of(context).pop();
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => MyApp()));
                                } else {
                                  // Show an alert message if genre or bandName is null
                                  Navigator.of(context).pop();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content: Text("Genre and band name cannot be empty."),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("OK"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: Text("Yes"),
                            ),
                            TextButton(
                              onPressed: () {
                                // Close the dialog without saving
                                Navigator.of(context).pop();
                              },
                              child: Text("No"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    foregroundColor: Colors.black, backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const SizedBox(
                    width: 200, // Set the desired width here
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

}