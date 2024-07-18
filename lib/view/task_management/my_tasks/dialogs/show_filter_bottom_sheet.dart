part of '../my_tasks_screen.dart';

Future<Object?> showFilterBottomSheet() async {
  return Get.bottomSheet(
    filterBottomSheet(),
  );
}

Widget filterBottomSheet() {
  return Container(
    height: 480,
    decoration: const BoxDecoration(
      color: Color.fromRGBO(29, 36, 41, 1),
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            child: Text(
              'Filter Task',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Container(
          width: double.maxFinite,
          height: 1,
          color: Colors.grey.withOpacity(.1),
        ),
        Expanded(
          child: Row(
            children: [
//--------------------Filter Key Part--------------------//
              Container(
                width: 120,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.15),
                ),
                child: Column(
                  children: [
                    filterItem(
                      title: 'Category',
                      isActive: true,
                    ),
                    const SizedBox(height: 6),
                    filterItem(
                      title: 'Assigned By',
                      isActive: false,
                    ),
                    const SizedBox(height: 6),
                    filterItem(
                      title: 'Frequency',
                      isActive: false,
                    ),
                    const SizedBox(height: 6),
                    filterItem(
                      title: 'Priority',
                      isActive: false,
                    ),
                  ],
                ),
              ),
//--------------------Filter Value Part--------------------//
            ],
          ),
        ),
      ],
    ),
  );
}

Widget filterItem({required String title, required bool isActive}) {
  return Container(
    width: double.maxFinite,
    height: 45,
    color: isActive ? Colors.grey.withOpacity(.15) : Colors.transparent,
    child: Row(
      children: [
        isActive
            ? Container(
                width: 15,
                height: double.maxFinite,
                color: AppColor.themeGreen,
              )
            : const SizedBox(),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
