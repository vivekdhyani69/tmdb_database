import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/popular_people/people_bloc.dart';
import 'package:movie_tmdb/presentation/blocs/popular_people/people_event.dart';
import 'package:movie_tmdb/presentation/blocs/popular_people/people_state.dart';

class PeopleScreen extends StatefulWidget {
  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PeopleBloc>().add(FetchPeople(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular People')),
      body: BlocBuilder<PeopleBloc, PeopleState>(
        builder: (context, state) {
          if (state is PeopleLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PeopleLoaded) {
            return Column(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      //LayoutBuilder is returns context , constraints
                      int crossAxisCount;
                      if (constraints.maxWidth >= 1200) {
                        crossAxisCount = 6;
                      } else if (constraints.maxWidth >= 800) {
                        crossAxisCount = 4;
                      } else if (constraints.maxWidth >= 600) {
                        crossAxisCount = 3;
                      } else {
                        crossAxisCount = 2;
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: state.peopleList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.5,
                        ),
                        itemBuilder: (context, index) {
                          final person = state.peopleList[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  //makes a rounded corner
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child:
                                      person.profilePath != ''
                                          ? Image.network(
                                            'https://image.tmdb.org/t/p/w500${person.profilePath}',
                                            fit: BoxFit.cover,
                                          )
                                          : Container(
                                            height: 300,
                                            width: 300,
                                            color: Colors.grey[300],
                                            child: Icon(
                                              Icons.person,
                                              size: 100,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    person.name ?? 'Unknown',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text('Previous'),
                        onPressed:
                            state.currentPage > 1
                                ? () => context.read<PeopleBloc>().add(
                                  FetchPeople(state.currentPage - 1),
                                )
                                : null,
                      ),
                      SizedBox(width: 8),
                      for (int i = 1; i <= 3; i++)
                        ElevatedButton(
                          onPressed:
                              () => context.read<PeopleBloc>().add(
                                FetchPeople(i),
                              ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                state.currentPage == i ? Colors.blue : null,
                          ),
                          child: Text('$i'),
                        ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed:
                            () => context.read<PeopleBloc>().add(
                              FetchPeople(state.currentPage + 1),
                            ),
                        child: Text('Next'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is PeopleError) {
            return Center(child: Text(state.message));
          }

          return Center(
            child: Text('Something went wrong or is still loading...'),
          );
        },
      ),
    );
  }
}
