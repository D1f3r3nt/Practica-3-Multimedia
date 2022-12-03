import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

/// Mostra les pelicules similars
class SimilarCards extends StatelessWidget {
    final int idMovie;
    
    const SimilarCards({required this.idMovie});

    @override
    Widget build(BuildContext context) {
        final MoviesProvider moviesProvider = Provider.of(context, listen: false);

        return FutureBuilder(
            future: moviesProvider.getSimilarFromMovie(idMovie),
            builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
                if (!snapshot.hasData) {
                    return Container(
                        child: const Center(child: CircularProgressIndicator()),
                    );
                }

                final movies = snapshot.data!;

                return Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    width: double.infinity,
                    height: 180,
                    child: ListView.builder(
                        itemCount: movies.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) => _SimilarCard(movie: movies[index])
                    ),
                );
            },
        );
    }
}

/// Fa la carta de les pelicules
class _SimilarCard extends StatelessWidget {
    final Movie movie;

    const _SimilarCard({required this.movie});

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 110,
            height: 100,
            child: Column(
                children: [
                    GestureDetector(
                        // Es fa un replacement Named, per evitar que es vagin incrementant el nombre de bots desde la pantalla principal
                        onTap: () => Navigator.pushReplacementNamed(context, 'details',arguments: movie),  
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
                                placeholder: const AssetImage('assets/no-image.jpg'),
                                image: NetworkImage(movie.fullPosterPath), // Agafa la URL per a la imatge
                                height: 140,
                                width: 100,
                                fit: BoxFit.cover,
                            ),
                        ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                    )
                ],
            ),
        );
    }
}
