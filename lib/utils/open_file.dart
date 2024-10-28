import 'package:open_file/open_file.dart';

Future<void> openFile({
  required String filePath,
}) async {
  OpenFile.open(filePath);
}
