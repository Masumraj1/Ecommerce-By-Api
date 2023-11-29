import 'package:alorferi_app_practice/controller/crud_my_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/add_to_card_controller.dart';

class ProductGridView extends StatelessWidget {
  final Map<String, dynamic> product;
  final AddToCartController? addToCartController;

  ProductGridView({required this.product, this.addToCartController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: product["url"] == null
                  ? Image.network("https://demo.alorferi.com/images/blank_product_picture.png")
                  : Image.network("https://demo.alorferi.com${product["url"]}"),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 19,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("   ${product["name"]}",
                        style: TextStyle(fontWeight: FontWeight.w900),maxLines: 1,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("৳ ${product["price"]}"),
                      Text("In Stock: ${product['stock_quantity']}")
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        if (addToCartController != null) {
                          addToCartController!.addToCart(product);
                        } else {
                          // permision to edit my pruduct
                        }

                        // Show a snackbar to indicate that the product has been added to the cart
                        ScaffoldMessenger.of(context).showSnackBar(
                            addToCartController != null
                                ? SnackBar(
                                    content:
                                        Text('Product added to cart successful'))
                                : SnackBar(content: Text("you can edit")));
                      },
                      child: SizedBox(
                        height: 50,
                          width: 90,
                          child: Image.asset("assets/add_to_card.png")))

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
