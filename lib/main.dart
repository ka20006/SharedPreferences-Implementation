// Created by Kavan

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(SharedPreferencesApp());
}

class SharedPreferencesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SharedPreferences Demo',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: SharedPreferencesScreen(),
    );
  }
}

class SharedPreferencesScreen extends StatefulWidget {
  @override
  _SharedPreferencesScreenState createState() =>
      _SharedPreferencesScreenState();
}

class _SharedPreferencesScreenState extends State<SharedPreferencesScreen> {
  TextEditingController dataController = TextEditingController();
  String savedData = "No Data Saved";

  // Save Data
  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userData', dataController.text);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Data Saved Successfully")));

    dataController.clear();
  }

  // Retrieve Data
  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedData = prefs.getString('userData') ?? "No Data Found";
    });
  }

  // Remove Data
  Future<void> removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData');

    setState(() {
      savedData = "Data Removed";
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Data Removed Successfully")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SharedPreferences App"), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20),

            // Title
            Text(
              "Local Storage Demo",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),

            SizedBox(height: 30),

            // TextField
            TextField(
              controller: dataController,
              decoration: InputDecoration(
                labelText: "Enter Data",
                hintText: "Type something...",
                prefixIcon: Icon(Icons.storage),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            SizedBox(height: 25),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: saveData,
                icon: Icon(Icons.save),
                label: Text("Save Data"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),

            SizedBox(height: 15),

            // Retrieve Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: getData,
                icon: Icon(Icons.download),
                label: Text("Retrieve Data"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),

            SizedBox(height: 15),

            // Remove Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: removeData,
                icon: Icon(Icons.delete),
                label: Text("Remove Data"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),

            SizedBox(height: 30),

            // Display Saved Data
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Saved Data:",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      savedData,
                      style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 40),

            // Footer
            Text(
              "Created by Kavan",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
