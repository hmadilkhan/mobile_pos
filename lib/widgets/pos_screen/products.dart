import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_pos/controllers/pos_controller.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  var controller = PosController();
  // late final Future futureProducts = DatabaseHelper.getAllProducts();
  late final Future futureProducts = controller.getAllProducts();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PosController>(builder: (controller) {
      return Expanded(
        child:
            // FutureBuilder(
            //   future: futureProducts,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            // return
            Obx(
          () => (controller.listProduct.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemCount: controller.listProduct.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    // final product = snapshot.data?[index];
                    final product = controller.listProduct[index];
                    return GestureDetector(
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage.assetNetwork(
                            fadeInCurve: Curves.bounceIn,
                            placeholder: "assets/images/placeholder.png",
                            image:
                                "https://retail.sabsoft.com.pk/assets/images/products/${product.image}",
                          ),
                        ),
                        title: Text(
                          product.name.toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: "Poppins",
                          ),
                        ),
                        subtitle: Text(
                            product.description ?? "Description goes here"),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "PKR. ${product.price}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontFamily: "Poppins",
                              ),
                            ),
                            Text(
                              "1 ${product.unit}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.green,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        // print(controller.selectedIndex.value);
                      },
                    );
                  })),
        ),
        //     } else {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //   },
        // ),
      );
    });
  }
}
