import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MovieSharePage(),
    );
  }
}

class MovieSharePage extends StatelessWidget {
  final List<MovieModel> movies = [
    MovieModel(
      "Suga: Road to D-DAY", 
      2024, 
      9.9, 
      "https://larepublica.cronosmedia.glr.pe/original/2024/03/05/65e7eebe11bb376bf307a6c2.jpg"
    ),
    MovieModel(
      "Love Yourself in Seoul", 
      2019, 
      10, 
      "https://i.pinimg.com/736x/21/5a/a9/215aa95fd84448fc5371c361343b3c2d.jpg"
    ),
    MovieModel(
      "BTS: Yet to Come", 
      2023, 
      9.8, 
      "https://pragativadi.com/wp-content/uploads/2022/12/1671579008-untitled-1-1000x580.jpg"
    ),
    MovieModel(
      "Burn the Stage: The Movie", 
      2018, 
      9.7, 
      "https://i.pinimg.com/1200x/2f/3f/e3/2f3fe3fec1feb4f4868888415eb11c86.jpg"
    ),
    MovieModel(
      "BTS: PERMISSION TO DANCE ON STAGE - LA", 
      2023, 
      9.5, 
      "https://pbs.twimg.com/media/FcKXpmmXgAMXATH.jpg"
    ),
    MovieModel(
      "Bring the Soul: The Movie", 
      2019, 
      9.6, 
      "https://cdn.unotv.com/images/2023/09/bring-the-soul-2-103609.jpg"
    ),

  ];

  MovieSharePage({Key? key}) : super(key: key);

  void _shareMovie(BuildContext context, MovieModel movie) {
    final movieData =
        'Título: ${movie.title}\nAño de lanzamiento: ${movie.releaseYear}\nRating: ${movie.rating}\nPoster URL: ${movie.posterUrl}';

    FlutterShare.share(
      title: 'Compartir Película',
      text: movieData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas'),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return ListTile(
            title: Text(movie.title!),
            subtitle: Text('Año: ${movie.releaseYear}, Rating: ${movie.rating}'),
            leading: Image.network(movie.posterUrl!),
            onTap: () => _shareMovie(context, movie),
          );
        },
      ),
    );
  }
}

class ShareMoviePage extends StatelessWidget {
  const ShareMoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final title = args['title'];
    final description = args['description'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Película'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Título: $title',
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Descripción: $description',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieModel {
  String? title;
  int? releaseYear;
  String? posterUrl;
  double? rating;

  MovieModel(this.title, this.releaseYear, this.rating, this.posterUrl);

  // Método para convertir el objeto MovieModel a un map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'releaseYear': releaseYear,
      'rating': rating,
      'posterUrl': posterUrl,
    };
  }

  // Método para crear un objeto MovieModel desde un map
  static MovieModel fromMap(Map<String, dynamic> map) {
    return MovieModel(
      map['title'],
      map['releaseYear'],
      map['rating'],
      map['posterUrl'],
    );
  }
}
