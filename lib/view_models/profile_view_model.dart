import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:food_app/models/profile.dart';
import 'package:food_app/repository/profile_repository.dart';
import 'package:food_app/data/response/api_response.dart';

class ProfileViewModel with ChangeNotifier {
  final _profileRepository = ProfileRepository();

  ApiResponse<Profiles> userProfile = ApiResponse.initial();

  setProfile(ApiResponse<Profiles> response) {
    userProfile = response;
    notifyListeners();
  }

  Future getUploadImage({
    required String filePath,
    required XFile? imageFile,
    required Uint8List bytes,
  }) async {
    String urlImage = "";
    try {
      urlImage = await _profileRepository.getUploadImage(
        filePath: filePath,
        imageFile: imageFile,
        bytes: bytes,
      );
    } catch (e) {
      print("Error en el ProfileViewModel $e");
    }
    return urlImage;
  }

  Future createProfile({
    required String username,
    required String firstname,
    required String lastname,
    required String phoneUser,
    required String avatarUrl,
  }) async {
    try {
      await _profileRepository.createProfile(
        username: username,
        firstname: firstname,
        lastname: lastname,
        phoneUser: phoneUser,
        avatarUrl: avatarUrl,
      );
    } catch (e) {
      print("Error en el ProfileViewModel $e");
    }
  }

  Future<void> getProfileApi() async {
    setProfile(ApiResponse.loading());
    await _profileRepository.getProfileOfUserId().then((value) {
      setProfile(ApiResponse.completed(value));
    }).onError((error, stackTrace) => setProfile(
          ApiResponse.error(error.toString()),
        ));
  }
}
