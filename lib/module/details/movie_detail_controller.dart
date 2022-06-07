import 'dart:io';
import 'package:credibooktest/module/details/movie_detail_service.dart';
import 'package:credibooktest/module/details/movie_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class MovieDetailController extends GetxController {
  var movie = MovieModel().obs;
  var isLoading = true.obs;
  var args = Get.arguments;
  GlobalKey imageKey = GlobalKey();

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void onInit() {
    super.onInit();
    fetchMovieDetail();
  }

  fetchMovieDetail() async {
    final response = await MovieDetailService().fetchMovieDetail(args);
    MovieModel movieDetail = MovieModel.fromJson(response);
    movie.value = movieDetail;
    isLoading.value = false;
  }

  shareImage() async {
    final img = await screenshotController.capture(pixelRatio: 2);
    final directory = (await getApplicationDocumentsDirectory()).path;
    final File imageFile = File('$directory/tempImage.png');
    imageFile.writeAsBytesSync(img!);
    await Share.shareFiles(['$directory/tempImage.png'], text: 'Here is your shared image!');
  }
}
