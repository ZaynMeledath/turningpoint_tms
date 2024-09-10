part of '../my_team_screen.dart';

Future<Object?> showAddTeamMemberBottomSheet({
  AllUsersModel? userModel,
}) {
  return Get.bottomSheet(
    isScrollControlled: true,
    isDismissible: false,
    const AddTeamMemberBottomSheet(),
  );
}

class AddTeamMemberBottomSheet extends StatefulWidget {
  final AllUsersModel? teamModel;
  const AddTeamMemberBottomSheet({
    this.teamModel,
    super.key,
  });

  @override
  State<AddTeamMemberBottomSheet> createState() =>
      AddTeamMemberBottomSheetState();
}

class AddTeamMemberBottomSheetState extends State<AddTeamMemberBottomSheet> {
  final tasksController = Get.put(TasksController());
  final appController = Get.put(AppController());
  final userController = Get.put(UserController());
  final GlobalKey<FormState> _formKey = GlobalKey();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  Color? taskStatusColor;

  @override
  void initState() {
    userController.roleObs.value = null;
    userController.reportingManagerObs.value = null;

    if (widget.teamModel != null) {
      final userModel = widget.teamModel!;
      nameController.text = userModel.userName ?? '';
      phoneController.text = userModel.phone ?? '';
      emailController.text = userModel.emailId ?? '';
      userController.departmentObs.value = userModel.department;
      userController.roleObs.value = userModel.role;
      userController.reportingManagerObs.value = userModel.reportingTo;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        reverse: true,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Material(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            color: AppColors.scaffoldBackgroundColor,
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //====================Title====================//
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 14.h,
                    ),
                    child: Text(
                      'Add to Team',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 1,
                    color: Colors.white12,
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          customTextField(
                            controller: nameController,
                            hintText: 'Name',
                          ).animate().slideY(
                                begin: .7,
                                delay: const Duration(milliseconds: 100),
                                curve: Curves.elasticOut,
                                duration: const Duration(milliseconds: 1000),
                              ),
                          SizedBox(height: 22.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.textFieldColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(
                                    '+91',
                                    style: GoogleFonts.roboto(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: customTextField(
                                  controller: phoneController,
                                  hintText: 'WhatsApp Number',
                                  // userController: userController,
                                  isNum: true,
                                ),
                              ),
                            ],
                          ).animate().slideY(
                                begin: .7,
                                delay: const Duration(milliseconds: 140),
                                curve: Curves.elasticOut,
                                duration: const Duration(milliseconds: 1000),
                              ),
                          SizedBox(height: 22.h),
                          customTextField(
                            controller: emailController,
                            hintText: 'Email',
                            isEmail: true,
                          ).animate().slideY(
                                begin: .7,
                                delay: const Duration(milliseconds: 180),
                                curve: Curves.elasticOut,
                                duration: const Duration(milliseconds: 1000),
                              ),
                          SizedBox(height: 22.h),
                          departmentDropDown(
                            tasksController: tasksController,
                            userController: userController,
                          ).animate().slideY(
                                begin: .7,
                                delay: const Duration(milliseconds: 220),
                                curve: Curves.elasticOut,
                                duration: const Duration(milliseconds: 1000),
                              ),
                          SizedBox(height: 22.h),
                          roleDropDown(userController: userController)
                              .animate()
                              .slideY(
                                begin: .7,
                                delay: const Duration(milliseconds: 260),
                                curve: Curves.elasticOut,
                                duration: const Duration(milliseconds: 1000),
                              ),
                          SizedBox(height: 22.h),
                          reportingManagerDropDown(
                                  userController: userController)
                              .animate()
                              .slideY(
                                begin: .7,
                                delay: const Duration(milliseconds: 300),
                                curve: Curves.elasticOut,
                                duration: const Duration(milliseconds: 1000),
                              ),
                          SizedBox(height: 22.h),
                          customTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            userController: userController,
                            isPassword: true,
                          ).animate().slideY(
                                begin: .7,
                                delay: const Duration(milliseconds: 340),
                                curve: Curves.elasticOut,
                                duration: const Duration(milliseconds: 1000),
                              ),
                          SizedBox(height: 26.h),
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                if (userController.departmentObs.value ==
                                        null ||
                                    userController.roleObs.value == null ||
                                    userController.reportingManagerObs.value ==
                                        null) {
                                  showGenericDialog(
                                    iconPath:
                                        'assets/lotties/fill_details_animation.json',
                                    title: 'Fill Details',
                                    content: 'User details cannot be blank',
                                    buttons: {'Dismiss': null},
                                  );
                                  return;
                                }

                                try {
                                  final userModel = AllUsersModel(
                                    userName: nameController.text.trim(),
                                    phone: phoneController.text.trim(),
                                    emailId: emailController.text.trim(),
                                    department:
                                        userController.departmentObs.value,
                                    role: userController.roleObs.value,
                                    reportingTo: userController
                                        .reportingManagerObs.value,
                                    password: passwordController.text.trim(),
                                  );
                                  await userController.addTeamMember(
                                      userModel: userModel);
                                } catch (_) {
                                  showGenericDialog(
                                    iconPath:
                                        'assets/lotties/server_error_animation.json',
                                    title: 'Something went wrong',
                                    content:
                                        'Something went wrong while adding the user',
                                    buttons: {'Dismiss': null},
                                  );
                                }
                              }
                            },
                            child: Container(
                              width: 140.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.themeGreen.withOpacity(.7),
                                border: Border.all(
                                  color: AppColors.themeGreen,
                                  width: 1.7,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  widget.teamModel != null
                                      ? 'Submit'
                                      : 'Add to Team',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ).animate().scale(
                                  delay: const Duration(milliseconds: 360),
                                  curve: Curves.elasticOut,
                                  duration: const Duration(milliseconds: 1000),
                                ),
                          ),
                          SizedBox(height: 18.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
