import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/screens/get_location.dart';
import 'package:flutter_application_1/screens/weatherPage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as Geocoding;

class HikerScreen extends StatefulWidget {
  const HikerScreen({super.key});

  @override
  State<HikerScreen> createState() => _HikerScreenState();
}

class _HikerScreenState extends State<HikerScreen> {
  String country = '';
  String region = '';
  String municipality = '';
  String city = '';
  String street = '';
  String barangay = '';

  TextEditingController address = TextEditingController();
  Position? position;
  Geocoding.Location? location;
  @override
  Widget build(BuildContext context) {
    Future<bool> checkServicePermission() async {
      //checking loction service
      bool isEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location is Disabled Please Enable it'),
          ),
        );
        return false;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Location permission is Disabled Please Enable it'),
            ),
          );
        }
      }
      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Location permission is permanently denied. Please change in the setting to continue'),
          ),
        );
        return false;
      }
      return true;
    }

    void getCurrentLocation() async {
      if (!await checkServicePermission()) {
        return;
      }

      Position currentPosition = await Geolocator.getCurrentPosition();
      List<Geocoding.Placemark> placemarks =
          await Geocoding.placemarkFromCoordinates(
        currentPosition.latitude,
        currentPosition.longitude,
      );
      //to see if placemark got it
      print(placemarks[0].country);
      print(placemarks[0].administrativeArea); // region
      print(placemarks[0].subAdministrativeArea); // municipality
      print(placemarks[0].locality); // city
      print(placemarks[0].name); // name of the street
      print(placemarks[0].street); //
      print(placemarks[0].thoroughfare); // barangay

      if (placemarks.isNotEmpty) {
        setState(() {
          position = currentPosition;
          country = placemarks[0].country ?? '';
          region = placemarks[0].administrativeArea ?? '';
          municipality = placemarks[0].subAdministrativeArea ?? '';
          city = placemarks[0].locality ?? '';
          street = placemarks[0].name ?? '';
          barangay = placemarks[0].thoroughfare ?? '';
        });
      }
    }

    // void getGeocode() async {
    //   List<Geocoding.Location> locations =
    //       await Geocoding.locationFromAddress(address.text);
    //   print(location);
    //   if (locations.isNotEmpty) {
    //     setState(() {
    //       location = locations.first;
    //     });
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EnterLocation()),
                );
              },
              icon: Icon(Icons.next_plan))
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/3.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Latitude: ${position?.latitude ?? ''}',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Longitude: ${position?.longitude ?? ''}',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Country: $country',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Region: $region',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Municipality: $municipality',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'City: $city',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Barangay: $barangay',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Street: $street',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: getCurrentLocation,
                    child: Text('Get Current Location'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => UserPage()),
          );
        },
        child: Icon(Icons.sunny),
      ),
    );
  }
}
