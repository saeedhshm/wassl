import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wassl/getx_controllers/orders/order_details.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/views/consts_widgets/gradiants.dart';
import 'package:wassl/views/pages/orders/order_details/details/widgets/approve_diapprove.dart';
import 'package:wassl/views/pages/orders/order_details/details/widgets/country_region_widget.dart';
import 'package:wassl/views/pages/orders/order_details/details/widgets/date_widget.dart';
import 'package:wassl/views/pages/orders/order_details/details/widgets/directed_to.dart';
import 'package:wassl/views/pages/orders/order_details/details/widgets/emp_name.dart';
import 'package:wassl/views/pages/orders/order_details/details/widgets/holiday_duration.dart';
import 'package:wassl/views/pages/orders/order_details/details/widgets/order_time_widget.dart';
import 'package:wassl/views/pages/orders/order_details/details/widgets/order_type_widget.dart';
import 'package:wassl/views/pages/orders/order_details/details/widgets/reason_widget.dart';
import 'package:wassl/views/pages/orders/order_details/details/widgets/status_widget.dart';
import 'package:wassl/views/reusable_widgets/icons/calendar_icon.dart';
import 'package:wassl/views/reusable_widgets/icons/doc_icon.dart';
import 'package:wassl/web_services_helper/urls.dart';
import '../../../../../models/orders/holiday.dart';
import '../../../../consts_widgets/loading_widgets.dart';
import '../../../../reusable_widgets/icons/chat_icon.dart';
import '../../../../reusable_widgets/icons/status_icon.dart';

class OderDetailFragment extends StatelessWidget {

   OderDetailFragment({Key? key}) : super(key: key);
   final OrderDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
//first icon-- assets/images/profile/5.png
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: AppColors.mainBackgroundColor,
                child: Column(
                  children: [

                    EmployeeDetailsWidget(),

                    OrderTypeWidget(),

                    const SeparatorWidget(),

                    // status
                    StatusWidget(controller.order),
                    const SeparatorWidget(),

                    // order date
                    DateWidget(controller.order),
                    const SeparatorWidget(),

                    OrderTimeWidget(controller.order),

                    //

                    DirectedToWidget(controller.order),

                    CountryRegionWidget(controller.order),
                    // reason

                    ReasonWidget(controller.order),
                    const SeparatorWidget(),

                    SizedBox(height: (controller.order is HolidaysData) ? 50 : 10,),

                    HolidayDurationWidget(),

                    controller.order.file.isNotEmpty ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(onPressed: (){
                          launchUrlString('$appDomain/${controller.order.file.replaceAll('public', 'storage')}');
                        }, child: Row(

                          children: [
                            const Icon(Icons.download),
                            const SizedBox(width: 15,),
                            Text('download_file'.tr)
                          ],
                        )),
                      ],
                    ) :const SizedBox(),
                    controller.order.pdfUrl != null ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(onPressed: (){
                          launchUrlString('${controller.order.pdfUrl}');
                        }, child: Row(

                          children: [
                            const Icon(Icons.download),
                            const SizedBox(width: 15,),
                            Text('download_app_file'.tr)
                          ],
                        )),
                      ],
                    ) :const SizedBox()
                  ],
                ),

              ),
            ),
          ),
          ApproveDisapproveWidget()
        ],
      ),
    );
  }
}

class SeparatorWidget extends StatelessWidget {
  const SeparatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.maxFinite,
        height: 1,
        color: AppColors.borderTextFieldColor,
      ),
    );
  }
}
