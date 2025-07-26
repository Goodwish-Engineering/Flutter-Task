import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Profile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentRegistrationPage(),
    );
  }
}

class StudentRegistrationPage extends StatefulWidget {
  @override
  _StudentRegistrationPageState createState() =>
      _StudentRegistrationPageState();
}

class _StudentRegistrationPageState extends State<StudentRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Registration'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student Registration Form',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Full Name Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            // Email Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            // Contact Number Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Contact Number',
                border: OutlineInputBorder(),
              ),
            ),
            // Date of Birth Field
            SizedBox(height: 16),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () {
                // We'll add date picker logic later
              },
            ),

// Gender Dropdown
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
              items: ['Male', 'Female', 'Other'].map((gender) {
                return DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (value) {
                // We'll handle saving gender later
              },
            ),

// Profile Picture Upload
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // We'll add image picker logic later
              },
              icon: Icon(Icons.photo),
              label: Text('Upload Profile Picture'),
            ),
            SizedBox(height: 24),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  // We'll validate and handle submission here later
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
