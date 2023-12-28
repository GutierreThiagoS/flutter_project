import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/domain/models/coupon.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {

  List<XFile>? _mediaFileList;
  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  String text = "";

  Future<void> readTextFromImage(File image) async {
    print("init readTextFromImage image $image");
    final inputImage = InputImage.fromFile(image);
    print("2 readTextFromImage ");
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    print("3 readTextFromImage recognizedText $recognizedText");
    text = recognizedText.text;
    print("end readTextFromImage");
    print(text);
  }

  String? _retrieveDataError;

  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  Future<void> _onImageButtonPressed(
      ImageSource source, {
        required BuildContext context
      }
    ) async {

    if (context.mounted) {
      final double? width = maxWidthController.text.isNotEmpty
          ? double.parse(maxWidthController.text)
          : null;
      final double? height = maxHeightController.text.isNotEmpty
          ? double.parse(maxHeightController.text)
          : null;
      final int? quality = qualityController.text.isNotEmpty
          ? int.parse(qualityController.text)
          : null;
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
          maxWidth: width,
          maxHeight: height,
          imageQuality: quality,
        );
        File file = File(pickedFile!.path);

        await readTextFromImage(file);

        setState(() {
          _setImageFileListFromFile(pickedFile);
        });
      } catch (e) {
        print(e);
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  Future<void> retrieveLostData() async {
    print("retrieveLostData");
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      await readTextFromImage(File(response.file!.path));
      setState(() {
        if (response.files == null) {
          _setImageFileListFromFile(response.file);
        } else {
          _mediaFileList = response.files;
        }
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    print("_previewImages _mediaFileList $_mediaFileList");

    if (_mediaFileList != null) {
      return Semantics(
        label: 'image_picker_example_picked_images',
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          key: UniqueKey(),
          itemBuilder: (BuildContext context, int index) {
            return Semantics(
              label: 'image_picker_example_picked_image',
              child: Column(
                children: [
                  (kIsWeb
                    ? Image.network(_mediaFileList![index].path)
                    : Image.file(
                  File(_mediaFileList![index].path),
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return const Center(
                        child:
                        Text('This image type is not supported'));
                    },
                )),
                  Text(text)
              ])
            );
          },
          itemCount: _mediaFileList!.length,
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Erro na Foto: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'Imagem.',
        textAlign: TextAlign.center,
      );
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {

    Coupon? coupon = ModalRoute.of(context)!.settings.arguments as Coupon?;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cupom"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey,
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            padding: const EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Cupom - ${coupon?.code}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
          
                          Center(
                            child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                                ? FutureBuilder<void>(
                              future: retrieveLostData(),
                              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                  case ConnectionState.waiting:
                                    return const Text(
                                      'Imagem não fornecida.',
                                      textAlign: TextAlign.center,
                                    );
                                  case ConnectionState.done:
                                    return _previewImages();
                                  case ConnectionState.active:
                                    if (snapshot.hasError) {
                                      return Text(
                                        'Pick image/video error: ${snapshot.error}}',
                                        textAlign: TextAlign.center,
                                      );
                                    } else {
                                      return const Text(
                                        'You have not yet picked an image.',
                                        textAlign: TextAlign.center,
                                      );
                                    }
                                }
                              },
                            ) : _previewImages(),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: IconButton(
                              padding: const EdgeInsets.all(10),
                              icon: const Icon(
                                  Icons.camera_alt,
                                  size: 70
                              ),
                              onPressed: () {
                                _onImageButtonPressed(ImageSource.camera, context: context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ))
              ]
          ),
        ),
      ),
    );
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
