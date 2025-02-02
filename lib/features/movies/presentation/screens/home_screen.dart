import 'package:asd_test/core/router/router_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
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
          leading: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push(RouterPaths.language),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
            )
          ],
        ),
        body: Column(
          children: [
            ImageSliderWidget(
              movies: movieProvider.popularMovie,
              title: AppLocalizations.of(context)?.popular ?? "Popular",
              onNextPage: () => movieProvider.getPopularMovies(),
            ),
          ],
        ));
  }
}
