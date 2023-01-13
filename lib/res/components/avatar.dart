import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:food_app/res/res.dart';
import 'package:food_app/view_models/view_model.dart';

class Avatar extends StatefulWidget {
  final String? imageUrl;
  final void Function(String) onUpload;

  const Avatar({
    super.key,
    required this.imageUrl,
    required this.onUpload,
  });

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.imageUrl == null || widget.imageUrl!.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 48, bottom: 8),
            child: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              radius: 100,
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      'No hay imagen',
                      style: AppStyle.instance.bodyXLarge,
                    ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.only(top: 48, bottom: 8),
            child: CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(widget.imageUrl!),
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 24,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: _isLoading ? null : _uploadCamera,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camara'),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: _isLoading ? null : _uploadGallery,
                  icon: const Icon(Icons.photo),
                  label: const Text('Galeria'),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future _uploadCamera() async {
    final ProfileViewModel profileProvider = Provider.of<ProfileViewModel>(
      context,
      listen: false,
    );

    final picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 300,
      maxHeight: 300,
    );
    if (imageFile == null) {
      return;
    }
    setState(() => _isLoading = true);

    final bytes = await imageFile.readAsBytes();
    final fileExt = imageFile.path.split('.').last;
    final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
    final filePath = fileName;

    String imageUrlResponse = await profileProvider.getUploadImage(
      filePath: filePath,
      imageFile: imageFile,
      bytes: bytes,
    );

    widget.onUpload(imageUrlResponse);

    setState(() => _isLoading = false);
  }

  Future<void> _uploadGallery() async {
    final ProfileViewModel profileProvider = Provider.of<ProfileViewModel>(
      context,
      listen: false,
    );

    final picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );
    if (imageFile == null) {
      return;
    }
    setState(() => _isLoading = true);

    final bytes = await imageFile.readAsBytes();
    final fileExt = imageFile.path.split('.').last;
    final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
    final filePath = fileName;

    String imageUrlResponse = await profileProvider.getUploadImage(
      filePath: filePath,
      imageFile: imageFile,
      bytes: bytes,
    );

    widget.onUpload(imageUrlResponse);

    setState(() => _isLoading = false);
  }
}
