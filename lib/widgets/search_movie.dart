import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';

class SearchMovie extends SearchDelegate<Movie> {
    List<Movie> movies = [];

    @override
    List<Widget>? buildActions(BuildContext context) {
        // El elemento que hay a la derecha del buscador
        // El atributo query es interno de SearchDelegate y es el value del input
        return [IconButton(onPressed: () => query = "", icon: const Icon(Icons.close))];
    }

    @override
    Widget? buildLeading(BuildContext context) {
        // El elemento que hay a la izquierda del buscador
        final emptyMovie = Movie(
            adult: false, 
            backdropPath: null, 
            genreIds: [1], 
            id: 1, 
            originalLanguage: "", 
            originalTitle: "", 
            overview: "", 
            popularity: 0, 
            posterPath: null, 
            releaseDate: null, 
            title: "", 
            video: false, 
            voteAverage: 0, 
            voteCount: 0
        );
        return IconButton(onPressed: () => close(context, emptyMovie), icon: const Icon(Icons.arrow_back));
    }

    @override
    Widget buildResults(BuildContext context) {
        // Los resultados cuando se presiona enter
        return ListView.builder(itemBuilder: (_, index) {
            return ListTile(
                onTap: () => Navigator.pushNamed(context, 'details',arguments: movies[index]),
                title: Text(movies[index].title),
            );},
            itemCount: movies.length,
        );
    }

    @override
    Widget buildSuggestions(BuildContext context) {
        // Los resultados ha medida que se va escribiendo
        final MoviesProvider moviesProvider = Provider.of(context, listen: false);

        return FutureBuilder(
            future: moviesProvider.searchByName((query.trim().isNotEmpty) ? query : "a"), // Es fa aixi perque sempre hi ha d'haver algun valor
            builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {

                //Comproba si esta buid, si ho esta mostra l'indicador
                if (!snapshot.hasData) {
                    return const ListTile(
                        title: LinearProgressIndicator(),
                    );
                }

                movies = snapshot.data!;

                return ListView.builder(itemBuilder: (_, index) {
                    return ListTile(
                        onTap: () => Navigator.pushNamed(context, 'details',arguments: movies[index]),
                        title: Text(movies[index].title),
                    );},
                    itemCount: movies.length,
                );
            },
        );
    }
}