import 'package:flutter/material.dart';

import 'home.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  "images/landing_page.png",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.7,
                  fit: BoxFit.cover,

                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Bringing ideas to life \n   one tap at a time.",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 5),

            Center(
              child: Text(
                "Stay informed, stay inspired discover \n        stories that shape tomorrow.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 50),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );

              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(
                  MediaQuery.of(context).size.width * 0.85,
                  MediaQuery.of(context).size.height * 0.06,
                ),
                elevation: 10,
              ),
              child: Text("Getting Started", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
