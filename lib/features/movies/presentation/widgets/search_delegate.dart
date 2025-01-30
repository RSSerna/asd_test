import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/movie.dart';
import '../providers/movies_provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar Pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_left_sharp),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('data');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const _EmptyWidget();
    }

    final movieProvider = Provider.of<MovieProvider>(context);
    movieProvider.getSuggestionByQuery(query);

    return StreamBuilder(
        stream: movieProvider.suggestionStream,
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return const _EmptyWidget();
          }
          final movies = snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, index) => _ListMovies(
              movie: movies[index],
            ),
          );
        });
  }
}

class _ListMovies extends StatelessWidget {
  final Movie movie;
  const _ListMovies({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    movie.heroID = 'search-${movie.movieData.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroID,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.movieData.fullImagePoster),
        ),
      ),
      title: Text(movie.movieData.title),
      subtitle: Text(movie.movieData.originalTitle),
      onTap: () =>
          Navigator.pushNamed(context, 'details', arguments: [movie, 'Search']),
    );
  }
}

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Icon(
      Icons.movie_creation_outlined,
      color: Colors.black38,
      size: 100,
    ));
  }
}
