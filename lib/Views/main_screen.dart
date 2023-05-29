import 'package:flutter/material.dart';
import 'package:jobs_hub/Models/user_model.dart';
import 'package:jobs_hub/Views/Login-Register/login_screen.dart';
import 'package:jobs_hub/Views/Profile/profile_screen.dart';

import '../Models/user_singleton.dart';
import 'home_screen.dart';
import 'job_search_screen.dart';

class MainScreen extends StatefulWidget {
  final int index;
  const MainScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  User user = UserSingleton().user;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  final List<Widget> _pages = const [
    HomeScreen(),
    JobSearchScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Jobs Hub',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
          ),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: NavigationDrawer(index: _currentIndex),
      body: _pages[_currentIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
    return Visibility(
      // visible: showBottomNavigationBar,
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  final int index;
  const NavigationDrawer({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildHeader(context, index),
                    buildMenuItems(context, index),
                    const Divider(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 10,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.logout_outlined),
                    title: const Text('Logout'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Logout'),
                            content:
                                const Text('Are you sure you want to log out?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  UserSingleton().resetUser();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildHeader(BuildContext context, index) {
    final User user = UserSingleton().user;

    return Material(
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: () {
          if (index == 2) {
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const MainScreen(index: 2),
              ),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top,
            bottom: 24,
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 62.0,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: AssetImage(
                    user.profileImage ?? 'assets/images/user_image.png',
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                '${user.firstName} ${user.lastName}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '@${user.username}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context, index) => Padding(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          spacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {
                if (index == 0) {
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(index: 0),
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Profile'),
              onTap: () {
                if (index == 2) {
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(index: 2),
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.search_outlined),
              title: const Text('Search'),
              onTap: () {
                if (index == 1) {
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(index: 1),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      );
}
