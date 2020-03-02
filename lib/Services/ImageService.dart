import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:iwas_port/Services/ImageException.dart';

class ImageService {

     Future get imageFromCamera async {
       try{
         var image = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 50);
         return image;
       }catch (imageFromCameraError){
         throw ImageException(imageFromCameraError.message);
       }

  }

    Future get imageFromGallery async {
       try{
         var image = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 50);
         return image;
       }catch (imageFromGalleryError){
         throw ImageException(imageFromGalleryError.message);
       }

  }



}



