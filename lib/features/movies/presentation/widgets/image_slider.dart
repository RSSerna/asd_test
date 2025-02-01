import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/router_paths.dart';
import '../../domain/entities/movie.dart';

class ImageSliderWidget extends StatefulWidget {
  final List<Movie> movies;
  final String title;
  final Function onNextPage;

  const ImageSliderWidget(
      {super.key,
      required this.movies,
      required this.title,
      required this.onNextPage});

  @override
  State<ImageSliderWidget> createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels + 300 >=
          scrollController.position.maxScrollExtent) {
        widget.onNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              thickness: 6,
              thumbVisibility: true,
              controller: scrollController,
              child: ListView.builder(
                controller: scrollController,
                // scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: (_, index) {
                  return _MovieListTile(
                    title: widget.title,
                    movie: widget.movies[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieListTile extends StatelessWidget {
  final Movie movie;
  final String title;
  const _MovieListTile({
    required this.movie,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(RouterPaths.movieInfo, extra: movie);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: double.infinity,
        color: Colors.blueGrey,
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth <= 500) {
            return Column(
              spacing: 5,
              children: [
                Hero(
                  tag: movie.heroID,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/no-image.jpg'),
                      image: NetworkImage(movie.movieData.fullImagePoster),
                      fit: BoxFit.cover,
                      height: 150,
                      width: 100,
                    ),
                  ),
                ),
                Text(
                  movie.movieData.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                Text(
                  movie.movieData.originalTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }
          return Row(
            spacing: 20,
            children: [
              Hero(
                tag: movie.heroID,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(movie.movieData.fullImagePoster),
                    fit: BoxFit.cover,
                    height: 150,
                    width: 100,
                  ),
                ),
              ),
              Column(
                spacing: 5,
                children: [
                  Text(
                    movie.movieData.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    movie.movieData.originalTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
