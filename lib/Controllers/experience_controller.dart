import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

class ExperienceController {
  File? uploadedCV;

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
