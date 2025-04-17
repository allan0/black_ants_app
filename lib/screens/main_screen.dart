import 'package:black_ants_app/config/app_constants.dart';
import 'package:black_ants_app/screens/advice_screen.dart';
import 'package:black_ants_app/screens/invest_screen.dart';
import 'package:black_ants_app/screens/save_screen.dart';
import 'package:black_ants_app/screens/trade_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Start on the first tab (e.g., Save or Advice)

  // List of Widgets to display based on the selected index
  static const List<Widget> _widgetOptions = <Widget>[
    SaveScreen(),   // Index 0
    TradeScreen(),  // Index 1
    InvestScreen(), // Index 2
    AdviceScreen(), // Index 3
  ];

  // List of AppBar Titles (Optional, could also be dynamic)
   static const List<String> _appBarTitles = <String>[
     'Save',
     'Trade',
     'Invest',
     'AI Advisor' // More descriptive title
   ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appBarTitles[_selectedIndex], // Dynamically change title
          // Or keep it static: Text(AppConstants.appName),
         ),
        centerTitle: true, // Center title for aesthetics
        // Add any actions if needed, e.g., settings icon
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.settings_outlined, color: theme.colorScheme.primary),
        //     onPressed: () { /* Navigate to settings */ },
        //   ),
        // ],
      ),
      body: Center(
        // Use IndexedStack to keep the state of the screens when switching tabs
        child: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
        // Alternatively, just display the selected widget directly (simpler state):
        // child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.savings_outlined),
            activeIcon: Icon(Icons.savings), // Filled icon when active
            label: 'Save',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.candlestick_chart_outlined),
             activeIcon: Icon(Icons.candlestick_chart),
            label: 'Trade',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up_outlined),
             activeIcon: Icon(Icons.trending_up),
            label: 'Invest',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_outlined), // AI / Magic icon
             activeIcon: Icon(Icons.auto_awesome),
            label: 'Advice',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // Theme properties are applied from AppTheme
      ),
    );
  }
}
