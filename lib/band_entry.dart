import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_review/sql_helper.dart';
import 'band_member.dart';

import 'main.dart';

class band_entry extends StatefulWidget {
  @override
  _band_entryState createState() => _band_entryState();
}

class _band_entryState extends State<band_entry> {
  String? _bandName;
  String? _genre;

  Future<void> _addItem() async {
    await SQLHelper.createItem(_bandName!,_genre!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: const Center(
          child: Text("Band Entry"),
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
                      labelText: 'Enter the Band name',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _bandName = value;
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
                  value: _genre,
                  onChanged: (String? newValue) {
                    setState(() {
                      _genre = newValue;
                    });
                    print(_genre);
                    print(_bandName);
                  },
                  hint: const Text('Genre'),
                  items: <String>[
                    "K pop",
                    "Rock",
                    "Metal",
                    "OPM",
                    "Jazz",
                    "R&B",
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
                                if (_genre != null && _bandName != null) {
                                  Navigator.of(context).pop();
                                  _addItem();
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
