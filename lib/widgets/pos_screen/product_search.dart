import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_pos/controllers/pos_controller.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();

    return GetBuilder<PosController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                controller: search,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  controller.productSearchText(search.text);
                },
                style: const TextStyle(
                  color: Color(0xFF393939),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    labelText: "Search Article or Code",
                    border: InputBorder.none,
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                    disabledBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.zero)),
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.barcode_reader,
                  color: Colors.grey,
                  size: 30,
                ),
                const Icon(
                  Icons.mic,
                  color: Colors.grey,
                  size: 30,
                ),
                GestureDetector(
                  onTap: () {
                    controller.changeDepartment("All");
                  },
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
