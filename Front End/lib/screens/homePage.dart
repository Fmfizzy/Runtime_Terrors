import 'package:flutter/material.dart';
import 'package:wevolve_project/screens/manualInput.dart';

import 'cameraAi.dart';


class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("WeVolve"),
          leading: const IconButton(
            icon: Icon(Icons.menu),
            onPressed: menu,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.insert_chart)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            tab1(),
            tab2(),
          ],
        ),
      ),
    );
  }

  Widget tab1() {
    return Container(
      color: Colors.white,
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.photo_camera),
              // color: Colors.black45,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return CameraAi();
                }

                ));
              },
              label: const Text(
                "Detect Emotion - Auto",
                style: TextStyle(fontSize: 28.0,color: Colors.white,),
              ),

            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_circle),
              // color: Colors.cyan,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return manualInput();
                }

                ));
              },
              label: const Text(
                "Tell us how you feel",
                style: TextStyle(fontSize: 28.0,color: Colors.white,),
              ),

            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.book,               color: Colors.lightGreenAccent,),

              onPressed: (){},
              label: const Text(
                "Read about psychology",
                style: TextStyle(fontSize: 28.0,               color: Colors.white,),
              ),

            )
          ]),
    );
  }

  Widget tab2() {
    return Container(
        color: Colors.white,
        child: const IconButton(
          icon: Icon(Icons.insert_chart),
          iconSize: 140.0,
          color: Colors.black,
          onPressed: analytics,
        )
    );
  }
}

analytics() {}

menu() {
  // Future<http.Response> fetchAlbum() {
  //   return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  // }
}