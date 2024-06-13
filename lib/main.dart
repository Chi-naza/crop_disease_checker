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
        title: Text(
          "Enigma App Expresso",
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? const Icon(
                    Icons.image,
                    size: 200,
                  )
                : Card(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.file(_image!)),
                        const SizedBox(height: 13),
                        const Text(
                          'Image',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          _image!.path,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 13),
                      ],
                    ),
                  ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: pickAnImage,
              child: const Text('Choose An Image From Gallery'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => pickAnImage(fromCamera: true),
              child: const Text('Use The Camera Instead'),
            ),
          ],
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
