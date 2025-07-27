import 'dart:io';
import 'package:flutter/material.dart';
import 'top_places.dart';
import 'add_post.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isFocused = false;
  List<Map<String, dynamic>> posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/images/home.png",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, right: 20),
                child: Row(
                  children: [
                    const SizedBox(width: 10,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TopPlaces()),
                        );
                      },
                      child: Material(
                        elevation: 3.5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            "assets/images/pin.png",
                            height: 30,
                            width: 30,
                          )
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Add navigation to AddPost page
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddPost()),
                        );
                        
                        // Process returned data
                        if (result != null && result is Map<String, dynamic>) {
                          setState(() {
                            posts.insert(0, result); // Add new post at the beginning
                          });
                        }
                      },
                      child: Material(
                        elevation: 3.5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.add, color: Colors.blue, size:30),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(60),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.asset(
                          "assets/images/boy.jpg",
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 120,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Traveller",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Lato',
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Your Travel Assistant",
                      style: TextStyle(
                        color: Color.fromARGB(93, 249, 248, 249),
                        fontFamily: 'Lato',
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(
                  left: _isFocused ? 10 : 20,
                  right: _isFocused ? 10 : 20,
                  top: MediaQuery.of(context).size.height / 3.15,
                ),
                height: _isFocused ? 50 : 40,
                child: Material(
                  elevation: 100.0,
                  borderRadius: BorderRadius.circular(15),
                  child: TextField(
                    onTap: () {
                      setState(() {
                        _isFocused = true;
                      });
                    },
                    onEditingComplete: () {
                      setState(() {
                        _isFocused = false;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      hintText: "Search your destination",
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.00),
          
          // Display posts
          Expanded(
            child: posts.isEmpty
              ? _buildDefaultPost()
              : ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return Container(
                      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                      child: Material(
                        elevation: 3.2,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10, top: 10),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.asset(
                                        'assets/images/boy.jpg',
                                        height: 35,
                                        width: 35,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Text(
                                      post['name'],
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontFamily: 'Lato',
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(post['imagePath']),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height / 3.5,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Icon(Icons.location_pin, color: Colors.blue),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      "${post['location']}, ${post['city']}",
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontFamily: 'Lato',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 8.0,
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: Text(
                                  post['description'] ?? "Beautiful place to visit!",
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.00),
                                      child: Icon(
                                        Icons.favorite_border_outlined,
                                        color: Color.fromARGB(139, 0, 0, 0),
                                        size: 30,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3.0),
                                      child: Text(
                                        "Like",
                                        style: TextStyle(
                                          color: Color.fromARGB(139, 0, 0, 0),
                                          fontFamily: 'Lato',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Icon(
                                        Icons.comment_outlined,
                                        color: Color.fromARGB(139, 0, 0, 0),
                                        size: 30,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "Comment",
                                        style: TextStyle(
                                          color: Color.fromARGB(139, 0, 0, 0),
                                          fontFamily: 'Lato',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDefaultPost() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Material(
        elevation: 3.2,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        'assets/images/boy.jpg',
                        height: 35,
                        width: 35,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      "Traveller",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Lato',
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(
                "assets/images/tajmahal.jpg",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.5,
                fit: BoxFit.cover,
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.location_pin, color: Colors.blue),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(
                      "Taj Mahal, Agra, India",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Lato',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 8.0,
                  top: 5,
                  bottom: 5,
                ),
                child: Text(
                  "Taj Mahal — chhobi theke o shundor. ",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 10.00),
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: Color.fromARGB(139, 0, 0, 0),
                        size: 30,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.0),
                      child: Text(
                        "Like",
                        style: TextStyle(
                          color: Color.fromARGB(139, 0, 0, 0),
                          fontFamily: 'Lato',
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Icon(
                        Icons.comment_outlined,
                        color: Color.fromARGB(139, 0, 0, 0),
                        size: 30,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Comment",
                        style: TextStyle(
                          color: Color.fromARGB(139, 0, 0, 0),
                          fontFamily: 'Lato',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}