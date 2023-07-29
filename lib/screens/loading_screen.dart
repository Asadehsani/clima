import 'package:clima/components/loadingwidget.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../utilities/constants1.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isDataLoaded = false;
  double? latitude, longitude;

  GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  LocationPermission? permission;

  @override
  void initState() {
    super.initState();
    getPermission();
  }

  void getPermission() async {
    permission = await geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      print('Permission denied');
      permission = await geolocatorPlatform.requestPermission();
      if (permission != LocationPermission.denied){
        if(permission == LocationPermission.deniedForever){
          print('Permissin permanently denied, please provide permission to the app frome device setting');
        }else{
          print('Permission granted');
          getLocation();
        }
      }else{
        print('User denied the request');
      }
    } else {
      getLocation();
    }
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    NetworkHelper networkHelper = NetworkHelper("https://api.openweathermap.org/data/2."
        "5/weather?lat=$latitude&lon=$longitude&appid=$apikey");
      var weatherData = await networkHelper.getData();
      setState(() {
        isDataLoaded = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    if(!isDataLoaded){
      return const LoadingWidget();
    }else{
      return Scaffold(
        backgroundColor: kOverlayColor,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        decoration: kTextFieldDecoration,
                        onSubmitted: (String typedName){
                          print(typedName);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: ElevatedButton(onPressed: (){},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white12,
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Container(
                              height: 60,
                              child: Row(
                                children: const [
                                  Text('My Location',style: kTextFieldStyle,),
                                  SizedBox(width: 8,),
                                  Icon(Icons.gps_fixed, color: Colors.white60,)
                                ],
                              ),
                            )),
                      )
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_city, color: kMidLightColor,),
                      SizedBox(width: 12),
                      Text('City Name', style: kLocationTextStyle,),
                    ],
                  ),
                  SizedBox(width: 25),
                  Icon(Icons.wb_sunny_outlined, size: 280),
                  SizedBox(height: 40),
                  Text('00°', style: kTempTextStyle),
                  Text('CLEAR SKY', style: kLocationTextStyle,),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: kOverlayColor,
                  child: Container(height: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('31°', style: kDatailsTextStyle,),
                          Text('FEELS LIKE', style: kDatailsTitleTextStyle,)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: VerticalDivider(
                          thickness: 1,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('13°', style: kDatailsTextStyle,),
                          Text('HUMIDITY', style: kDatailsTitleTextStyle,)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: VerticalDivider(
                          thickness: 1,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('7°', style: kDatailsTextStyle,),
                          Text('WIND', style: kDatailsTitleTextStyle,)
                        ],
                      ),
                    ],
                  ),),
                ),
              )
            ],
          ),
        )
      );
    }
  }
}


// int id = decoedData['weather'][0]['id'];
// double temperature = decoedData['main']['temp'];
// var cityName = decoedData['name'];
//