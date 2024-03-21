
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zdstore/models/order_details_model.dart';

import '../../components/custom_text.dart';
import '../../constants/k_constants.dart';
import '../../controllers/global_controller.dart';


class OrderDetailsObjections extends StatelessWidget {


  final OrderDetailsModel orderDetailsModel;
  const OrderDetailsObjections({super.key , required this.orderDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            CustomText(
              'Objections',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        ...orderDetailsModel.objection!
            .map((e) => Column(
          children: [
            e.replay != null
                ? InkWell(
              onTap: () async {
                await Clipboard.setData(
                    ClipboardData(
                        text: e
                            .replay!));
                Get.showSnackbar(
                  GetSnackBar(
                    message:
                    'Copied to clipboard'
                        .tr,
                    duration:
                    const Duration(
                        seconds:
                        2),
                  ),
                );
              },
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment
                    .end,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        shape: BoxShape
                            .circle,
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(Get.find<GlobalController>()
                                .userModel
                                .value
                                .avatar
                                .toString()))),
                  ),
                  Container(
                    padding: const EdgeInsets
                        .symmetric(
                        vertical:
                        10,
                        horizontal:
                        20),
                    margin: const EdgeInsets
                        .symmetric(
                        horizontal:
                        3,
                        vertical:
                        0),
                    decoration:
                    BoxDecoration(
                      borderRadius:
                      BorderRadius
                          .circular(
                          10),
                      gradient:
                      LinearGradient(
                        colors: [
                          Colors
                              .blue
                              .shade700,
                          Colors
                              .blue
                              .shade300
                        ],
                        begin: Alignment
                            .topLeft,
                        end: Alignment
                            .bottomRight,
                      ),
                    ),
                    child: SizedBox(
                      width:
                      Get.width *
                          0.6,
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Expanded(
                              child:
                              CustomText(
                                e.replay!,
                                style: const TextStyle(
                                    color:
                                    Colors.white),
                                maxLines:
                                5,
                                overflow:
                                TextOverflow.ellipsis,
                              )),
                          const Icon(
                            Icons
                                .copy,
                            color: Colors
                                .white,
                            size:
                            15,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
                : const SizedBox(),
            e.result != null
                ? InkWell(
              onTap: () async {
                await Clipboard.setData(
                    ClipboardData(
                        text: e
                            .result!));
                Get.showSnackbar(
                  GetSnackBar(
                    message:
                    'Copied to clipboard'
                        .tr,
                    duration:
                    const Duration(
                        seconds:
                        2),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets
                    .symmetric(
                    vertical:
                    10),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .end,
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .end,
                  children: [
                    Container(
                      padding: const EdgeInsets
                          .symmetric(
                          vertical:
                          10,
                          horizontal:
                          20),
                      margin: const EdgeInsets
                          .symmetric(
                          horizontal:
                          3,
                          vertical:
                          0),
                      decoration:
                      BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(
                            10),
                        color: Colors
                            .blueGrey,
                      ),
                      child:
                      SizedBox(
                        width:
                        Get.width *
                            0.6,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Expanded(
                                child:
                                CustomText(
                                  e.replay![
                                  0],
                                  style:
                                  const TextStyle(color: Colors.white),
                                  maxLines:
                                  5,
                                  overflow:
                                  TextOverflow.ellipsis,
                                )),
                            const Icon(
                              Icons
                                  .copy,
                              color:
                              Colors.white,
                              size:
                              15,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          shape: BoxShape
                              .circle,
                          image: DecorationImage(
                              image:
                              CachedNetworkImageProvider(KConstants.imageBaseUrl + Get.find<GlobalController>().appInfoModel.logo.toString()))),
                    ),
                  ],
                ),
              ),
            )
                : const SizedBox(),
          ],
        ))
            .toList(),
      ],
    );
  }
}
