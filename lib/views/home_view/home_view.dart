import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zdstore/components/custom_text.dart';
import 'package:zdstore/controllers/home_controller.dart';
import 'package:zdstore/models/home_content_model.dart';
import 'package:zdstore/utils/enum_state.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:zdstore/views/auth_view.dart';

import 'package:zdstore/views/home_view/home_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});


  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      builder: (controller) =>
          Obx(() => controller.currentState.value == CurrentState.loading
              ? const Center(child: CircularProgressIndicator())
              :controller.currentState.value==CurrentState.full? SingleChildScrollView(
                  child: Column(
                    children: [
                      MasonryGridView.builder(
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
                          late String tag;
                          var temp =  controller.sortedContent[index];
                          if(temp is CategoryModel){
                            tag = temp.id.toString();
                          }else if(temp is ProductModel){
                            tag=temp.id.toString();
                          }
                          return HomeCard(sortable: controller.sortedContent[index]);
                        },
                      ),
                      const SizedBox(height: 100),
                      ElevatedButton(onPressed: ()async{
                        var language = GetStorage().read('language');
                        var isDarkMode = GetStorage().read('isDarkMode');
                        await GetStorage().erase();
                        await GetStorage().write('language' , language);
                        await GetStorage().write('isDarkMode' , isDarkMode);
                        Get.offAll(const AuthView());
                      }, child: const CustomText('Signup')),
                      ElevatedButton(onPressed: ()async{
                        var currentLang = Get.locale!.languageCode;
                        if(currentLang=='en'){
                          await GetStorage().write('language', 'ar');
                          Get.updateLocale(const Locale('ar'));
                        }else{
                          await GetStorage().write('language', 'en');
                          Get.updateLocale(const Locale('en'));
                        }
                      }, child: const CustomText('change language')),
                      const SizedBox(height: 100),
                    ],
                  ),
                ):controller.currentState.value==CurrentState.error?const Center(child: CustomText('Error'),):const SizedBox()),
    );
  }
}
