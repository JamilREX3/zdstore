import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zdstore/controllers/agents_controller.dart';
import 'package:zdstore/utils/enum_state.dart';

import '../components/custom_text.dart';

class AgentsView extends StatelessWidget {
  const AgentsView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Get.put(AgentsController());
    return GetBuilder<AgentsController>(
        initState: (_) {
          Get.find<AgentsController>().getAgentsList();
        },
        builder: (controller) => Scaffold(
              appBar: AppBar(
                forceMaterialTransparency: true,
                centerTitle: true,
                title: const CustomText('Agents'),
              ),
              body: Obx(
                  () {

                    CurrentState currentState = controller.currentState.value;


                    return currentState == CurrentState.loading
                        ? const Center(child: CircularProgressIndicator())
                        :currentState==CurrentState.full? ListView.builder(
                      itemCount: controller.agentsList.length,
                      itemBuilder: (context, index) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: Card(
                            child: ExpansionTile(
                              childrenPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              title: Row(
                                children: [
                                  CustomText(controller
                                      .agentsList[index].fullName
                                      .toString()),
                                ],
                              ),
                              subtitle: CustomText(
                                controller.agentsList[index].address
                                    .toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 1.5,foregroundColor: isDarkMode == true
                                            ? Colors.white70
                                            : Colors.black54),
                                        onPressed: () {
                                          controller.launchWhatsApp(phone: controller.agentsList[index].phone.toString());
                                        },
                                        child: const FaIcon(
                                          FontAwesomeIcons.whatsapp,
                                          color: Color(0xff25D366),
                                        )),
                                    const SizedBox(width: 30),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 1.5,foregroundColor: isDarkMode == true
                                            ? Colors.white70
                                            : Colors.black54),
                                        onPressed: () {
                                          controller.makeCall(phoneNumber: controller.agentsList[index].phone.toString());
                                        },
                                        child: const Icon(
                                          Icons.call,
                                          color: Colors.indigo,
                                          //color: Color(0xff25D366),
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(children: [
                                  const CustomText('Address'),
                                  const CustomText(' : '),
                                  CustomText(controller.agentsList[index].fullAddress.toString())
                                ],)
                              ],
                            ),
                          ),
                        );
                      },
                    ):currentState==CurrentState.error?Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText('Error'),
                          ElevatedButton(onPressed: (){
                            controller.init();
                          }, child: const CustomText('Try again'))
                        ],
                      ),
                    ):const SizedBox();
                  }),
            ));
  }
}
