import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageService {

      //TODO: implement Error Handling
     Future get imageFromCamera async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 50);
      return image;
  }

    Future get imageFromGallery async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 50);

    return image;
  }



}



