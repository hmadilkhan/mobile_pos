import 'package:flutter/material.dart';
import 'package:mobile_pos/utils/colors.dart';
import 'package:mobile_pos/widgets/pos_screen/product_search_landscape.dart';
import 'package:mobile_pos/widgets/products_items_landscape.dart';

class ProductsLandscape extends StatefulWidget {
  const ProductsLandscape({super.key});

  @override
  State<ProductsLandscape> createState() => _ProductsLandscapeState();
}

class _ProductsLandscapeState extends State<ProductsLandscape> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      color: AppColors.charcoal,
      child: const Column(
        children: [
          ProductSearchLandscape(),
          ProductItemsLandscape(),
        ],
      ),
    );
  }
}

//   Padding ProductSearchLandscape(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(9.0),
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width * 0.6,
//         child: TextField(
//           // controller: search,
//           textAlign: TextAlign.left,
//           onChanged: (value) {
//             // print(value)
//             // controller.productSearch(value);
//           },
//           style: TextStyle(
//             color: AppColors.white,
//             fontSize: 12,
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.w400,
//           ),
//           decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
//               labelText: "Search Article or Code",
//               fillColor: AppColors.white,
//               filled: true,
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//                 borderSide: BorderSide(
//                   width: 1,
//                   color: AppColors.white,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//                 borderSide: BorderSide(
//                   width: 1,
//                   color: AppColors.primary,
//                 ),
//               ),
//               labelStyle: const TextStyle(
//                 color: Colors.grey,
//                 fontSize: 20,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w600,
//               ),
//               disabledBorder:
//                   const OutlineInputBorder(borderRadius: BorderRadius.zero)),
//         ),
//       ),
//     );
//   }
// }
