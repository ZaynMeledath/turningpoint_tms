part of '../my_team_screen.dart';

Widget teamCard() {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: 14.w,
      vertical: 12.h,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(48, 78, 85, .4),
          Color.fromRGBO(29, 36, 41, 1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(
        color: Colors.grey.withOpacity(.3),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                nameLetterAvatar(
                  name: 'Zayn Meledath',
                  circleDiameter: 34,
                  backgroundColor: Colors.blue,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Zayn Meledath',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Admin',
                  style: TextStyle(
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(
              Icons.email,
              size: 16.sp,
              color: AppColor.themeGreen.withOpacity(.8),
            ),
            SizedBox(width: 6.w),
            Text(
              'zayn@turningpointvapi.com',
              style: TextStyle(
                fontSize: 14.5.sp,
                color: Colors.white60,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Icon(
              Icons.phone,
              size: 16.sp,
              color: AppColor.themeGreen.withOpacity(.8),
            ),
            SizedBox(width: 6.w),
            Text(
              '+91 8289899007',
              style: TextStyle(
                fontSize: 14.5.sp,
                color: Colors.white60,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Icon(
              Icons.manage_accounts_rounded,
              size: 16.sp,
              color: AppColor.themeGreen.withOpacity(.8),
            ),
            SizedBox(width: 6.w),
            Text(
              'Nilesh Gala',
              style: TextStyle(
                fontSize: 14.5.sp,
                color: Colors.white60,
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            teamCardActionButton(
              icon: Icons.edit,
              title: 'Edit',
              iconColor: Colors.blue,
              onTap: () {
                final userBox = Hive.box(AppConstants.appDb);
                final userModel = userBox.get(AppConstants.userModelStorageKey);
                print(userModel.toString());
              },
            ),
            SizedBox(width: 30.w),
            teamCardActionButton(
              icon: Icons.delete,
              title: 'Delete',
              iconColor: Colors.red,
              onTap: () {},
            ),
          ],
        ),
      ],
    ),
  );
}
