import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';


/// Clase de les cartes dels actors
class CastingCards extends StatelessWidget {
    final int idMovie;
    
    const CastingCards({required this.idMovie});

    @override
    Widget build(BuildContext context) {
        final MoviesProvider moviesProvider = Provider.of(context, listen: false);

        return FutureBuilder(
            future: moviesProvider.getMovieCast(idMovie),
            builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {

                // Comproba di hi ha valors, sino mostras el circularProgress
                if (!snapshot.hasData) {
                    return Container(
                        child: const Center(child: CircularProgressIndicator()),
                    );
                }

                final casting = snapshot.data!;

                return Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    width: double.infinity,
                    height: 180,
                    // color: Colors.red,
                    child: ListView.builder(
                        itemCount: casting.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) => _CastCard(cast: casting[index])
                    ),
                );
            },
        );
    }
}

/// Clase especifica per cada carta de cada actor
class _CastCard extends StatelessWidget {
    final Cast cast;

    const _CastCard({required this.cast});

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 110,
            height: 100,
            child: Column(
                children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                            placeholder: const AssetImage('assets/no-image.jpg'),
                            image: NetworkImage(cast.fullProfilePath),
                            height: 140,
                            width: 100,
                            fit: BoxFit.cover,
                        ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                        cast.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                    )
                ],
            ),
        );
    }
}
