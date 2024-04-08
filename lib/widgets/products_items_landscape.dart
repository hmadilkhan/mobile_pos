import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_pos/controllers/pos_controller.dart';
import 'package:mobile_pos/utils/colors.dart';
import 'package:mobile_pos/widgets/pos_screen/item_card.dart';
import 'package:window_manager/window_manager.dart';

class ProductItemsLandscape extends StatefulWidget {
  const ProductItemsLandscape({super.key});

  @override
  State<ProductItemsLandscape> createState() => _ProductItemsLandscapeState();
}

class _ProductItemsLandscapeState extends State<ProductItemsLandscape> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PosController>(builder: (controller) {
      return Expanded(
        child: Obx(
          () => (controller.listProduct.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                  return ItemCardWidget(
                      screensize: constraints.maxWidth, controller: controller);
                })),
        ),
      );
    });
  }
}

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({
    super.key,
    required this.screensize,
    required this.controller,
  });

  final double screensize;
  final PosController controller;

  @override
  Widget build(BuildContext context) {
    var size = 6;
    print(screensize);
    if (screensize < 600) {
      size = 3;
    } else if (screensize > 600 && screensize < 900) {
      size = 4;
    } else if (screensize > 900 && screensize < 1100) {
      size = 5;
    } else if (screensize > 1100 && screensize < 2000) {
      size = 6;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          itemCount: controller.listProduct.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: size, //(Platform.isWindows ? size : 4),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemBuilder: (BuildContext context, int index) {
            final product = controller.listProduct[index];
            return ItemCard(product);
          }),
    );
  }
}
