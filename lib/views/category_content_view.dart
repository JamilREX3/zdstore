import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:zdstore/constants/k_constants.dart';
import 'package:zdstore/controllers/categoey_content_controller.dart';
import 'package:zdstore/models/home_content_model.dart';

import '../components/custom_text.dart';
import '../utils/enum_state.dart';
import 'home_view/home_card.dart';


class CategoryContentView extends StatelessWidget {


  final CategoryModel category;
  const CategoryContentView({super.key ,required this.category});

  @override
  Widget build(BuildContext context) {
    Get.put(CategoryContentController());
    return  GetBuilder<CategoryContentController>(
        initState: (_){
          Get.find<CategoryContentController>().getCategoryContent(category.id.toString());
        },
        builder: (controller)=>Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            centerTitle: true,
            title: CustomText(category.name.toString()),
          ),
          body:  SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(tag: category.id.toString(),child: Padding(padding: const EdgeInsets.symmetric(horizontal: 6),child: ClipRRect(borderRadius: BorderRadius.circular(10),child: CachedNetworkImage(imageUrl: KConstants.imageBaseUrl+category.photo.toString())))),
                const SizedBox(height: 10),
                Obx(() => controller.currentState.value==CurrentState.loading? Column(
                  children: [
                    SizedBox(height: Get.height*0.2),
                    const CircularProgressIndicator(),
                  ],
                ):MasonryGridView.builder(

                  gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:controller.sortedContent.length,
                  itemBuilder: (context, index) {
                    return HomeCard(sortable: controller.sortedContent[index]);
                  },
                ),),
                const SizedBox(height: 100),
              ],
            ),
          ),
    ));
  }
}
