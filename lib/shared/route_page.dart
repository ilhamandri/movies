import 'package:credibooktest/module/details/movie_detail_controller.dart';
import 'package:credibooktest/module/details/movie_details_view.dart';
import 'package:credibooktest/module/home/movies_controller.dart';
import 'package:credibooktest/module/home/movies_view.dart';
import 'package:credibooktest/shared/route_name.dart';
import 'package:get/get.dart';

class RoutePage {
  static final routes = [
    GetPage(
      name: RouteName.homePage,
      page: () => MoviewsView(),
      binding: BindingsBuilder(() => Get.put<MoviesController>(MoviesController())),
    ),
    GetPage(
      name: RouteName.movieDetail,
      page: () => MovieDetailsView(),
      binding: BindingsBuilder(() => Get.put<MovieDetailController>(MovieDetailController())),
    )
  ];
}
