import 'package:go_router/go_router.dart';
import 'package:icon_forest/don_icons.dart';
import 'package:icon_forest/flat_icons_medium.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../setting/setting_page.dart';
import 'home_page.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _pageIndex = 0;

  final _pages = [const Home(), const Setting()];

  final _appBars = [
    AppBar(title: Text("Resim gelicek")),
    AppBar(title: Text("Setting"))
  ];

  NavigationButton buildButton(String label, Icon icon) {
    return NavigationButton(
      style: const ButtonStyle.muted(density: ButtonDensity.icon),
      selectedStyle: const ButtonStyle.fixed(density: ButtonDensity.icon),
      label: Text(label),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(headers: [
      _appBars[_pageIndex],
      Divider()
    ], footers: [
      const Divider(),
      NavigationBar(
          alignment: NavigationBarAlignment.start,
          labelType: NavigationLabelType.none,
          expands: true,
          onSelected: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
          index: _pageIndex,
          children: [
            buildButton('Home', const Icon(BootstrapIcons.house)),
            buildButton('Setting', Icon(BootstrapIcons.gear))
          ])
    ], child: _pages[_pageIndex].withPadding(all: 10));
  }
}
