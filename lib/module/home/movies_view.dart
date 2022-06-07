import 'package:credibooktest/module/home/movies_controller.dart';
import 'package:credibooktest/widgets/movie_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class MoviewsView extends GetView<MoviesController> {
  MoviewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Top Rated Movies",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => controller.downloadPDF(controller.movies.value),
                          icon: const Icon(Icons.download),
                          label: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('Download PDF'),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.teal[700],
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7)))),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Obx(
                          () => LazyLoadScrollView(
                            onEndOfPage: () {
                              controller.fetchMovie();
                            },
                            scrollOffset: 200,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    MovieListTile(movieModel: controller.movies[index]),
                                  ],
                                );
                              },
                              itemCount: controller.movies.length,
                              shrinkWrap: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
