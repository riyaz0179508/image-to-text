
import 'dart:io';

import 'package:challenge_1_scan_to_text/details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future <void> main()async{
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //Variable start
  String _text='';
  PickedFile? _image;
  final picker = ImagePicker();

  //Variable end


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Text Recognization"),
          actions: [
            FlatButton(
                onPressed: scanText,
                child: Text("Scan", style: TextStyle(color: Colors.white),))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: getImage, child: Icon(Icons.add_a_photo),),

        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: _image != null ? Image.file(
            File(_image!.path), fit: BoxFit.fitWidth,) : Container(),
        ),),
    );

  }
    Future scanText()async{
     await showDialog(
         context: context,
         builder: (BuildContext context) {
           return Dialog(
             child: CircularProgressIndicator(),

           );
         },

     );
final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(File(_image!.path));
final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
final VisionText visiontext = await textRecognizer.processImage(visionImage);
for(TextBlock block in visiontext.blocks){
  for(TextLine line in block.lines){
    _text += (line.text!+'\n');
  }
}

Navigator.of(context).pop();
Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Details(text: '',)));
    }


    Future getImage() async{
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if(pickedFile != null){
          _image = pickedFile;
        }else {
          print ("No image selected");
        }
      });
    }
}
