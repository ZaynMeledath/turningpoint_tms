import 'package:open_file/open_file.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';

Future<void> openFile({
  required String filePath,
}) async {
  try {
    final openResult = await OpenFile.open(filePath);
    if (openResult.type == ResultType.done) {
      return;
    } else if (openResult.type == ResultType.noAppToOpen) {
      showGenericDialog(
        iconPath: 'assets/lotties/server_error_animation.json',
        title: 'No App',
        content: 'You don\'t have any app to open the file',
        buttons: {'OK': null},
      );
    } else {
      showGenericDialog(
        iconPath: 'assets/lotties/server_error_animation.json',
        title: 'Something Went Wrong',
        content:
            'Something went wrong while opening the file. Make sure the file is not deleted',
        buttons: {'Dismiss': null},
      );
    }
  } catch (e) {
    showGenericDialog(
      iconPath: 'assets/lotties/server_error_animation.json',
      title: 'Something Went Wrong',
      content: 'Something went wrong while opening the file',
      buttons: {'Dismiss': null},
    );
  }
}
