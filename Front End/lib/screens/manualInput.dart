import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wevolve_project/screens/homePage.dart';
import 'package:http/http.dart' as http;
import 'value.dart';



class manualInput extends StatefulWidget {
  const manualInput({Key? key}) : super(key: key);

  @override
  State<manualInput> createState() => _manualInputState();
}

class _manualInputState extends State<manualInput> {

  var selected = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Emotional State Manually"),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "CHOOSE YOUR MOOD",
            style: TextStyle(fontSize: 28.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    selected = "Happy";
                  },
                icon: Image.asset("assets/smile.jpg"),iconSize: 80.0,),
              IconButton(
                  onPressed: () {
                    selected = "Neutral";
                  }, icon: Image.asset("assets/neutral.jpg"),iconSize: 80.0),
              IconButton(onPressed: () {
                selected = "Sad";
              }, icon: Image.asset("assets/sad.jpg"),iconSize: 80.0)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return homePage();
                    }

                    ));
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 48.0,
                  )),
              IconButton(
                  onPressed: () async {
                    String id = await getUserId();
                    final uri = Uri.parse(url+"/emotion?id="+id+"&emotion="+selected);
                    var request = http.Request('GET',uri);

                    request.send().then((response) async {
                      Fluttertoast.showToast(
                          msg: "Your mood is "+(await http.Response.fromStream(response)).body,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );

                    });


                  },
                  icon: const Icon(
                    Icons.check_circle_outline_rounded,
                    size: 48.0,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
