import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/widgets/widgets.dart';

/// Es la clase que enseña la informació propia de cada pelicula
class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie; // Agafam Movie de els args de Navigator

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie,),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitile(movie: movie,),
                _Overview(movie: movie,),
                const _Subtitle(title: "Actores"),
                CastingCards(idMovie: movie.id),
                const _Subtitle(title: "Similares"),
                SimilarCards(idMovie: movie.id)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Es la clase dedicada a fer l'appBar extendible (SliverAppBar)
class _CustomAppBar extends StatelessWidget {
    final Movie movie;

    const _CustomAppBar({super.key, required this.movie});

    @override
    Widget build(BuildContext context) {
        // Exactament igual que la AppBaer però amb bon comportament davant scroll
        return SliverAppBar(
            backgroundColor: Colors.indigo,
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: const EdgeInsets.all(0),
                title: Container(
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    color: Colors.black12,
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                        movie.title,
                        style: const TextStyle(fontSize: 16),
                    ),
                ),
                background: FadeInImage(
                    placeholder: const AssetImage('assets/loading.gif'), // Imatge per defecte
                    image: NetworkImage(movie.fullBackdropPath), // Agafam al URL de la imatge
                    fit: BoxFit.cover,
                ),
            ),
        );
    }
}

/// Es la clase dedicada a fer l'appBar extendible (SliverAppBar)
class _PosterAndTitile extends StatelessWidget {
    final Movie movie;

    const _PosterAndTitile({super.key, required this.movie});

    @override
    Widget build(BuildContext context) {
        final TextTheme textTheme = Theme.of(context).textTheme;
        return Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                            placeholder: const AssetImage('assets/loading.gif'), // Imatge per defecte
                            image: NetworkImage(movie.fullPosterPath), // Agafam al URL de la imatge
                            height: 150,
                        ),
                    ),
                    const SizedBox(
                        width: 20,
                    ),
                    Expanded( // Es necesari, sino el overflow dels textes no funcionen
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    movie.title,
                                    style: textTheme.headline5,
                                    overflow: TextOverflow.ellipsis, // S'encarrega de que si s'exedeix dels limits posi (...)
                                    maxLines: 2,
                                ),
                                Text(
                                    movie.originalTitle,
                                    style: textTheme.subtitle1,
                                    overflow: TextOverflow.ellipsis, // S'encarrega de que si s'exedeix dels limits posi (...)
                                    maxLines: 2,
                                ),
                                Row(
                                    children: [
                                        const Icon(Icons.star_outline, size: 15, color: Colors.grey),
                                        const SizedBox(width: 5),
                                        Text(movie.voteAverage.toString(), style: textTheme.caption),
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


/// Es la clase dedicada a fer la descripcio
class _Overview extends StatelessWidget {
    final Movie movie;

    const _Overview({super.key, required this.movie});

    @override
    Widget build(BuildContext context) {
        return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
            movie.overview,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.subtitle1,
        ),
        );
    }
}

class _Subtitle extends StatelessWidget {
    final title;

    const _Subtitle({super.key, required this.title});

    @override
    Widget build(BuildContext context) {
        return Column(
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
            ],
        );
    }
}

