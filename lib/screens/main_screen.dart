import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            const Positioned(
              top: 260,
              left: 150,
              child: Text(
                "19",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontFamily: 'PortLligatSans'),
              ),
            ),
            Positioned(
              top: 310,
              child: Container(
                width: 360,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Precpetation",
                      style: TextStyle(
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
              child: Container(
                width: 360,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Max : 45",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'PortLligatSans'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Min : 20",
                      style: TextStyle(
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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sunrise",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "5:30",
                            style: TextStyle(
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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sunset",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "5:30",
                            style: TextStyle(
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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Temp Max",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "12 C",
                            style: TextStyle(
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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Temp Min",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "8 C",
                            style: TextStyle(
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
      )),
    );
  }
}
