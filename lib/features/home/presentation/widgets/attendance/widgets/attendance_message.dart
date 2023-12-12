// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wassl/features/home/presentation/manager/home_controller.dart';
//
// import '../../../../../../helpers/constants/app_colors.dart';
//
// class AttendanceLocationErrorMessageWidget extends StatelessWidget {
//   final String message;
//   final HomeController controller = Get.find();
//   AttendanceLocationErrorMessageWidget(this.message, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Row(
//           children: [
//             Text(message,
//                 style: const TextStyle(
//                     color: AppColors.darkGreyTextColor,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold)),
//             const Spacer(),
//             GestureDetector(
//               onTap: () async {
//                 controller.reEnableLocationServices();
//               },
//               child: Container(
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
//                   child:
//                       Text('enable'.tr, style: TextStyle(color: Colors.white)),
//                 ),
//                 decoration: BoxDecoration(
//                     color: AppColors.redMissedDayColor,
//                     borderRadius: BorderRadius.circular(8)),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
