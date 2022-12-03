import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';

/// Clase per a les tergetes de les pelicules
class MovieSlider extends StatelessWidget {
    final List<Movie> movies;
    final String title;

    const MovieSlider({Key? key,required this.title, required this.movies}) : super(key: key);

    @override
    Widget build(BuildContext context) {

        //Comproba si esta buit, si ho esta mostra el circularProgress
        if (movies.isEmpty) {
            return Container(
                width: double.infinity,
                height: 260,
                child: const Center(child: CircularProgressIndicator()),
            );
        }

        return Container(
            width: double.infinity,
            height: 260,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(title,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                            ),
                    ),
                    const SizedBox(
                        height: 5,
                    ),
                    Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movies.length,
                            itemBuilder: (_, int index) => _MoviePoster(movie: movies[index]),
                        )
                    ),
                ],
            ),
        );
    }
}


/// Clase per a cada tarjeta de cada pelicula
class _MoviePoster extends StatelessWidget {

    final Movie movie;

    const _MoviePoster({Key? key, required this.movie}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Container(
            width: 130,
            height: 190,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
                children: [
                    GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'details',arguments: movie),
                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                            placeholder: const AssetImage('assets/no-image.jpg'),
                            image: NetworkImage(movie.fullPosterPath), // Agafa el path de la imatge
                            width: 130,
                            height: 190,
                            fit: BoxFit.cover,
                        ),
                        ),
                    ),
                    const SizedBox(
                        height: 5,
                    ),
                    Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis, // Si es pasa de el maxim amb el texte aquest posa (...)
                        textAlign: TextAlign.center,
                    ),
                ],
            ),
        );
    }
}
