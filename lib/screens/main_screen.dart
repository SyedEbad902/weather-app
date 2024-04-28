import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

    // Navigate to main screen
    getData();
  }

  Map responseBody = {};
  bool isloading = true;
  Future<void> getData() async {
    try {
      var url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=24.860966&lon=66.990501&appid=806cc66253eca12d22cdccaf11c74d8f');

      var response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          responseBody = jsonDecode(response.body);
          isloading = false;
        });
      } else {
        throw Exception("failed to load date");
      }
    } catch (error) {
      // ignore: avoid_print
      print('Error fetching data: $error');
      setState(() {
        isloading = false; // Set loading to false even if there's an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    num temp = responseBody["main"]["temp"] - 273.15;
    num minTemp = responseBody["main"]["temp_min"] - 273.15;
    num maxTemp = responseBody["main"]["temp_max"] - 273.15;
    String condition = responseBody["weather"][0]["main"];
    int sunriseTimestamp = responseBody["sys"]["sunrise"];
    DateTime sunriseDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000);
    String formattedSunrise = DateFormat('HH:mm').format(sunriseDateTime);

    int sunsetTimestamp = responseBody["sys"]["sunset"];
    DateTime sunsetDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000);
    String formattedSunset = DateFormat('HH:mm').format(sunsetDateTime);

    return Scaffold(
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(), // Show a loading indicator
            )
          : SafeArea(
              child: Scaffold(
                  body: Container(
                height: double.infinity,
                width: double.infinity,
                color: const Color.fromRGBO(74, 59, 148, 5),
                child: Stack(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Positioned(
                        top: 50,
                        left: 55,
                        child: Image.asset('assets/images/image2.png')),
                    Positioned(
                      top: 260,
                      left: 155,
                      child: Text(
                        "${temp.truncate()}",

                        // responseBody["main"]["temp"],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontFamily: 'PortLligatSans'),
                      ),
                    ),
                    Positioned(
                      top: 310,
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
                      top: 340,
                      child: SizedBox(
                        width: 360,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Max : ${maxTemp.truncate()}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'PortLligatSans'),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Min : ${minTemp.truncate()}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 450,
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
                        bottom: 190,
                        left: 30,
                        child: Container(
                          height: 1,
                          width: 300,
                          color: Colors.black,
                        )),
                    Positioned(
                      bottom: 110,
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
                    // Positioned(
                    //     child: FloatingActionButton(
                    //   onPressed: () {
                    //     getData();
                    //   },
                    //   child: const Text('go'),
                    // )),
                  ],
                ),
              )),
            ),
    );
  }
}
