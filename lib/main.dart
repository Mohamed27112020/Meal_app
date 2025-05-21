import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/Cubit/MealCubit.dart';
import 'package:meal_app/OnBoarding/Onboarding.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (BuildContext context) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      child: BlocProvider(
        create: (context) => MealCubit()..loadMeals(),
        child: MaterialApp(
          title: 'Meal App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),

          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          home: OnboardingWithBackground(),
        ),
      ),
    );
  }
}
