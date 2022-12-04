import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

/// Clase de la pantalla principal
class HomeScreen extends StatelessWidget {
    late MoviesProvider moviesProvider;

    @override
    Widget build(BuildContext context) {
        moviesProvider = Provider.of(context);

        List<Movie> display = moviesProvider.onDisplayMovie;
        List<Movie> popular = moviesProvider.onPopularMovie;
        List<Movie> upcoming = moviesProvider.onUpcomingMovie;
        List<Movie> rated = moviesProvider.onRatedMovie;

        return Scaffold(
            appBar: AppBar(
                title: const Text('Cartellera'),
                elevation: 0,
                actions: [
                    IconButton(
                        onPressed: () => showSearch(context: context, delegate: SearchMovie()), // S'encarrega de enseñar el SearchDelegate
                        icon: const Icon(Icons.search_outlined)
                    )
                ],
            ),
            body: RefreshIndicator(
                onRefresh: () => refresh(),
                child: SingleChildScrollView(
                    child: Container(
                        child: Column(
                            children: [
                                // Targetes principals
                                CardSwiper(movies: display),
                
                                // Slider de pel·licules
                                MovieSlider(title: "Populars", movies: popular), // De populars
                                MovieSlider(title: "Proximament", movies: upcoming), // De proximament
                                MovieSlider(title: "Més valorats", movies: rated), // De valoracio
                            ],
                        ),
                    ),
                ),
            ),
            backgroundColor: const Color.fromARGB(255, 116, 217, 230),
        );
    }

    /// S'encarrega de fer la cridada per refrescar tot el contingt
    Future refresh() async {
        moviesProvider.refresh();
    }
}
