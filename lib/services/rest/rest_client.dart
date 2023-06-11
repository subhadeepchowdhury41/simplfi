import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:simplfi/utils/loggs.dart';

class RestClient {
  static Future<Map<String, dynamic>?> sendGetReq(String path,
      {Map<String, String>? extraHeaders}) async {
    Map<String, dynamic>? result;
    //debugPrint('path: $path, headers: $extraHeaders');
    await http.get(Uri.parse(path), headers: {
      'Content-Type': 'application/json',
      ...?extraHeaders,
    }).then((res) {
      if (res.body.isNotEmpty) {
        // debugPrint(res.body);
        result = jsonDecode(res.body) as Map<String, dynamic>;
      }
    });
    // debugPrint('result : $result');
    return result;
  }

  static Future<Map<String, dynamic>?> sendPostReq(String path,
      {Map<String, dynamic>? body, Map<String, String>? extraHeaders}) async {
    Map<String, dynamic>? result;
    await http
        .post(Uri.parse(path),
            headers: {'Content-Type': 'application/json', ...?extraHeaders},
            body: jsonEncode(body))
        .then((res) {
      logWithColor(message: 'Response----> ${res.body}', color: 'cyan');
      if (res.body.isNotEmpty) {
        result = jsonDecode(res.body);
      }
    });
    return result;
  }

  static Future<bool?> sendDeleteRequest(
    String path,
  ) async {
    bool? result;
    await http.delete(Uri.parse(path)).then((res) {
      if (res.statusCode != 200) {
        logWithColor(message: 'delete from http request');
        return;
      }
      result = true;
    });
    return result;
  }

  //
  static Future<Map<String, dynamic>?> sendMultipartRequest(String path,
      {Map<String, dynamic>? body,
      required List<Map<String, dynamic>> files,
      Map<String, String>? extraheaders}) async {
    Map<String, dynamic>? result;
    var req = http.MultipartRequest('POST', Uri.parse(path));
    body?.forEach((key, value) {
      req.fields[key] = value;
    });
    req.headers.addAll({'Content-Type': 'application/json', ...?extraheaders});
    for (var element in files) {
      final File file = element['file'];
      final fileStream = http.ByteStream(file.openRead());
      final fileLength = await file.length();
      final multipartFile = http.MultipartFile(
          element['name'], fileStream, fileLength,
          filename: file.path.split('/').last);
      req.files.add(multipartFile);
    }
    await req.send().then((res) async {
      if (res.statusCode != 200) {
        return;
      }
      final body = await res.stream.bytesToString();
      result = jsonDecode(body);
    });
    return result;
  }
}
