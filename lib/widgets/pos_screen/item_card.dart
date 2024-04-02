import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:mobile_pos/controllers/cart_controller.dart';
import 'package:mobile_pos/controllers/pos_controller.dart';
import 'package:mobile_pos/models/product_model.dart';
import 'package:mobile_pos/utils/colors.dart';

class ItemCard extends StatefulWidget {
  const ItemCard(this.product);
  final ProductModel product;
  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  int _counterInit = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      return Card(
        elevation: 5.0,
        color: Colors.black,
        child: GridTile(
          header: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: 50,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(
                        "https://retail.sabsoft.com.pk/assets/images/products/${widget.product.image}"),
                  ),
                ),
              ),
            ),
          ),
          footer: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                  child: Text(
                    widget.product.name.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "PKR. ${widget.product.price}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                    CartStepperInt(
                      size: 24,
                      style: CartStepperStyle(
                        radius: const Radius.circular(5),
                        foregroundColor: AppColors.primary,
                        activeForegroundColor: Colors.white,
                        activeBackgroundColor: AppColors.primary,
                        buttonAspectRatio: 0.8,
                      ),
                      elevation: 5,
                      value: _counterInit,
                      didChangeCount: (count) {
                        setState(() {
                          _counterInit = count;
                          controller.addItem(_counterInit, widget.product);
                        });
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: AppColors.primary,
                width: 0.5,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
      );
    });
  }
}
