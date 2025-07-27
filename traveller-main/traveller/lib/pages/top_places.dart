import 'package:flutter/material.dart';

class TopPlaces extends StatefulWidget {
  const TopPlaces({super.key});

  @override
  State<TopPlaces> createState() => _TopPlacesState();
}

class _TopPlacesState extends State<TopPlaces> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  // Add navigation back to Home screen
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Material(
                      elevation: 3.5,
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(41, 110, 108, 108),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(Icons.arrow_back_rounded, size: 25),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 5.5),
                  const Text(
                    "Top Places",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Material(
                elevation: 3.0,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                             
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(
                                      "assets/images/bali.jpg",
                                      height: 200,
                                      width: 130,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                  
                                    margin: const EdgeInsets.only(top: 168,),
                                    width: 130,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(28, 0, 0, 0),
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                    ),
                                    child: const Center(
                                      child: Text("Bali",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(
                                      "assets/images/india.jpg",
                                      height: 200,
                                      width: 130,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                  
                                    margin: const EdgeInsets.only(top: 168),
                                    width: 130,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(28, 0, 0, 0),
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                    ),
                                    child: const Center(
                                      child: Text("India",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                             
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(
                                      "assets/images/mexico.jpg",
                                      height: 200,
                                      width: 130,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                  
                                    margin: const EdgeInsets.only(top: 168,),
                                    width: 130,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(28, 0, 0, 0),
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                    ),
                                    child: const Center(
                                      child: Text("Mexico",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(
                                      "assets/images/france.jpg",
                                      height: 200,
                                      width: 130,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                  
                                    margin: const EdgeInsets.only(top: 168),
                                    width: 130,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(28, 0, 0, 0),
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                    ),
                                    child: const Center(
                                      child: Text("France",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                             
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(
                                      "assets/images/newyork.jpg",
                                      height: 200,
                                      width: 130,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                  
                                    margin: const EdgeInsets.only(top: 168,),
                                    width: 130,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(28, 0, 0, 0),
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                    ),
                                    child: const Center(
                                      child: Text("New York",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(
                                      "assets/images/dubai.jpg",
                                      height: 200,
                                      width: 130,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                  
                                    margin: const EdgeInsets.only(top: 168),
                                    width: 130,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(28, 0, 0, 0),
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                    ),
                                    child: const Center(
                                      child: Text("Dubai",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}