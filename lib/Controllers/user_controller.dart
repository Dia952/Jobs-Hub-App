import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

import 'package:jobs_hub/Services/user_service.dart';

class UserController {
  UserService userService = UserService();
  File? uploadedCV;

  Future<bool> updateUser() async {
    final updateStatus = await userService.updateUser();
    return updateStatus;
  }

  Future<File?> uploadCV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['doc', 'pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      uploadedCV = File(result.files.single.path!);
      return uploadedCV;
    }

    return null;
  }

  void openCV() async {
    if (uploadedCV != null) {
      await OpenFile.open(uploadedCV!.path);
    }
  }
}
