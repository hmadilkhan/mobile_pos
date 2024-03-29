import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_pos/controllers/pos_controller.dart';
import 'package:mobile_pos/utils/colors.dart';

class ProductSearchLandscape extends StatefulWidget {
  const ProductSearchLandscape({super.key});

  @override
  State<ProductSearchLandscape> createState() => _ProductSearchLandscapeState();
}

class _ProductSearchLandscapeState extends State<ProductSearchLandscape> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PosController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.all(14.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextField(
            controller: search,
            textAlign: TextAlign.left,
            onChanged: (value) {
              controller.productSearch(value);
            },
            style: TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                labelText: "Search Article or Code",
                fillColor: AppColors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    width: 1,
                    color: AppColors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    width: 1,
                    color: AppColors.primary,
                  ),
                ),
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
                disabledBorder:
                    const OutlineInputBorder(borderRadius: BorderRadius.zero)),
          ),
        ),
      );
    });
  }
}
