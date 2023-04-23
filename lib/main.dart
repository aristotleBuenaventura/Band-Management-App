import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_review/band_details.dart';
import 'package:restaurant_review/band_page.dart';
import 'package:restaurant_review/sql_helper.dart';
import 'band_entry.dart';
import 'band_song.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Band Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Band Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> _bands = [];

  void _refreshBands() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _bands = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshBands();
    if (kDebugMode) {
      print('.. number of items ${_bands.length}');
    }
  }

  void _deleteItem(int id) async {
    final bool confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete a Band'),
          content: const Text('Are you sure you want to delete this band?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await SQLHelper.deleteItem(id);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Successfully deleted a band')));
      _refreshBands();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Center(
          child: Text(widget.title),
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
                image: const DecorationImage(
                    image: AssetImage('assets/Banner.png'), fit: BoxFit.cover)),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                    Colors.black.withOpacity(.4),
                    Colors.black.withOpacity(.2),
                  ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _bands.length,
              itemBuilder: (context, index) => Card(
                  color: Colors.white,
                  margin: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(foregroundColor: Colors.black, backgroundColor: Colors.white,),
                    child: ListTile(
                      subtitle: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _bands[index]['band_name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _deleteItem(_bands[index]['id']);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.black),
                                    ),
                                    child: const Text(
                                        'Delete'), // the text displayed on the button
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => band_details(id: _bands[index]['id'],)));
                    },
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // _showForm(null);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => band_entry()));
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
                      "Add a Band",
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
