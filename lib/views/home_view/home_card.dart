import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zdstore/components/custom_text.dart';
import 'package:zdstore/constants/k_constants.dart';
import 'package:zdstore/models/home_content_model.dart';
import 'package:zdstore/views/category_content_view.dart';
import 'package:zdstore/views/make_order_view.dart';

class HomeCard extends StatelessWidget {
  final Sortable sortable;

  const HomeCard({super.key, required this.sortable});

  @override
  Widget build(BuildContext context) {
    ProductModel? product;
    CategoryModel? category;

    if (sortable is ProductModel) {
      product = sortable as ProductModel;
    } else {
      category = sortable as CategoryModel;
    }
    return GestureDetector(
      onTap: () {
        if (product != null && product.available == true) {
          Get.to(MakeOrderView(product: product));
        } else if (category != null) {
          //Get.to(CategoryContentView(category: category),transition: Transition.downToUp,curve: Curves.bounceOut);
          Get.to(CategoryContentView(category: category));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Hero(
              tag: product==null?category!.id.toString():product.id.toString(),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: product?.available == false
                      ? CachedNetworkImage(
                          imageUrl:
                              '${KConstants.imageBaseUrl}${category != null ? category.photo : product != null && product.photo != null && product.photo != 'null' ? product.photo : product!.categoryPhoto}',
                          color: Colors.grey.shade600.withOpacity(0.8),
                          colorBlendMode: BlendMode.modulate,
                        )
                      : CachedNetworkImage(
                          imageUrl:
                              '${KConstants.imageBaseUrl}${category != null ? category.photo : product != null && product.photo != null && product.photo != 'null' ? product.photo : product!.categoryPhoto}',
                        )),
            ),
            const SizedBox(height: 3),
            product?.available == false
                ? CustomText(
                    product != null ? product.productName! : category!.name!,
                    style: const TextStyle(color: Colors.grey),
                  )
                : CustomText(
                    product != null ? product.productName! : category!.name!),
          ],
        ),
      ),
    );
  }
}
