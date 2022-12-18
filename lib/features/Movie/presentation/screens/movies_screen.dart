import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app_clean_arch/core/utils/app_constants.dart';
import 'package:movie_app_clean_arch/core/widgets/error_widget.dart';
import 'package:movie_app_clean_arch/features/Movie/presentation/cubit/movie_cubit.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_arch/features/Movie/injection_container.dart'
    as di;

class MainMoviesScreen extends StatelessWidget {
  const MainMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieCubit(
          nowPlayUseCase: di.sl(),
          topRatedUseCase: di.sl(),
          popularUseCase: di.sl())
        ..getNowPlaying(),
      child: BlocConsumer<MovieCubit, MovieState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetNowPlayingLoading) {
            return Scaffold(
              body: SpinKitCircle(color: AppColors.primaryColor),
            );
          }
          else if (state is GetNowPlayingFailure ||state is GetTopRatedFailure ||state is GetPopularFailure ) {
            return const ErrorScreen();
          }
          else if (state is GetNowPlayingSuccess) {
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  key: const Key('movieScrollView'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeIn(
                        duration: const Duration(milliseconds: 500),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 400.0,
                            viewportFraction: 1.0,
                            onPageChanged: (index, reason) {},
                          ),
                          items: state.nowPlayingList.map(
                            (item) {
                              return GestureDetector(
                                key: const Key('openMovieMinimalDetail'),
                                onTap: () {},
                                child: Stack(
                                  children: [
                                    ShaderMask(
                                      shaderCallback: (rect) {
                                        return const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black,
                                            Colors.black,
                                            Colors.transparent,
                                          ],
                                          stops: [0, 0.3, 0.5, 1],
                                        ).createShader(
                                          Rect.fromLTRB(
                                              0, 0, rect.width, rect.height),
                                        );
                                      },
                                      blendMode: BlendMode.dstIn,
                                      child: Image.network(
                                        AppConstants.formatImageLink(
                                            imageUrl: item.backdropPath),
                                        fit: BoxFit.cover,
                                        height: 500,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.circle,
                                                  color: Colors.redAccent,
                                                  size: 16.0,
                                                ),
                                                const SizedBox(width: 4.0),
                                                Text(
                                                  'Now Playing'.toUpperCase(),
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16.0),
                                            child: Text(
                                              item.title,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 24,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Popular",
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: const [
                                  Text('See More'),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16.0,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      FadeIn(
                        duration: const Duration(milliseconds: 500),
                        child: SizedBox(
                          height: 170.0,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            itemCount: state.popularList.length,
                            itemBuilder: (context, index) {
                              final movie = state.popularList[index];
                              return Container(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    /// TODO : NAVIGATE TO  MOVIE DETAILS
                                  },
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8.0)),
                                    child: CachedNetworkImage(
                                      width: 120.0,
                                      fit: BoxFit.cover,
                                      imageUrl: AppConstants.formatImageLink(
                                          imageUrl: movie.backdropPath),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Colors.grey[850]!,
                                        highlightColor: Colors.grey[800]!,
                                        child: Container(
                                          height: 170.0,
                                          width: 120.0,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(
                          16.0,
                          24.0,
                          16.0,
                          8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Top Rated",
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: const [
                                  Text('See More'),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16.0,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      FadeIn(
                        duration: const Duration(milliseconds: 500),
                        child: SizedBox(
                          height: 170.0,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            itemCount: state.topRatedList.length,
                            itemBuilder: (context, index) {
                              final movie = state.topRatedList[index];
                              return Container(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8.0)),
                                    child: CachedNetworkImage(
                                      width: 120.0,
                                      fit: BoxFit.cover,
                                      imageUrl: AppConstants.formatImageLink(
                                          imageUrl: movie.backdropPath),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Colors.grey[850]!,
                                        highlightColor: Colors.grey[800]!,
                                        child: Container(
                                          height: 170.0,
                                          width: 120.0,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 50.0),
                    ],
                  ),
                ),
              ),
            );
          }
          else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
