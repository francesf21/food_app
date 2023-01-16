import 'dart:typed_data';

import 'package:food_app/models/profile.dart';
import 'package:food_app/res/res.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:food_app/data/network/network_api_services.dart';
import 'package:food_app/data/supabase/supabase.dart';

class ProfileRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<String> getUploadImage({
    required String filePath,
    required XFile? imageFile,
    required Uint8List bytes,
  }) async {
    String imageUrlResponse = '';

    try {
      await supabase.storage.from('avatars').uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(
              contentType: imageFile!.mimeType,
            ),
          );

      imageUrlResponse = await supabase.storage
          .from('avatars')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);
    } on StorageException catch (error) {
      print("Error en getUploadImage $error");
    } catch (error) {
      print("Error en getUploadImage $error");
    }

    return Future.value(imageUrlResponse);
  }

  Future<void> createProfile({
    required String username,
    required String firstname,
    required String lastname,
    required String phoneUser,
    required String avatarUrl,
  }) async {
    try {
      final user = supabase.auth.currentUser?.id ?? '';
      await supabase.from("profiles").insert({
        "id": user,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "phone_user": phoneUser,
        "avatar_url": avatarUrl,
      });
    } on AuthException catch (error) {
      print("Error en el metodo signUpUser $error");
    } catch (e) {
      print("Error en el metodo signUpUser $e");
    }
  }

  Future<Profiles> getProfileOfUserId() async {
    try {
      final user = supabase.auth.currentUser?.id ?? '';
      dynamic response = await _apiServices.getGetApiResponse(
        "${AppUrl.profileOfUserId}$user",
      );
      return response = profilesOfUserIdFromMap(response);
    } catch (e) {
      rethrow;
    }
  }
}
