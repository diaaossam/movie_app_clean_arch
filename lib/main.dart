import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_clean_arch/config/theme/app_theme.dart';
import 'package:movie_app_clean_arch/features/Movie/injection_container.dart' as di;
import 'package:movie_app_clean_arch/features/Movie/presentation/screens/movies_screen.dart';

import 'core/bloc_helper/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppThemes().getLightTheme(),
      home: const MainMoviesScreen(),
    );
  }
}
