part of '../my_team_screen.dart';

Future<Object?> showAddTeamMemberBottomSheet({
  AllUsersModel? teamModel,
}) {
  return Get.bottomSheet(
    isScrollControlled: true,
    isDismissible: false,
    const AddTeamMemberBottomSheet(),
  );
}

class AddTeamMemberBottomSheet extends StatefulWidget {
  const AddTeamMemberBottomSheet({
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
    return SingleChildScrollView(
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
                      fontSize: 22.sp,
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
                        roleDropDown(userController: userController)
                            .animate()
                            .slideY(
                              begin: .7,
                              delay: const Duration(milliseconds: 220),
                              curve: Curves.elasticOut,
                              duration: const Duration(milliseconds: 1000),
                            ),
                        SizedBox(height: 22.h),
                        reportingManagerDropDown(userController: userController)
                            .animate()
                            .slideY(
                              begin: .7,
                              delay: const Duration(milliseconds: 260),
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
                              delay: const Duration(milliseconds: 300),
                              curve: Curves.elasticOut,
                              duration: const Duration(milliseconds: 1000),
                            ),
                        SizedBox(height: 26.h),
                        Container(
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
                              'Add Member',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ).animate().scale(
                              delay: const Duration(milliseconds: 320),
                              curve: Curves.elasticOut,
                              duration: const Duration(milliseconds: 1000),
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
