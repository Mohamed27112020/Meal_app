import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/Views/Auth/AuthStates.dart';
import 'package:meal_app/Views/Auth/Authcubit.dart';
import 'package:meal_app/Views/Auth/Pages/Login.dart';
import 'package:meal_app/Views/Cart/cartCubit/CartCubit.dart';
import 'package:meal_app/Core/Loading.dart';
import 'package:meal_app/Core/theme/theme.dart';
import 'package:meal_app/New/Cubit/RecipeCubit.dart';
import 'package:meal_app/Views/OnBoarding/Onboarding.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'Your ',
    anonKey:
        'your anon key',
  );

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
    //  final supabase = Supabase.instance.client;
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => RecipeCubit()),
          BlocProvider(create: (context) => CartCubit()),
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => AuthCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Recipes App',
              debugShowCheckedModeBanner: false,
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: state.themeMode,

              locale: DevicePreview.locale(context),
              builder: DevicePreview.appBuilder,
              home: BlocBuilder<AuthCubit, AppAuthState>(
                builder: (context, state) {
                  if (state is AuthAuthenticated) {
                    return OnboardingWithBackground();
                  } else if (state is AuthUnauthenticated ||
                      state is AuthError) {
                    return LoginPage();
                  }
                  return Scaffold(body: Center(child: LoadingLottie()));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
