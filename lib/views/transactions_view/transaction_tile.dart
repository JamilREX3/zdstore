import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zdstore/models/transactions_model.dart';

import '../../components/custom_text.dart';

class TransactionsTail extends StatelessWidget {
  final Transaction transaction;

  const TransactionsTail({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    double amount = double.parse(transaction.amount!);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    List<Color> gradientColors = [];
    if (amount > 0) {
      // positive amount, use green gradient
      gradientColors = isDarkMode
          ? [
              Colors.blueGrey.shade900,
              Colors.grey.shade800,
              Colors.green.shade900
            ]
          : [Colors.grey.shade100,
        Colors.black12,
        Colors.green.shade600];
    } else {
      // negative amount, use red gradient
      gradientColors = isDarkMode
          ? [
              Colors.blueGrey.shade900,
              Colors.grey.shade800,
              Colors.red.shade900
            ]
          : [Colors.grey.shade100,
        Colors.black12,
        Colors.red.shade600];
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          transform: Get.locale!.languageCode != 'ar'
              ? const GradientRotation(pi)
              : null,
          colors: gradientColors,
          // the colors of the gradient
          begin: Alignment.centerLeft,
          // the begin point of the gradient
          end: Alignment.centerRight,
          stops: const [0.98, 0.98, 0.98],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                transaction.reason.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  const CustomText('Cost'),
                  const SizedBox(width: 10),
                  CustomText(
                    double.parse(transaction.amount.toString())
                        .toStringAsFixed(2),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    double.parse(transaction.oldBalance.toString())
                        .toStringAsFixed(2),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(bottom: 4, left: 4, right: 4),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 12,
                    ),
                  ),
                  CustomText(double.parse(transaction.newBalance.toString())
                      .toStringAsFixed(2)),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.access_time_rounded,color: Colors.grey,size: 15),
                  const SizedBox(width: 2),
                  CustomText(
                    DateFormat('dd/M/yyyy h:mm a')
                        .format(transaction.createdAt!),
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
          const Expanded(child: SizedBox()),
          Container(
            child: amount > 0
                ? const Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet_rounded,
                        color: Colors.green,
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.green,
                            size: 10,
                          ),
                          Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.green,
                            size: 15,
                          ),
                        ],
                      )
                    ],
                  )
                : const Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet_rounded,
                        color: Colors.red,
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.remove,
                            color: Colors.red,
                            size: 10,
                          ),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.red,
                            size: 15,
                          ),
                        ],
                      )
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
