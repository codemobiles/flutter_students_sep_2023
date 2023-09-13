import 'dart:io';

import 'package:demo0/src/constants/network_api.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProductImage extends StatefulWidget {
  final Function(File? file) callBackSetImage;
  final String? image;

  const ProductImage(
    this.callBackSetImage, {
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  _ProductImageState createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  File? _imageFile;
  final _picker = ImagePicker();

  @override
  void dispose() {
    _imageFile?.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildPickerImage(),
          _buildPreviewImage(),
        ],
      ),
    );
  }

  Widget _buildPreviewImage() {
    final image = widget.image;
    if ((image == null || image.isEmpty) && _imageFile == null) {
      return const SizedBox();
    }

    if (_imageFile != null) {
      return Stack(
        children: [
          ReuseContainer(
            Image.file(
              _imageFile!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          _buildDeleteImageButton(),
        ],
      );
    }

    return ReuseContainer(
      Image.network(
        '${NetworkAPI.imageURL}/$image',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget ReuseContainer(Widget child) => Container(
        color: Colors.grey[100],
        margin: EdgeInsets.only(top: 4),
        alignment: Alignment.center,
        height: 250,
        child: child,
      );

  IconButton _buildPickerImage() => IconButton(
        icon: Icon(Icons.image),
        onPressed: _modalPickerImage,
      );

  void _modalPickerImage() {
    buildListTile(
      IconData icon,
      String title,
      ImageSource source,
    ) =>
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          onTap: () {
            Navigator.of(context).pop();
            _pickImage(source);
          },
        );

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildListTile(
                Icons.photo_camera,
                'Take a picture from camera',
                ImageSource.camera,
              ),
              buildListTile(
                Icons.photo_library,
                'Choose from photo library',
                ImageSource.gallery,
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImage(ImageSource source) {
    _picker
        .pickImage(
      source: source,
      imageQuality: 70,
      maxHeight: 500,
      maxWidth: 500,
    )
        .then((file) {
      if (file != null) {
        _cropImage(file.path);
      }
    }).catchError((error) {
      //todo
    });
  }

  void _cropImage(String filePath) {
    ImageCropper()
        .cropImage(
      sourcePath: filePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      maxWidth: 500,
      maxHeight: 500,
      //circleShape: true
    )
        .then((file) {
      if (file != null) {
        setState(() {
          _imageFile = File(file.path);
          widget.callBackSetImage(_imageFile);
        });
      }
    });
  }

  Positioned _buildDeleteImageButton() => Positioned(
        right: -10,
        top: 10,
        child: RawMaterialButton(
          onPressed: () => _deleteImage(),
          fillColor: Colors.white,
          shape: const CircleBorder(
            side: BorderSide(
                width: 1, color: Colors.grey, style: BorderStyle.solid),
          ),
          child: const Icon(Icons.clear),
        ),
      );

  void _deleteImage() {
    setState(() {
      _imageFile = null;
      widget.callBackSetImage(null);
    });
  }
}
