import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
    final String _baseURL = "api.themoviedb.org"; //Domini per a les consultes
    final String _apiKey = "ad868b296b4b3fe63fa47b97eda78826"; //Token de seguretat
    final String _language = "es-ES"; //Idioma de les consultes
    final String _page = "1";

    List<Movie> onDisplayMovie = [];
    List<Movie> onPopularMovie = [];
    List<Movie> onUpcomingMovie = [];
    List<Movie> onRatedMovie = [];

    Map<int, List<Cast>> casting = {};
    Map<int, List<Movie>> similar = {};

    MoviesProvider() { //Executam els cuatre metodes per obtenir les dades
        getOnDisplayMovies();
        getOnPopular();
        getOnUpcoming();
        getOnRated();
    }

    /// Agafam les pelicules actuals
    getOnDisplayMovies() async {
        var url = Uri.https(_baseURL, '3/movie/now_playing', {
            'api_key' : _apiKey,
            'language' : _language,
            'page' : _page
        });

        var response = await http.get(url);

        final nowPlayingResponse = GeneralDatesResponse.fromJson(response.body);

        onDisplayMovie = nowPlayingResponse.movies;

        notifyListeners(); //Notificam a tothom de que ya esta llest
    }

    /// Agafam les pelicules mes populars
    getOnPopular() async {
        var url = Uri.https(_baseURL, '3/movie/popular', {
            'api_key' : _apiKey,
            'language' : _language,
            'page' : _page
        });

        var response = await http.get(url);

        final popularResponse = GeneralResponse.fromJson(response.body);

        onPopularMovie = popularResponse.movies;

        notifyListeners(); //Notificam a tothom de que ya esta llest
    }

    /// Agafam les proximes pelicules
    getOnUpcoming() async {
        var url = Uri.https(_baseURL, '3/movie/upcoming', {
            'api_key' : _apiKey,
            'language' : _language,
            'page' : _page
        });

        var response = await http.get(url);

        final upcomingResponse = GeneralDatesResponse.fromJson(response.body);

        onUpcomingMovie= upcomingResponse.movies;

        notifyListeners(); //Notificam a tothom de que ya esta llest
    }

    /// Agafam les pelicules mes valorades
    getOnRated() async {
        var url = Uri.https(_baseURL, '3/movie/top_rated', {
            'api_key' : _apiKey,
            'language' : _language,
            'page' : _page
        });

        var response = await http.get(url);

        final ratedResponse = GeneralResponse.fromJson(response.body);

        onRatedMovie = ratedResponse.movies;

        notifyListeners(); //Notificam a tothom de que ya esta llest
    }

    ///  Refrescam totes les queries
    void refresh() {
        onDisplayMovie = [];
        onPopularMovie = [];
        onUpcomingMovie = [];
        onRatedMovie = [];
        notifyListeners(); //Notificam a tothom de que ya esta llest

        getOnDisplayMovies();
        getOnPopular();
        getOnUpcoming();
        getOnRated();
    }

    /// Agafa els actors de cada pelicula
    /// 
    /// [idMovie] El id de la pelicula
    /// RETURN Un future de llistes de Casting de actors
    Future<List<Cast>> getMovieCast(int idMovie) async {
        var url = Uri.https(_baseURL, '3/movie/$idMovie/credits', {
            'api_key' : _apiKey,
            'language' : _language
        });

        var response = await http.get(url);

        final creditResponse = CreditResponse.fromJson(response.body);

        casting[idMovie] = creditResponse.cast;

        return creditResponse.cast;
    }

    /// Agafa les pelicules similars d'una pelicula
    /// 
    /// [idMovie] El id de la pelicula
    /// RETURN Un future de llistes de les pelicules
    Future<List<Movie>> getSimilarFromMovie(int idMovie) async {
        var url = Uri.https(_baseURL, '3/movie/$idMovie/similar', {
            'api_key' : _apiKey,
            'language' : _language,
            'page' : _page
        });

        var response = await http.get(url);

        final similarResponse = GeneralResponse.fromJson(response.body);

        similar[idMovie] = similarResponse.movies;

        return similarResponse.movies;
    }

    /// Agafa les pelicules que coincidesquin amb el nom
    /// 
    /// [text] El texte a cercar
    /// RETURN Un future de llistes de les pelicules
    Future<List<Movie>> searchByName(String text) async {
        var url = Uri.https(_baseURL, '3/search/movie', {
            'api_key' : _apiKey,
            'language' : _language,
            'page' : _page,
            "query" : text
        });

        var response = await http.get(url);

        final similarResponse = GeneralResponse.fromJson(response.body);

        return similarResponse.movies;
    }
}