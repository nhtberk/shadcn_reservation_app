import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/home/home_layout.dart';
import 'views/hotels/hotel_page.dart';
import 'views/onboard/onboard_page.dart';
import 'views/setting/setting_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _router = GoRouter(
    redirect: (context, state) async {
      // SharedPreferences'dan onboard durumunu kontrol et
      final prefs = await SharedPreferences.getInstance();
      final hasSeenOnboard = prefs.getBool('hasSeenOnboard') ?? false;
      // final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      // Eğer onboard görülmediyse onboard sayfasına yönlendir
      if (hasSeenOnboard) {
        return '/onboard';
      }

      // Eğer giriş yapılmadıysa giriş sayfasına yönlendir (opsiyonel)
      // if (!isLoggedIn) {
      //   return '/login';
      // }

      // Aksi halde ana sayfaya git
      return '/';
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeLayout(),
        routes: [
          GoRoute(
            path: 'hotels/:hotelId',
            builder: (context, state) => const Hotel(),
          ),
        ],
      ),
      // Onboard sayfası için ayrı bir route ekleyin
      GoRoute(
        path: '/onboard',
        builder: (context, state) => const Onboard(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ShadcnApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(colorScheme: ColorSchemes.darkBlue(), radius: 0.7),
      theme: ThemeData(colorScheme: ColorSchemes.lightBlue(), radius: 0.7),
      routerConfig: _router,
    );
  }
}
