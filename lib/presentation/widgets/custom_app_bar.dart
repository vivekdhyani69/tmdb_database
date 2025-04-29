import 'package:flutter/material.dart';
import 'package:movie_tmdb/presentation/screens/home_screen.dart';
import 'package:movie_tmdb/presentation/screens/people_screen.dart';
import 'package:movie_tmdb/presentation/widgets/header_dropdown_items.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
      elevation: 0,
      title:
          screenWidth > 600
              ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side
                  Row(
                    children: [
                      Image.network(
                        'https://miro.medium.com/v2/resize:fit:720/format:webp/1*idLhmtcMdWeN-UMGR0ROjQ.png',
                        height: 60,
                      ),
                      const SizedBox(width: 20),
                      HeaderDropdownItems(
                        title: 'Movies',
                        menuItems: {
                          'Popular': '/people',
                          'Now Playing': '/movie/nowplaying',
                          'UpComing': '/movie/Upcoming',
                          'Top Rated': '/tv/toprated',
                        },
                      ),
                      const SizedBox(width: 20),
                      HeaderDropdownItems(
                        title: 'Tv-Shows',
                        menuItems: {
                          'Popular': '/people',
                          'Arriving Today': '/movie/nowplaying',
                          'On day': '/movie/Upcoming',
                          'Top Rated': '/tv/toprated',
                        },
                      ),
                      const SizedBox(width: 20),
                      // _navButton('TV-Shows', context),
                      HeaderDropdownItems(
                        title: 'People',
                        menuItems: {
                          'Popular People': '/people',
                          //
                        },
                      ),
                      const SizedBox(width: 20),
                      // _navButton('People', context),
                      HeaderDropdownItems(
                        title: 'More',
                        menuItems: {
                          'Discussions': '/people',
                          'Leatherboard': '/movie/nowplaying',
                          'Supports': '/movie/Upcoming',
                          'Api Documentation': '/tv/toprated',
                          'Api for Business': '/tv/toprated',
                        },
                      ),
                      // _navButton('More', context),
                    ],
                  ),
                  // Right side
                  Row(
                    children: [
                      _addNewItem(Icons.add),
                      // _iconButton(Icons.language),
                      _notificationIcon(Icons.notifications),
                      // _iconButton(Icons.account_circle),
                      _accountIcon(),
                      // _iconButton(Icons.search),r
                    ],
                  ),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    'https://miro.medium.com/v2/resize:fit:720/format:webp/1*idLhmtcMdWeN-UMGR0ROjQ.png',

                    height: 220,
                  ),
                  Builder(
                    builder:
                        (context) => IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                  ),
                ],
              ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

Widget _navButton(String text, BuildContext context) {
  return TextButton(
    onPressed: () {
      if (text == "People") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PeopleScreen(), // pass person
          ),
        );
      }
    },
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _iconButton(IconData icon) {
  return IconButton(onPressed: () {}, icon: Icon(icon, color: Colors.white));
}

Widget _addNewItem(IconData icon) {
  return PopupMenuButton<int>(
    icon: Icon(icon, color: Colors.white),
    onSelected: (value) {
      if (value == 0) {
        print("Add new movie");
      } else if (value == 1) {
        print('Add new TV Show');
      }
    },
    itemBuilder:
        (context) => [
          const PopupMenuItem(value: 0, child: Text("Add new movie")),
          const PopupMenuItem(value: 1, child: Text("Add new TV Show")),
        ],
  );
}

Widget _notificationIcon(IconData icon) {
  return PopupMenuButton<int>(
    icon: Icon(icon, color: Colors.white), // ✅ Correct way
    itemBuilder:
        (context) => [
          PopupMenuItem<int>(
            value: 0,

            child: Container(
              width: 250, // adjust width as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Unread Notifications: 0",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Good job! Looks like you're all caught up.",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      // Optional: handle "View All..." tap here
                    },
                    child: const Text(
                      "View All...",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue, // make it stand out
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
    onSelected: (value) {
      // You can handle menu selection here
      if (value == 0) {
        print("Profile clicked");
      }
    },
  );
}

Widget _accountIcon() {
  return PopupMenuButton<int>(
    icon: const Icon(Icons.account_circle, color: Colors.white),
    onSelected: (value) {
      // Handle menu selection here
      if (value == 0) {
        print('Profile Clicked');
      } else if (value == 1) {
        print('Settings Clicked');
      } else if (value == 2) {
        print('Logout Clicked');
      }
    },

    itemBuilder:
        (context) => [
          const PopupMenuItem<int>(value: 0, child: Text("Profile")),
          const PopupMenuDivider(),
          const PopupMenuItem<int>(value: 1, child: Text("Settings")),
          const PopupMenuItem<int>(value: 2, child: Text("Logout")),
        ],
  );
}
