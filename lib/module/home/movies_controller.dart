import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:credibooktest/module/details/movie_model.dart';
import 'package:credibooktest/module/home/movies_response.dart';
import 'package:credibooktest/module/home/movies_services.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class MoviesController extends GetxController {
  RxList<MovieModel> movies = <MovieModel>[].obs;
  int page = 1;
  var isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchMovie();
    isLoading.value = false;
  }

  fetchMovie() async {
    final res = await MoviesServices().fetchMovies(page);
    MoviesResponse moviesResponse = MoviesResponse.fromJson(res);
    moviesResponse.movies!.forEach((element) {
      movies.add(element);
    });
    page++;
  }

  convertImageToBytes(MovieModel image) async {
    final ByteData bytes = await rootBundle.load('https://image.tmdb.org/t/p/w500/${image.backdrop_path}');
    final Uint8List list = bytes.buffer.asUint8List();
    return list;
  }

  downloadPDF(List<MovieModel> movies) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Text("Top Rated Movies", style: pw.TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            pw.SizedBox(height: 16),
            pw.Column(
              mainAxisSize: pw.MainAxisSize.min,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: movies.map((e) {
                return pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 8),
                  child: pw.Flexible(
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(e.title!),
                        pw.Text(e.vote_average!.toString()),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          ];
        },
      ),
    );

    Uint8List bytes = await pdf.save();

    final directory = await getApplicationDocumentsDirectory();
    final File documentFile = File('${directory.path}/movies.pdf');

    await documentFile.writeAsBytes(bytes);

    await OpenFile.open(documentFile.path);
  }
}
