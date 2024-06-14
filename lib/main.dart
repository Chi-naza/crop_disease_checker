import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disease Detector',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        fontFamily: GoogleFonts.lato().fontFamily,
        useMaterial3: true,
      ),
      home: const CaptureScreen(),
    );
  }
}

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key});

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  File? _image;
  late ImagePicker imagePicker;

  @override
  void initState() {
    imagePicker = ImagePicker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(
          "Enigma App Expresso",
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 43),
              _image == null
                  ? Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Container(
                            // margin: EdgeInsets.all(10),
                            // width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                  image:
                                      AssetImage("assets/images/noimage.png"),
                                  fit: BoxFit.cover),
                            ),
                            // child: Image.file(_image!),
                          ),
                          const SizedBox(height: 13),
                          const Text(
                            'Image',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "No Image Details To Display",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.red.withOpacity(0.4),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 13),
                        ],
                      ),
                    )
                  : Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: FileImage(_image!), fit: BoxFit.cover),
                            ),
                            // child: Image.file(_image!),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Image',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              _image!.path,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 13),
                        ],
                      ),
                    ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: pickAnImage,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text('Choose An Image From Gallery'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => pickAnImage(fromCamera: true),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text('Use The Camera Instead'),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // pick image func
  Future<void> pickAnImage({bool fromCamera = false}) async {
    XFile? image;

    if (fromCamera) {
      image = await imagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await imagePicker.pickImage(source: ImageSource.gallery);
    }

    if (image != null) {
      setState(() {
        _image = File(image!.path);
      });
    }
  }
}
