import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_cashe_api/const/const.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  dynamic add;
  CustomAppBar({
    Key? key,
    this.add,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //person
            personAppbar,
            //title
            const Text(
              '# TASKS OF TO DAY',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                //dark mode
                IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/icons/night.png',
                    width: 25,
                    height: 25,
                  ),
                ),
                //add task
                IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: add,
                  icon: const Icon(
                    Icons.add,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
