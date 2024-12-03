part of '../my_team_screen.dart';

Future<Object?> showAddTeamMemberBottomSheet({
  AllUsersModel? userModel,
}) {
  return Get.bottomSheet(
    isScrollControlled: true,
    // isDismissible: false,
    AddTeamMemberBottomSheet(
      userModel: userModel,
    ),
  );
}

class AddTeamMemberBottomSheet extends StatefulWidget {
  final AllUsersModel? userModel;
  const AddTeamMemberBottomSheet({
    this.userModel,
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
    userController.departmentObs.value = null;
    userController.reportingManagerObs.value = null;

    if (widget.userModel != null) {
      final userModel = widget.userModel!;
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
    final user = getUserModelFromHive();
    return SingleChildScrollView(
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
                    widget.userModel != null ? 'Update Member' : 'Add to Team',
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
                        user != null && user.role == Role.admin
                            ? Column(
                                children: [
                                  departmentDropDown(
                                    tasksController: tasksController,
                                    userController: userController,
                                  ).animate().slideY(
                                        begin: .7,
                                        delay:
                                            const Duration(milliseconds: 220),
                                        curve: Curves.elasticOut,
                                        duration:
                                            const Duration(milliseconds: 1000),
                                      ),
                                  SizedBox(height: 22.h),
                                  roleDropDown(userController: userController)
                                      .animate()
                                      .slideY(
                                        begin: .7,
                                        delay:
                                            const Duration(milliseconds: 260),
                                        curve: Curves.elasticOut,
                                        duration:
                                            const Duration(milliseconds: 1000),
                                      ),
                                  SizedBox(height: 22.h),
                                  reportingManagerDropDown(
                                          userController: userController)
                                      .animate()
                                      .slideY(
                                        begin: .7,
                                        delay:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.elasticOut,
                                        duration:
                                            const Duration(milliseconds: 1000),
                                      ),
                                  SizedBox(height: 22.h),
                                ],
                              )
                            : const SizedBox(),
                        widget.userModel == null || user?.role == Role.admin
                            ? customTextField(
                                controller: passwordController,
                                hintText: 'Password',
                                userController: userController,
                                isPassword: true,
                                ignoreValidations: widget.userModel != null,
                              ).animate().slideY(
                                  begin: .7,
                                  delay: const Duration(milliseconds: 340),
                                  curve: Curves.elasticOut,
                                  duration: const Duration(milliseconds: 1000),
                                )
                            : const SizedBox(),
                        SizedBox(height: 26.h),
                        Obx(
                          () => InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async {
                              appController.isLoadingObs.value = true;
                              await onSubmit(
                                userController: userController,
                                formKey: _formKey,
                                nameController: nameController,
                                phoneController: phoneController,
                                emailController: emailController,
                                passwordController: passwordController,
                                user: user!,
                                allUsersModel: widget.userModel,
                              );
                              appController.isLoadingObs.value = false;
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
                                  child: appController.isLoadingObs.value
                                      ? SpinKitWave(
                                          color: Colors.white,
                                          size: 16.w,
                                        )
                                      : Text(
                                          widget.userModel != null
                                              ? 'Submit'
                                              : 'Add to Team',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                          ),
                                        )),
                            ).animate().scale(
                                  delay: const Duration(milliseconds: 360),
                                  curve: Curves.elasticOut,
                                  duration: const Duration(milliseconds: 1000),
                                ),
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
    );
  }
}

Future<void> onSubmit({
  required UserController userController,
  required GlobalKey<FormState> formKey,
  required TextEditingController nameController,
  required TextEditingController phoneController,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required UserModel user,
  AllUsersModel? allUsersModel,
}) async {
  try {
    final user = getUserModelFromHive();
    if (formKey.currentState!.validate()) {
      if (user!.role != Role.teamLeader) {
        if (userController.departmentObs.value == null ||
            userController.roleObs.value == null ||
            userController.reportingManagerObs.value == null) {
          showGenericDialog(
            iconPath: 'assets/lotties/fill_details_animation.json',
            title: 'Fill Details',
            content: 'User details cannot be blank',
            buttons: {'Dismiss': null},
          );
          return;
        }
      }

      if (allUsersModel != null) {
        allUsersModel.userName = nameController.text.trim();
        allUsersModel.phone = phoneController.text.trim();
        allUsersModel.emailId = emailController.text.trim().toLowerCase();
        allUsersModel.department =
            userController.departmentObs.value ?? user.department;
        allUsersModel.role = userController.roleObs.value ?? Role.user;
        allUsersModel.reportingTo =
            userController.reportingManagerObs.value ?? user.name;
        allUsersModel.password = passwordController.text;
        await userController.updateTeamMember(userModel: allUsersModel);
        Get.back();

        showGenericDialog(
          iconPath: 'assets/lotties/success_animation.json',
          title: 'Member Updated',
          content: 'Team member details has bee successfully updated',
          buttons: {'OK': null},
        );
      } else {
        final userModel = AllUsersModel(
          userName: nameController.text.trim(),
          phone: phoneController.text.trim(),
          emailId: emailController.text.trim().toLowerCase(),
          department: userController.departmentObs.value ?? user.department,
          role: userController.roleObs.value ?? Role.user,
          reportingTo: userController.reportingManagerObs.value ?? user.name,
          password: passwordController.text,
        );
        await userController.addTeamMember(userModel: userModel);
        Get.back();

        showGenericDialog(
          iconPath: 'assets/lotties/success_animation.json',
          title: 'Team Member Added',
          content: 'New team member has been successfully added',
          buttons: {'OK': null},
        );
      }
    }
  } catch (_) {
    showGenericDialog(
      iconPath: 'assets/lotties/server_error_animation.json',
      title: 'Something went wrong',
      content: 'Something went wrong while adding the user',
      buttons: {'Dismiss': null},
    );
    return;
  }
}
