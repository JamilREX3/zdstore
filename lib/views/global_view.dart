import 'dart:ui';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:zdstore/components/custom_text.dart';
import 'package:zdstore/controllers/global_controller.dart';
import 'package:zdstore/views/banks_view.dart';
import 'package:zdstore/views/agents_view.dart';
import 'package:zdstore/views/notifications_log_view/notifications_log_view.dart';
import 'package:zdstore/views/profile_view.dart';
import 'package:zdstore/views/settings_view.dart';
import '../models/user_model.dart';

class GlobalView extends StatelessWidget {
  final UserModel userModel;
  const GlobalView({super.key, required this.userModel});
  @override
  Widget build(BuildContext context) {
    Get.put(GlobalController(userModel));
    return GetBuilder<GlobalController>(
      didUpdateWidget: (k,p){
        print('************ didUpdateWidget');
      },
      didChangeDependencies: (j){
        print('************ didChangeDependencies');
      },
      initState: (_){
        print('*******************');
      },




      builder: (controller) => ZoomDrawer(
        //menuScreenOverlayColor: Colors.green,

        borderRadius: 24.0,
        showShadow: true,
        angle: 0.0,
        drawerShadowsBackgroundColor: Colors.grey.shade300,
        slideWidth: Get.width * 0.65,
        menuScreenWidth: Get.width,
        controller: controller.zoomDrawerController,
        isRtl: Get.locale!.languageCode == 'ar' ? true : false,
        mainScreenScale: 0.24,
        menuBackgroundColor: Theme.of(context).colorScheme.background,
        mainScreenTapClose: true,
        androidCloseOnBackTap: true,
        menuScreen: Material(
          child: Container(
            width: Get.width*2,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://www.freecodecamp.org/news/content/images/2022/09/jonatan-pie-3l3RwQdHRHg-unsplash.jpg'),
                    fit: BoxFit.cover)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24,sigmaY: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  // BlurryContainer(
                  //   blur: 5,
                  //   elevation: 0,
                  //   color: Colors.grey.withOpacity(0.08),
                  //    padding: const EdgeInsets.all(0),
                  //   borderRadius: const BorderRadius.all(Radius.circular(20)),
                  //   child: ListTile(
                  //   textColor: Colors.black.withOpacity(0.08),
                  //   leading: const CircleAvatar(
                  //     backgroundColor: Colors.black12,
                  //     child: Icon(Icons.shopping_cart_outlined,color: Colors.white),
                  //   ),
                  //   title: const CustomText('Orders',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: 1),),
                  //   //trailing: Icon(Icons.arrow_right,color: Colors.white,),
                  // ),),
                  // SizedBox(height: 16),
                  InkWell(
                    onTap: (){
                      Get.to(const AgentsView());
                    },
                    child: BlurryContainer(
                      blur: 5,
                      elevation: 0,
                      color: Colors.grey.withOpacity(0.08),
                       padding: const EdgeInsets.all(0),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: ListTile(
                      textColor: Colors.black.withOpacity(0.08),
                      leading: const CircleAvatar(
                        backgroundColor: Colors.black12,
                        child: Icon(Icons.support_agent_rounded,color: Colors.white),
                      ),
                      title: const CustomText('Agents',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: 1),),
                      //trailing: Icon(Icons.arrow_right,color: Colors.white,),
                    ),),
                  ),
                  const SizedBox(height: 16),


                  InkWell(
                    onTap: (){
                      Get.to(const BankView());
                    },
                    child: BlurryContainer(
                      blur: 5,
                      elevation: 0,
                      color: Colors.grey.withOpacity(0.08),
                      padding: const EdgeInsets.all(0),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: ListTile(
                        textColor: Colors.black.withOpacity(0.08),
                        leading: const CircleAvatar(
                          backgroundColor: Colors.black12,
                          child: Icon(Icons.add_card_rounded,color: Colors.white),
                        ),
                        title: const CustomText('Add credit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: 1),),
                        //trailing: Icon(Icons.arrow_right,color: Colors.white,),
                      ),),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: (){
                      Get.to(const ProfileView());
                    },
                    child: BlurryContainer(
                      blur: 5,
                      elevation: 0,
                      color: Colors.grey.withOpacity(0.08),
                      padding: const EdgeInsets.all(0),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: ListTile(
                        textColor: Colors.black.withOpacity(0.08),
                        leading: const CircleAvatar(
                          backgroundColor: Colors.black12,
                          child: Icon(Icons.person,color: Colors.white),
                        ),
                        title: const CustomText('Profile',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: 1),),
                        //trailing: Icon(Icons.arrow_right,color: Colors.white,),
                      ),),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: (){
                      Get.to(const SettingsView());
                    },
                    child: BlurryContainer(
                      blur: 5,
                      elevation: 0,
                      color: Colors.grey.withOpacity(0.08),
                      padding: const EdgeInsets.all(0),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: ListTile(
                        textColor: Colors.black.withOpacity(0.08),
                        leading: const CircleAvatar(
                          backgroundColor: Colors.black12,
                          child: Icon(Icons.settings,color: Colors.white),
                        ),
                        title: const CustomText('Settings',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: 1),),
                        //trailing: Icon(Icons.arrow_right,color: Colors.white,),
                      ),),
                  ),
                  const SizedBox(height: 10,),
                  Switch(value: context.isDarkMode, onChanged: (value){
                   if(value==false){
                     Get.changeThemeMode(ThemeMode.light);
                   }else{
                     Get.changeThemeMode(ThemeMode.dark);
                   }
                  }),

                ],
              ),
            ),
          ),
        ),
        mainScreen: Obx(
          () => Scaffold(
            extendBody: true,
            appBar: AppBar(
              //backgroundColor: Colors.transparent,
              forceMaterialTransparency: true,
              centerTitle: true,
              title: CustomText(controller.title.value),
              leading: IconButton(
                onPressed: () {
                  // controller.zoomDrawerController.open;
                  controller.zoomDrawerController.toggle!.call();
                },
                icon: const Icon(Icons.menu_rounded),
              ),
              actions: [
                IconButton(onPressed: (){
                  Get.to(const NotificationsLogView());
                }, icon: const Icon(Icons.notifications_rounded))
              ],
            ),
            bottomNavigationBar: CurvedNavigationBar(
              index: controller.index.value,
              items: [
                Icon(
                  Icons.home,
                  color: controller.index.value == 0
                      ? Get.theme.bottomNavigationBarTheme.backgroundColor
                      : Get.theme.bottomNavigationBarTheme.unselectedItemColor,
                ),
                Icon(Icons.account_balance_wallet_rounded,
                    color: controller.index.value == 1
                        ? Get.theme.bottomNavigationBarTheme.backgroundColor
                        : Get.theme.bottomNavigationBarTheme
                            .unselectedItemColor),


                Icon(Icons.favorite_outlined,
                    color: controller.index.value == 2
                        ? Get.theme.bottomNavigationBarTheme.backgroundColor
                        : Get.theme.bottomNavigationBarTheme
                            .unselectedItemColor),



                Icon(Icons.shopping_cart_rounded,
                    color: controller.index.value == 3
                        ? Get.theme.bottomNavigationBarTheme.backgroundColor
                        : Get.theme.bottomNavigationBarTheme
                            .unselectedItemColor),
                Icon(Icons.search_rounded,
                    color: controller.index.value == 4
                        ? Get.theme.bottomNavigationBarTheme.backgroundColor
                        : Get.theme.bottomNavigationBarTheme
                            .unselectedItemColor),
              ],
              backgroundColor: Colors.transparent,
              //color:Get.find<MyThemeController>().isDarkMode.value==true?Get.find<MyThemeController>().darkThemeData.bottomNavigationBarTheme.backgroundColor!:Get.find<MyThemeController>().lightThemeData.bottomNavigationBarTheme.backgroundColor!,
              color: Get.theme.bottomNavigationBarTheme.backgroundColor!,
              //buttonBackgroundColor:Get.isDarkMode==true?Get.find<MyThemeController>().darkThemeData.bottomNavigationBarTheme.selectedItemColor!:Get.find<MyThemeController>().lightThemeData.bottomNavigationBarTheme.selectedItemColor!,
              buttonBackgroundColor:
                  Get.theme.bottomNavigationBarTheme.selectedItemColor,
              //  Colors.amber,
              onTap: (value) {
                // refreshnfor all
                controller.changeIndex(value);
                controller.navBarTrigger(refresh: true);
               // controller.navBarTrigger(value: value);
              },
            ),
            body: SafeArea(
                bottom: false,
                child: Obx(() => controller.screens[controller.index.value])),
          ),
        ),
      ),
    );
  }
}
