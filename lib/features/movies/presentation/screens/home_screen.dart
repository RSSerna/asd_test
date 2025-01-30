import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';
import '../widgets/image_slider.dart';
import '../widgets/search_delegate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('ASD Movies'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Create a widget for listing the movies
              ImageSliderWidget(
                movies: movieProvider.popularMovie,
                title: 'Populares',
                onNextPage: () => movieProvider.getPopularMovies(),
              ),
            ],
          ),
        ));
  }
}
