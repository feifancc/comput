import 'package:comput/page/interaction/interaction_page.dart';
import 'package:comput/page/message/message_page.dart';
import 'package:comput/page/setting/setting_page.dart';

import 'package:comput/state/layout_state.dart';
import 'package:comput/state/school_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'page/canvas/index_page.dart';
import 'page/index/index_page.dart';
import 'page/native/native_page.dart';
import 'page/school/school_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Add this your main method.
  // used to show a webview title bar.
  runApp(
    ChangeNotifierProvider(
      create: (context) => LayoutConfigState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    LayoutConfigState layoutConfigState = context.watch<LayoutConfigState>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: layoutConfigState.getPrimeColor(),
        cardColor: layoutConfigState.getCardColor(),
        disabledColor: layoutConfigState.getDisabledColor(),
        splashColor: layoutConfigState.getSplashColor(),
        textTheme: const TextTheme(
            bodySmall: TextStyle(color: Color.fromARGB(255, 151, 151, 151))),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(15, 177, 163, 163)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '非凡'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 2;

  static List<Map<String, dynamic>> pageList = [
    {
      "icon": const Icon(Icons.home),
      "label": "Home",
      "Com": const IndexPage(),
    },
    {
      "icon": const Icon(Icons.message),
      "label": "message",
      "Com": const MessagePage(),
    },
    {
      "icon": const Icon(Icons.school),
      "label": "School",
      "Com": const School()
    },
    {
      "icon": const Icon(Icons.settings),
      "label": "Settings",
      "Com": const Setting()
    },
    {
      "icon": const Icon(Icons.network_cell),
      "label": "Native",
      "Com": const Native()
    },
    {
      "icon": const Icon(Icons.image_aspect_ratio),
      "label": "Canvas",
      "Com": const CustomPaintRoute()
    },
    {
      "icon": const Icon(Icons.interests),
      "label": "InterAction",
      "Com": const InterActionPage()
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    LayoutConfigState layoutConfigState = context.watch<LayoutConfigState>();

    return LayoutBuilder(
      builder: (context1, constraints) {
        layoutConfigState.setLayoutWidth(width: constraints.maxWidth);
        return layoutConfigState.direction == SchoolState.VERTICAL
            ? Scaffold(
                body: Center(
                  child: pageList[_selectedIndex]['Com'],
                ),
                bottomNavigationBar: BottomNavigat(
                    index: _selectedIndex,
                    onChange: _onItemTapped,
                    pageList: pageList),
              )
            : Scaffold(
                body: Row(
                  children: [
                    SafeArea(
                      child: NavigationRail(
                        extended: constraints.maxWidth >=
                            layoutConfigState.getCriticalPoint(),
                        minExtendedWidth:
                            layoutConfigState.getMinExtendeWidth(),
                        destinations: pageList
                            .map<NavigationRailDestination>(
                              (e) => NavigationRailDestination(
                                icon: e['icon'],
                                label: Text(e['label']),
                              ),
                            )
                            .toList(),
                        selectedIndex: _selectedIndex,
                        onDestinationSelected: _onItemTapped,
                      ),
                    ),
                    Expanded(
                      child: Center(child: pageList[_selectedIndex]['Com']),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

class BottomNavigat extends StatefulWidget {
  final int index;
  final void Function(int) onChange;
  final List<Map<String, dynamic>> pageList;
  const BottomNavigat({
    super.key,
    required this.index,
    required this.onChange,
    required this.pageList,
  });

  @override
  State<BottomNavigat> createState() => _BottomNavigatState();
}

class _BottomNavigatState extends State<BottomNavigat> {
  @override
  Widget build(context) {
    return BottomNavigationBar(
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).disabledColor,
      items: widget.pageList
          .map<BottomNavigationBarItem>((e) =>
              BottomNavigationBarItem(icon: e['icon'], label: e["label"]))
          .toList(),
      currentIndex: widget.index,
      onTap: widget.onChange,
    );
  }
}
