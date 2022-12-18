import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class AppThemes{
  ThemeData getLightTheme(){
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      hintColor: AppColors.hintColor
    );
  }
}