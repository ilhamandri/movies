import 'package:cached_network_image/cached_network_image.dart';
import 'package:credibooktest/module/details/movie_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class MovieDetailsView extends GetView<MovieDetailController> {
  MovieDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          'Movie Detail',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Screenshot(
                    controller: controller.screenshotController,
                    key: controller.imageKey,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: 'https://image.tmdb.org/t/p/w500/${controller.movie.value.backdrop_path!}',
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.movie.value.title!,
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  controller.movie.value.overview!,
                                ),
                                const SizedBox(height: 54),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.share),
                        onPressed: () => controller.shareImage(),
                        label: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Share to WhatsApp'),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.teal[700],
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7)))),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
