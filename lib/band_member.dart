import 'package:flutter/material.dart';

class band_member extends StatelessWidget {
  const band_member({Key? key}) : super(key: key);

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
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter the Band Member Name',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                height: 60.0,
                width: double.infinity, // set the desired width here
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                    child: DropdownButton<String>(
                      value: "Electric Guitar",
                      onChanged: (String? newValue) {},
                      hint: const Text('Instrument'), // set the placeholder text here
                      items: <String>[
                        "Electric Guitar",
                        "Acoustic Guitar",
                        "Bass guitar",
                        "Drums",
                        "Piano/keyboard",
                        "Saxophone",
                        "Trumpet",
                        "Trombone",
                        "Flute",
                        "Clarinet",
                        "Violin",
                        "Viola",
                        "Cello",
                        "Double bass",
                        "Harmonica",
                        "Accordion",
                        "Ukulele",
                        "Banjo",
                        "Mandolin",
                        "Vocals/singers",
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
                    // _showForm(null);

                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: Colors.white,
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
                            color: Colors.black,
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
