import 'package:asd_test/features/movies/domain/entities/movie.dart';
import 'package:asd_test/features/movies/presentation/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/cast_entity.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as List<Object>;
    final Movie movie = arguments[0] as Movie;
    debugPrint(arguments[1].toString());
    debugPrint(movie.heroID);

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomSliverAB(
          movie: movie,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterAndInfoMovie(
            movie: movie,
          ),
          _MovieOverview(
            movie: movie,
          ),
          _CastingCards(
            movieId: movie.movieData.id,
          )
        ]))
      ],
    ));
  }
}

class _CastingCards extends StatelessWidget {
  final int movieId;
  const _CastingCards({
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    return FutureBuilder(
        future: movieProvider.getMovieCast(movieId),
        builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
              height: 180,
              width: double.infinity,
              child: CircularProgressIndicator(),
            );
          }
          final List<Cast> cast = snapshot.data!;
          return Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            // color: Colors.red,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (_, index) {
                  return Container(
                    width: 110,
                    height: 100,
                    // color: Colors.tealAccent,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage(
                            placeholder:
                                const AssetImage('assets/no-image.jpg'),
                            image: NetworkImage(cast[index].fullProfilePath),
                            height: 140,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          cast[index].name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                }),
          );
        });
  }
}

class _MovieOverview extends StatelessWidget {
  final Movie movie;
  const _MovieOverview({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.movieData.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class _PosterAndInfoMovie extends StatelessWidget {
  final Movie movie;
  const _PosterAndInfoMovie({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme2 = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.movieData.fullImagePoster),
                // fit: BoxFit.cover,
                height: 150,
                // width: 200,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 220),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.movieData.title,
                  style: textTheme2.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  movie.movieData.originalTitle,
                  style: textTheme2.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    const Icon(Icons.star),
                    Text(
                      movie.movieData.voteAverage.toString(),
                      style: textTheme2.bodySmall,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomSliverAB extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAB({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppTheme.lightColorScheme.secondary,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          padding: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black26,
          child: Text(
            movie.movieData.title,
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.movieData.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
