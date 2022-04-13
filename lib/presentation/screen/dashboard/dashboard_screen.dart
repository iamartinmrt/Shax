import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shax/presentation/screen/home/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const Text("Profile Screen soon..."),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 20, color: Colors.black.withOpacity(.1))
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100]!,
                  color: Colors.black,
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'Profile',
                    ),
                  ],
                  selectedIndex: _currentIndex,
                  onTabChange: (index) => setState(() {
                    _currentIndex = index;
                  }),
                  // onTabChange: (index) => context.read<DashboardBloc>().add(DashboardBNSelectedChanged(index: index))),
                ),
              ),
            )),
        backgroundColor: Colors.white,
        body: Center(
          child: _widgetOptions.elementAt(_currentIndex),
        ));
    // return BlocProvider(
    //   create: DependencyProvider.get<DashboardBloc>(),
    //   child:
    //       BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) {
    //
    //   }),
    // );
  }
}
