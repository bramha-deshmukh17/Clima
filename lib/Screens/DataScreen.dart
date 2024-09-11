import 'package:clima/Services/WeatherHelp.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Utility/Constants.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({required this.weatherData});

  final weatherData;

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  int temperature = 0;
  String city = '';
  int condition = 0;
  var icon, msg;

  @override
  void initState() {
    super.initState();
    setData(widget.weatherData);
  }

  void setData(dynamic weatherData) {
    double temp = double.parse(weatherData['main']['temp'].toString());
    temperature = temp.toInt();
    city = weatherData['name'] ?? 'Unknown city';
    condition = weatherData['weather'][0]['id'] ?? 0;

    WeatherModel weatherModel = WeatherModel();
    icon = weatherModel.getWeatherIcon(condition);
    msg = weatherModel.getMessage(temperature);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$temperature°C  $icon',
                style: kTempTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(FontAwesomeIcons.locationPin),
                    Text(city, style: kButtonTextStyle,),
                  ],
                ),
              ),
              const SizedBox(
                height: 150.0,
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Text(
                  msg,
                  style: kMessageTextStyle,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

const kTempText = TextStyle(
  fontSize: 65.0,
  fontWeight: FontWeight.bold,
);
