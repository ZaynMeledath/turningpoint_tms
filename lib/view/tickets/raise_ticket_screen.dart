import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turningpoint_tms/controller/tickets_controller.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';
import 'package:turningpoint_tms/view/login/login_screen.dart';

class RaiseTicketScreen extends StatefulWidget {
  const RaiseTicketScreen({super.key});

  @override
  State<RaiseTicketScreen> createState() => _RaiseTicketScreenState();
}

class _RaiseTicketScreenState extends State<RaiseTicketScreen> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  final TicketsController ticketsController = TicketsController();

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    ticketsController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: myAppBar(
          title: 'Raise a Ticket',
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 25.h,
            ),
            child: Column(
              children: [
                customTextField(
                  controller: titleController,
                  hintText: 'Title',
                ),
                SizedBox(height: 20.h),
                customTextField(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 4,
                ),
                SizedBox(height: 28.w),
                customButton(
                  buttonTitle: 'Submit',
                  onTap: () async {
                    try {
                      await ticketsController.raiseTicket(
                        title: titleController.text.trim(),
                        description: descriptionController.text.trim(),
                      );
                      titleController.clear();
                      descriptionController.clear();
                      showGenericDialog(
                        iconPath: 'assets/lotties/success_animation.json',
                        title: 'Raised a Ticket',
                        content:
                            'Ticket has been raised and our team will be responding to it shortly',
                        buttons: {
                          'OK': null,
                        },
                      );
                    } catch (_) {
                      showGenericDialog(
                        iconPath: 'assets/lotties/server_error_animation.json',
                        title: 'Something went wrong',
                        content:
                            'Something went wrong while raising the ticket',
                        buttons: {
                          'Dismiss': null,
                        },
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  buttonPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 6.w,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
