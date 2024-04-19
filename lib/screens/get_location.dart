import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/weather_model.dart';
import 'package:flutter_application_1/model/weather_services.dart';
import 'package:quickalert/quickalert.dart';

class EnterLocation extends StatefulWidget {
  const EnterLocation({super.key});

  @override
  State<EnterLocation> createState() => _EnterLocationState();
}

class _EnterLocationState extends State<EnterLocation> {
  final _weatherServices = WeatherServices('29b6c8eecd1ed3998e2ffb4faadbb94b');
  Weather? _weather;
  var weatherController = TextEditingController();
  void _handleEnterButtonPressed() {
    _fetchWeather(weatherController.text);
  }

  _fetchWeather(String cityName) async {
    print(cityName);
    try {
      final weather = await _weatherServices.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Invalid City Name');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Enter location'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                controller: weatherController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter Location'),
                ),
              ),
              ElevatedButton(
                onPressed: _handleEnterButtonPressed,
                child: Text('Enter'),
              ),
              Text(
                _weather?.cityName ?? "",
              ),
              Text(
                _weather?.temp.round().toString() ?? "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
