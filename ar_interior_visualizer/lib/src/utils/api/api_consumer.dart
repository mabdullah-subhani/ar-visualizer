import 'dart:typed_data';
import 'package:ar_interior_visualizer/src/utils/constants/text_strings.dart';
import 'package:http/http.dart' as http;

import '../popups/loaders.dart';

class ApiConsumer {
  Future<Uint8List> removeImageBackgroundApi(String imagePath) async {
    try {
      ///request
      var requestApi = http.MultipartRequest(
          "POST", Uri.parse("https://api.remove.bg/v1.0/removebg"));

      //which image file to send - define
      requestApi.files
          .add(await http.MultipartFile.fromPath("image_file", imagePath));

      requestApi.headers
          .addAll({"X-API-Key": MyAppTexts.apiKeyRemoveImageBackground});

      ///send request and receive response
      final responseFromApi = await requestApi.send();

      // Check if the response status is successful (200 OK)
      if (responseFromApi.statusCode == 200) {
        // Convert the stream to bytes and return the result
        return await http.Response.fromStream(responseFromApi)
            .then((value) => value.bodyBytes);
      } else {
        // Handle errors based on status code
        MyAppLoaders.errorSnackBar(
            title: 'Oh Snap!',
            message: "Failed to remove background: ${responseFromApi.statusCode}"
        );
      }
    } catch (e) {
      // General error handling (e.g., network failure, timeout)
      MyAppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
    return Future.value(Uint8List(0)); // Return an empty Uint8List if an error occurs
  }
}
