import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(dropdownvalue);

  }


  Map responseBody = {};
  double temperature = 0;
  double minTemp = 0;
  double maxTemp = 0;
  String condition = " ";
  int sunriseTimestamp = 0;
  int sunsetTimestamp = 0;
  String cityName = "";
  num windSpeed = 0;
  num feelsLike = 0;
 String apiKey =
      'API key`'; // Use your actual OpenWeather API key here

  Future getData(String city) async {
    try {
      // var city = 'karachi';
      var url = Uri.parse(
          // 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=806cc66253eca12d22cdccaf11c74d8f'
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey"
          );

      var response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          responseBody.addAll(jsonDecode(response.body));
          setState(() {
            temperature = responseBody['main']['temp'] - 273;
            minTemp = responseBody["main"]['temp_min'] - 273;
            maxTemp = responseBody["main"]['temp_max'] - 273;
            condition = responseBody["weather"][0]["main"];
            sunriseTimestamp = responseBody["sys"]["sunrise"];
            sunsetTimestamp = responseBody["sys"]["sunset"];
            cityName = responseBody["name"];
            windSpeed = responseBody['wind']['speed'] * 3.6;
            feelsLike = responseBody['main']["feels_like"] - 273;
          });
        });
      } else {
        throw Exception("failed to load date");
      }
    } catch (error) {
      // ignore: avoid_print
      print('Error fetching data: $error');
      print(responseBody);
      responseBody.clear();
      print(responseBody);
      return responseBody;
    }
    print(responseBody);
    return responseBody;
  }

  String dropdownvalue = 'Karachi';
  var items = [
    "Karachi",
    "Lahore",
    "Islamabad",
    "Rawalpindi",
    "Faisalabad",
    "Peshawar",
    "Multan",
    "Hyderabad",
    "Quetta",
    "Sukkur",
    "Sialkot",
    "Gujranwala",
    "Bahawalpur",
    "Rahim Yar Khan",
    "Jhang",
    "Sahiwal",
    "Khairpur",
    "Mirpur Khas",
    "Larkana",
    "Jacobabad",
    "Tando Allahyar",
    "Tando Muhammad Khan",
    "Shikarpur",
    "Dera Ghazi Khan",
    "Dera Ismail Khan",
    "Bannu",
    "Kohat",
    "Mardan",
    "Swabi",
    "Abbottabad",
    "Mansehra",
    "Muzaffarabad",
    "Gilgit",
    "Skardu",
    "Chitral",
    "Gwadar",
    "Sanghar",
    "Nawabshah",
    "Kharo",
    "Mirpur",
    "Kotli",
  ];
  imagelink() {
    if (condition == "Thunderstorm") {
      return "assets/images/thunder.png";
    } else if (condition == "Clouds") {
      return "assets/images/clouds.png";
    } else if (condition == "Drizzle") {
      return "assets/images/image1.png";
    } else if (condition == "Rain") {
      return "assets/images/rain.png";
    } else if (condition == "Clear") {
      return "assets/images/clear.png";
    } else {
      return "assets/images/image1.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime sunriseDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000);
    String formattedSunrise = DateFormat('HH:mm').format(sunriseDateTime);

    DateTime sunsetDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000);
    String formattedSunset = DateFormat('HH:mm').format(sunsetDateTime);

    if (responseBody.isNotEmpty) {
      return Scaffold(
            body: Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromRGBO(101, 201, 252, 5),
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Positioned(
                  top: 45,
                  child: SizedBox(
                    width: 360,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton(
                          alignment: AlignmentDirectional.bottomCenter,
                          value: dropdownvalue,
                          borderRadius: BorderRadius.circular(20),
                          padding: const EdgeInsets.all(0),
                          menuMaxHeight: 400,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          dropdownColor: const Color.fromRGBO(101, 201, 252, 5),
                          // icon: const Icon(Icons.keyboard_arrow_down),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                            getData(dropdownvalue);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  )),
              Positioned(
                  top: 95,
                  left: 65,
                  child: Image.asset(
                    imagelink(),
                    // 'assets/images/image11.png',
                    width: 220,
                    height: 220,
                  )),
              Positioned(
                top: 310,
                left: 155,
                child: Text(
                  '${temperature.truncate()}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontFamily: 'PortLligatSans'),
                ),
              ),
              Positioned(
                top: 365,
                child: SizedBox(
                  width: 360,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        condition,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'PortLligatSans'),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 400,
                left: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/image11.png',
                          scale: 4,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Wind",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${windSpeed.truncate()} Km/h",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/image6.png',
                          scale: 8,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Feels Like",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${feelsLike.truncate()}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 480,
                  left: 30,
                  child: Container(
                    height: 1,
                    width: 300,
                    color: Colors.black,
                  )),
              Positioned(
                top: 500,
                left: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/image4.png',
                          scale: 8,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sunrise",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              formattedSunrise,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/image5.png',
                          scale: 8,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sunset",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              formattedSunset,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 140,
                  left: 30,
                  child: Container(
                    height: 1,
                    width: 300,
                    color: Colors.black,
                  )),
              Positioned(
                bottom: 60,
                left: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/image6.png',
                          scale: 8,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Temp Max",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${maxTemp.truncate()}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/image7.png',
                          scale: 8,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Temp Min",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${minTemp.truncate()}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
