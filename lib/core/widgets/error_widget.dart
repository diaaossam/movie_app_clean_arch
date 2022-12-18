import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ErrorScreen extends StatelessWidget {

  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.warning_amber_rounded,
              color: AppColors.primaryColor,
              size: 150,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: const Text(
              "SomeThing Went Wrong",
              style: TextStyle(
                  color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            "Try Again",
            style: TextStyle(
                color: AppColors.hintColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width * 0.55,
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 500,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: const Text(
                "Reload Screen",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              onPressed: () {

              },
            ),
          )
        ],
      ),
    );
  }
}
