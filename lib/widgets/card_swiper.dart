import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

/// Clase encarregada de fer el Swipper de la pagina principal
class CardSwiper extends StatelessWidget {

    final List<Movie> movies;

    const CardSwiper({Key? key, required this.movies}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;

        // Comproba que si no hi ha pelicules, mostri el circularProgressIndicator
        if (movies.isEmpty) {
            return Container(
                width: double.infinity,
                height: size.height,
                child: const Center(child: CircularProgressIndicator()),
            );
        }

        return Container(
            width: double.infinity,
            // Aquest multiplicador estableix el tant per cent de pantalla ocupada 50%
            height: size.height * 0.5,
            // color: Colors.red,
            child: Swiper(
                itemCount: movies.length,
                layout: SwiperLayout.STACK,
                itemWidth: size.width * 0.6,
                itemHeight: size.height * 0.4,
                itemBuilder: (BuildContext context, int index) {
                    final movie = movies[index];
                    return GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'details', arguments: movie), // Per cridar a la pagina d'informacio
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
                                placeholder: const AssetImage('assets/no-image.jpg'),
                                image: NetworkImage(movie.fullPosterPath),
                                fit: BoxFit.cover
                            ),
                        ),
                    );
                },
            )
        );
    }
}
