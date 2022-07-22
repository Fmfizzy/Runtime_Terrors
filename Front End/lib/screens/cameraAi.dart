import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'value.dart';

class CameraAi extends StatefulWidget {
  const CameraAi({Key? key}) : super(key: key);

  @override
  State<CameraAi> createState() => _CameraAiState();
}

class _CameraAiState extends State<CameraAi> {
  late File _image;
  Widget selected = const Icon(
    Icons.camera,
    color: Colors.blue,
    size: 280.0,
  );
  var hello = "";
  final imagePicker = ImagePicker();

  String emotion = "Please select an image.";


  Future getImageCamera() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
      setImage(image);
      
    });
  }

  Future getImageGallery() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
      setImage(image);
    });
  }
  
  void setImage(XFile? img){
    
    if (img == null){
      setState(() {
        selected = const Icon(
          Icons.camera,
          color: Colors.blue,
          size: 280.0,
        );
      });
    }else{
      setState(() {
        selected = Image.file(
            File(img.path),
            height: 280,
            width: 280,
        );
      });
    }
    
    
  }

  TextEditingController nameController = TextEditingController();

  Future uploadImage() async{
    String uid = await getUserId();
    final uri = Uri.parse(url+"/emotion?id="+uid);
    var request = http.MultipartRequest('POST',uri);

    var pic = await http.MultipartFile.fromPath("Image",_image.path);
    request.files.add(pic);

    request.send().then((response) async {

      if (response.statusCode == 200){
        String m = "Your emotion is "+ (await http.Response.fromStream(response)).body;


        setState(() {
          emotion = m;
        });
      }else{

        Fluttertoast.showToast(
            msg: "There was an error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.black,
            fontSize: 16.0
        );

        setState(() {
          emotion = "Please select an image.";
        });

      }





    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Capture your natural state"),
        backgroundColor: Colors.black45,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            icon:selected,
            onPressed: () {
              getImageCamera();
            },
            label: Text(""),
          ),

          const Text(
            "Select Image From gallery",
            style: TextStyle(fontSize: 28.0,fontWeight: FontWeight.bold),
          ),
          Text(
            emotion,
            style: TextStyle(fontSize: 16.0,color: Colors.grey),
          ),
          IconButton(
            icon: const Icon(
              Icons.image,
              size: 58.0,
              color: Colors.pinkAccent,
            ),
            onPressed: () {
              getImageGallery();
            },
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                  size: 28.0,
                )),
            IconButton(
                onPressed: () {
                  uploadImage();
                },
                icon: const Icon(
                  Icons.add_circle,
                  size: 28.0,

                )),
          ]),
        ],
      ),
    );
  }
}
