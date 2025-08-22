import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    // const MyApp());
      DevicePreview(
        enabled: true,
        builder: (context)=>const MyApp(),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Matches',
      theme: ThemeData(primarySwatch: Colors.blue),
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      home: const MatchListScreen(),
    );
  }
}


class MatchListScreen extends StatelessWidget {
  const MatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Match List")),
      body: StreamBuilder<QuerySnapshot>( //Firebase link:https://console.firebase.google.com/u/0/project/fir-9d900/firestore/databases/-default-/data/~2Fmatches~2F%20match2?fb_gclid=Cj0KCQjwqqDFBhDhARIsAIHTlkvWZJCAWeHDCqYlMz_Tgk-M3hsgkYSERziMFN-UyB5Ip7covdzEKNwaAplzEALw_wcB
        stream: FirebaseFirestore.instance.collection("matches").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No matches found"));
          }

          var matches = snapshot.data!.docs;

          return ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, index) {
              var match = matches[index];
              String matchName = "${match['teamA']} vs ${match['teamB']}";

              return ListTile(
                title: Text(matchName),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatchDetailScreen(matchId: match.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}


class MatchDetailScreen extends StatelessWidget {
  final String matchId;

  const MatchDetailScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Match Details")),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection("matches").doc(matchId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("Match not found"));
          }

          var data = snapshot.data!;
          String matchName = "${data['teamA']} vs ${data['teamB']}";

          return Center(
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(matchName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text("${data['goalsA']} : ${data['goalsB']}",
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text("Time: ${data['runningTime']}"),
                    Text("Total Time: ${data['totalTime']}"),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
