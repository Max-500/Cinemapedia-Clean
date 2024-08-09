import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MoviesHorizontalListview extends StatelessWidget {

  final List<Movie> movies;
  final String? title;
  final String? subtitle;

  final VoidCallback? loadNextPage;

  const MoviesHorizontalListview({super.key, required this.movies, this.title, this.subtitle, this.loadNextPage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          if(title != null || subtitle != null)
            _Title(title: title, subtitle: subtitle,),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return _SlideItem(movie: movies[index]);
              },
            )
          )
        ],
      ),
    );
  }
}

class _SlideItem extends StatelessWidget {

  final Movie movie;

  const _SlideItem({ required this.movie });

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(context).textTheme.titleSmall;
    final textStyleBody = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Imagen
          SizedBox(
            width: 175,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(movie.posterPath, fit: BoxFit.fill, loadingBuilder: (context, child, loadingProgress) {
                if( loadingProgress != null ) return const Center(child: CircularProgressIndicator(strokeWidth: 2,),);

                return FadeIn(child: child);
              },),
            ),
          ),

          const SizedBox(height: 10,),

          //* Titulo
          SizedBox(
            width: 175,
            child: Text( movie.title, maxLines: 1, style: textStyle, overflow: TextOverflow.ellipsis, ),
          ),

          //* Calificaciones
          SizedBox(
            width: 175,
            child: Row(
              children: [
                RatingBarIndicator(
                  rating: movie.voteAverage / 2,
                  itemCount: 5,
                  itemBuilder: (context, index) => const Icon( Icons.star_outlined, color: Colors.amber, ), 
                  itemSize: 15,
                ),
                Text('${movie.voteAverage}', style: textStyleBody.bodySmall,),
                const SizedBox(width: 10,),
                Text(HumanFormats.number(movie.popularity), style: textStyleBody.bodySmall,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {

  final String? title;
  final String? subtitle;

  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final TextStyle? titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if( title != null )
            Text(title!, style: titleStyle,),

          const Spacer(),

          if( subtitle != null )
            FilledButton.tonal(
              style: const ButtonStyle( visualDensity: VisualDensity.compact ),
              onPressed: () {
                
              },
              child: Text(subtitle!)
            ),
        ],
      ),
    );
  }
}