import 'package:flutter/material.dart';
import 'package:flutter_application_1/hikerscreen.dart';
import 'package:flutter_application_1/screens/weatherPage.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: screenSize.width,
              height: screenSize.height,
              child: Image.asset('assets/images/2.png', fit: BoxFit.cover),
            ),
            Positioned(
              bottom: 170.0,
              left: screenSize.width / 2 - 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HikerScreen()));
                },
                child: Text('Get Started'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
