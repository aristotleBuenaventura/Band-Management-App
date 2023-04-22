import 'package:flutter/material.dart';

class band_song extends StatefulWidget {
  @override
  _band_songState createState() => _band_songState();
}

class _band_songState extends State<band_song> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: const Center(
          child: Text("Band Song Entry"),
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
                      labelText: 'Enter the Song Name',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter the Song\'s Release Year',
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
