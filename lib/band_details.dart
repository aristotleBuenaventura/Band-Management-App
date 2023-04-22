import 'package:flutter/material.dart';
import 'package:restaurant_review/band_member.dart';
import 'package:restaurant_review/band_song.dart';
import 'package:restaurant_review/sql_helper.dart';

class band_details extends StatefulWidget {
  final int id;
  const band_details({Key? key, required this.id}) : super(key: key);

  @override
  State<band_details> createState() => _band_detailsState();
}

class _band_detailsState extends State<band_details> {
  List<Map<String, dynamic>> _bands = [];

  void _refreshBands() async {
    final data = await SQLHelper.getItem(widget.id);
    setState(() {
      _bands = data;
      print(_bands);
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshBands();
  }

  String image(String genre) {
    String genreImage = '';
    if (genre == 'K pop') {
      genreImage = 'assets/k-pop.png';
    } else if (genre == 'Rock') {
      genreImage = 'assets/Rock.png';
    } else if (genre == 'Metal') {
      genreImage = 'assets/Metal.png';
    } else if (genre == 'OPM') {
      genreImage = 'assets/OPM.png';
    } else if (genre == 'Jazz') {
      genreImage = 'assets/Jazz.png';
    } else if (genre == 'R&B') {
      genreImage = 'assets/R&B.png';
    }
    return genreImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Center(
          child: Text(_bands.isNotEmpty ? _bands[0]['band_name'] : ''),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(image(_bands[0]['genre_name'])),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(.4),
                    Colors.black.withOpacity(.2),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Container(
                width:
                    double.infinity, // Set the desired width of the container
                height: 50, // Set the desired height of the container
                decoration: const BoxDecoration(
                  color: Colors.white,
                   // You can adjust the radius to change the pill shape
                ),
                child: Container(
                  width: 200,
                  height: 50,
                  child: const Center(
                    // Wrap the Text widget in a Center widget
                    child: Text(
                      'Members',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => band_member()));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.black, // Set text color to white
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const SizedBox(
                width: 150,
                height: 50,
                child: Center(
                  child: Text(
                    'Add Band Member',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Container(
                width:
                double.infinity, // Set the desired width of the container
                height: 50, // Set the desired height of the container
                decoration: BoxDecoration(
                  color: Colors.white,
                  // You can adjust the radius to change the pill shape
                ),
                child: Container(
                  width: 200,
                  height: 50,
                  child: const Center(
                    // Wrap the Text widget in a Center widget
                    child: Text(
                      'Songs',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => band_song()));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.black, // Set text color to white
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const SizedBox(
                width: 150,
                height: 50,
                child: Center(
                  child: Text(
                    'Add Song',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => band_entry()));
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
          )

        ],
      ),
    );
  }
}

// Text(_bands.isNotEmpty ? _bands[0]['genre_name'] : ''),
