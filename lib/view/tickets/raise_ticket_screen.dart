import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  onTap: () {},
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
