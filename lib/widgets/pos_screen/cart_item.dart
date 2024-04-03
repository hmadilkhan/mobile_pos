import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_pos/controllers/cart_controller.dart';
import 'package:mobile_pos/models/cart_modal.dart';
import 'package:mobile_pos/utils/colors.dart';

class CartItem extends StatefulWidget {
  const CartItem(this.product, {super.key});
  final Cart product;
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int _counterInit = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _counterInit = int.tryParse(widget.product.qty ?? "")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      return GestureDetector(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.primary,
            radius: 30,
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                  "https://retail.sabsoft.com.pk/assets/images/products/${widget.product.image}"),
            ),
          ),
          title: Text(
            widget.product.name.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: "Poppins",
            ),
          ),
          subtitle: Text(
            "${widget.product.price} x ${widget.product.qty}",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              fontFamily: "Poppins",
            ),
          ),
          trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "PKR. ${widget.product.totalamount}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: "Poppins",
                  ),
                ),
                CartStepperInt(
                  size: 25,
                  style: CartStepperStyle(
                    radius: const Radius.circular(5),
                    foregroundColor: AppColors.primary,
                    activeForegroundColor: Colors.white,
                    activeBackgroundColor: AppColors.primary,
                    buttonAspectRatio: 0.8,
                  ),
                  alwaysExpanded: true,
                  elevation: 5,
                  value: _counterInit,
                  didChangeCount: (count) {
                    setState(() {
                      _counterInit = count;
                      controller.addItem(_counterInit, widget.product, "cart");
                    });
                  },
                ),
              ]),
        ),
        onTap: () {},
      );
    });
  }
}
