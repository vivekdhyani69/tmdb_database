import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/core/routes/route_names.dart';
import 'package:movie_tmdb/presentation/blocs/movie_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/movie_event.dart';
import 'package:movie_tmdb/presentation/blocs/search_bloc/search_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/search_bloc/search_event.dart';
import 'package:movie_tmdb/presentation/blocs/search_bloc/search_state.dart';
import 'package:movie_tmdb/presentation/widgets/custom_app_bar.dart';
import 'package:movie_tmdb/presentation/widgets/free_to_watch.dart';
// import 'package:movie_tmdb/presentation/widgets/latest_trailer/popular.dart';
import 'package:movie_tmdb/presentation/widgets/trending_movies.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTab = 0;
  int selectedTab1 = 0;
  Timer?
  _debounceTimer; //Add this variable at the class level to store to the time
  final TextEditingController controller = TextEditingController();
  final TextEditingController bottomController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool showDropdown = false;

  OverlayEntry? _overlayEntry;
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _removeOverlay();
        showDropdown = false;
      }
    });

    controller.addListener(() {
      if (controller.text.isEmpty) {
        setState(() {
          showDropdown = false;
        });
      } else {
        setState(() {
          showDropdown = true; // Show dropdown when typing
        });
      }
    });

    context.read<MovieBloc>().add(FetchTrendingMoviesEvent());
  }

  void _showOverlay(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            left: offset.dx,
            top: offset.dy + size.height,
            width: size.width,
            child: Material(
              elevation: 4,
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoaded && state.results.isNotEmpty) {
                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: state.results.length,
                        itemBuilder: (context, index) {
                          final movie = state.results[index];
                          return ListTile(
                            title: Text(movie.title), // Display movie title
                            onTap: () {
                              // Perform navigation before removing the overlay
                              Navigator.pushNamed(
                                context,
                                RouteNames.searchedMovie,
                                arguments: {'id': movie.id.toString()},
                              );
                              controller.clear();
                              _removeOverlay(); // Now remove the overlay
                              _focusNode.unfocus(); // Unfocus the text field
                            },
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),

            Column(
              children: [
                TextField(
                  focusNode: _focusNode,
                  controller: controller,
                  onChanged: (value) {
                    if (_debounceTimer != null) {
                      _debounceTimer!.cancel();
                    }
                    //cancel any previous timer to reset the debounce delay
                    if (_overlayEntry == null) _showOverlay(context);

                    ///waits 3 second for calls next events
                    _debounceTimer = Timer(const Duration(seconds: 1), () {
                      context.read<SearchBloc>().add(SearchQueryChanged(value));
                    });
                  },

                  //for search field
                  style: TextStyle(
                    color: Color.fromRGBO(172, 172, 172, 1),
                    fontFamily: 'Poppins',
                  ),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(172, 172, 172, 1),
                      ),
                    ),
                    hintText: 'Search for movie,tv shows,person...',

                    prefixIcon: Icon(Icons.search, color: Colors.black),
                  ),
                ),
                // Add some spacing
                const SizedBox(height: 10),
                // Suggestion dropdown style list
                if (showDropdown)
                  BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchInitial) {
                        return const SizedBox();
                      }
                      if (state is SearchLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is SearchLoaded) {
                        return SizedBox(
                          height: 300,
                          child: ListView.builder(
                            key:
                                UniqueKey(), // Add a unique key to ensure the ListView is rebuilt
                            itemCount: state.results.length,
                            itemBuilder: (context, index) {
                              final movie = state.results[index];
                              return GestureDetector(
                                onTap: () async {
                                  final movieId = movie.id.toString();

                                  // Trigger navigation after the current frame

                                  await Navigator.pushNamed(
                                    context,
                                    RouteNames.searchedMovie,
                                    arguments: {
                                      'id': movieId,
                                    }, 
                                  );

                                  controller.clear(); // Clear text field
                                  _removeOverlay(); // Remove overlay
                                  _focusNode.unfocus(); // Unfocus text field
                                  setState(() {
                                    showDropdown = false; // Close dropdown
                                  });
                                },

                                child: ListTile(title: Text(movie.title)),
                              );
                            },
                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
              ],
            ),

            ///Navigator.pushNamed(
            ///child : Column(
            ///)
            ///
            ///)
            Container(
              // height: 300,
              width: double.maxFinite,

              decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, .2)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          'Welcome.',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            height: 1.1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          'Millions of movies, TV shows and people to discover. Explore now.',
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 35,
                            height: 1.1,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: double.maxFinite,

                        ///It means use as much avaiable space as possible
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: TextField(
                          controller: controller,
                          style: TextStyle(
                            color: Color.fromRGBO(172, 172, 172, 1),
                          ),
                          decoration: InputDecoration(
                            suffixIcon: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(
                                  16,
                                  197,
                                  198,
                                  1,
                                ),
                              ),

                              onPressed: () {
                                // context.read<SearchBloc>().add(
                                //   SearchQueryChanged(controller.text),
                                // );
                              },
                              child: Text(
                                'Search',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            hintText: 'Search for movie, tv shows, person...',
                            // hintStyle: TextStyle(color: Colors.grey),
                            filled: true, // 👈 enables background
                            fillColor:
                                Colors.white, // 👈 sets background to white
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                                width: 2,
                              ), // optional highlight on focus
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Trending",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  TabButton(
                    text: "Today",
                    index: 0,
                    selectedTab: selectedTab,
                    onPressed: () {
                      setState(() {
                        selectedTab = 0;
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  TabButton(
                    text: "This week",
                    index: 1,
                    selectedTab: selectedTab,
                    onPressed: () {
                      setState(() {
                        selectedTab = 1;
                      });
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            selectedTab == 0 ? MovieCardList() : MovieCardList(),
            SizedBox(height: 20),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Free To Watch",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  TabButton(
                    text: "Movies",
                    index: 0,
                    selectedTab: selectedTab1,
                    onPressed: () {
                      setState(() {
                        selectedTab1 = 0;
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  TabButton(
                    text: "TV",
                    index: 1,
                    selectedTab: selectedTab1,
                    onPressed: () {
                      setState(() {
                        selectedTab1 = 1;
                      });
                    },
                  ),
                ],
              ),
            ),

            FreeToWatch(),
            // PopularHtml(),
          ],
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String text;
  final int index;
  final int selectedTab;
  final VoidCallback onPressed; //this is void callback function

  const TabButton({
    required this.text,
    required this.index,
    required this.selectedTab,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedTab; //0//1

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? Color.fromRGBO(3, 37, 65, 1) : Colors.white,
        foregroundColor:
            isSelected
                ? Colors.white
                : Color.fromRGBO(3, 37, 65, 1), // Text color
        side: BorderSide(
          color: Color.fromRGBO(3, 37, 65, 1),
        ), // Optional border
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color:
              isSelected
                  ? Color.fromRGBO(148, 243, 197, 1)
                  : Color.fromRGBO(3, 37, 65, 1),
        ),
      ),
    );
  }
}
