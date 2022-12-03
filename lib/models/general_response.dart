import 'package:movies_app/models/models.dart';

class GeneralResponse {
    GeneralResponse({
        required this.page,
        required this.movies,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> movies;
    int totalPages;
    int totalResults;

    factory GeneralResponse.fromJson(String str) => GeneralResponse.fromMap(json.decode(str));

    factory GeneralResponse.fromMap(Map<String, dynamic> json) => GeneralResponse(
        page: json["page"],
        movies: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}
