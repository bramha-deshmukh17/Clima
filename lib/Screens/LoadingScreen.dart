import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'DataScreen.dart';
import '../Services/WeatherHelp.dart';
import '../Utility/Constants.dart';

class Loadingscreen extends StatefulWidget {
  const Loadingscreen({super.key});

  @override
  State<Loadingscreen> createState() => _LoadingscreenState();
}

class _LoadingscreenState extends State<Loadingscreen> {
  double longitude = 0.0, latitude = 0.0;
  bool isLoading = false;
  final TextEditingController _controller = TextEditingController();
  var city;

  void getLocationData() async {
    setState(() {
      isLoading = true; // Show loading spinner
    });

    WeatherModel weatherHelp = WeatherModel();

    final response = await weatherHelp.getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DataScreen(
        weatherData: jsonDecode(response.body),
      );
    }));

    setState(() {
      isLoading = false; // Hide loading spinner after data is fetched
    });
  }

  void getCityData() async {
    setState(() {
      isLoading = true; // Show loading spinner
    });

    WeatherModel weatherHelp = WeatherModel();

    final response = await weatherHelp.getCityWeather(city);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DataScreen(
        weatherData: jsonDecode(response.body),
      );
    }));

    setState(() {
      isLoading = false; // Hide loading spinner after data is fetched
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: isLoading // Check if data is loading
              ? const SpinKitFadingCircle(
                  color: Colors.blue, // Loading spinner
                  size: 20.0,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200.0,
                      child: TextField(
                        controller: _controller,
                        decoration: kTextFieldInputDecoration,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextButton(
                        onPressed: () {
                          city = _controller.text;
                          getCityData();
                        },
                        style: TextButton.styleFrom(
                          elevation: 8,
                          backgroundColor: Colors.blue,
                        ),
                        child: Text('Get Weather Data',style: kButtonTextStyle,)),
                    const SizedBox(
                      height: 100.0,
                    ),
                    RawMaterialButton(
                      onPressed: () {
                        getLocationData();
                      },
                      fillColor: Colors.blue,
                      padding: const EdgeInsets.all(20.0),
                      shape: const CircleBorder(),
                      child: const Icon(FontAwesomeIcons.locationPin),
                    ),
                    const Text('Locate',style: kButtonTextStyle,)
                  ],
                ),
        ),
      ),
    );
  }
}
