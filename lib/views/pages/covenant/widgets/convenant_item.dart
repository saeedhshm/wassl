import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/models/covenant/covenant.dart';

class CovenantItemWidget extends StatelessWidget {

  final Covenant covenant;
  const CovenantItemWidget({Key? key,required this.covenant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text('coven_name'.tr,style: const TextStyle(
                    // color: Colors.red
                  ),),
                ),
                const Text(':'),
                const SizedBox(width: 5,),
                Expanded( flex: 6,child: Text(covenant.name ?? '')),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text('coven_type'.tr,style: const TextStyle(
                    // color: Colors.red
                  ),),
                ),
                const Text(':'),
                const SizedBox(width: 5,),
                Expanded( flex: 6,child: Text(covenant.type ?? '')),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text('status'.tr,style: const TextStyle(
                    // color: Colors.red
                  ),),
                ),
                const Text(':'),
                const SizedBox(width: 5,),
                Expanded( flex: 6,child: Text(covenant.status ?? '')),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text('received_date'.tr,style: const TextStyle(
                    // color: Colors.red
                  ),),
                ),
                const Text(':'),
                const SizedBox(width: 5,),
                Expanded( flex: 6,child: Text(covenant.receivedDate ?? '')),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text('eviction_date'.tr,style: const TextStyle(
                    // color: Colors.red
                  ),),
                ),
                const Text(':'),
                const SizedBox(width: 5,),
                Expanded( flex: 6,child: Text(covenant.evictionDate ?? '')),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text('description'.tr,style: const TextStyle(
                    // color: Colors.red
                  ),),
                ),
                const Text(':'),
                const SizedBox(width: 5,),
                Expanded( flex: 6,child: Text(covenant.description ?? '')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
