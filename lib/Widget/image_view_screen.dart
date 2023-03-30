import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:path/path.dart';

class ImageViewerScreen extends StatelessWidget {
  String url;
  ImageViewerScreen({required this.url});

  @override
  Widget build(BuildContext context) {

    final PageController _pageController = PageController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Image"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.download_sharp),
            onPressed: () {
              final filename = basename(url);

              saveFile(context,url, filename);
              // downloadFile(filename);
            },
          ),
        ],
      ),
      body:Container(
          child: PhotoView(
            imageProvider: NetworkImage(url),
            maxScale: 200.0,
            backgroundDecoration: BoxDecoration(color: Colors.white),
            enableRotation: true,
          )
      )
    );
  }

  Future<bool> saveFile(BuildContext context,String url, String fileName) async {
    try {
      if (await _requestPermission(Permission.storage)) {
        Directory? directory;
        directory = await getExternalStorageDirectory();
        directory = Directory('/storage/emulated/0/Download/');

        File saveFile = File(directory.path + "/$fileName");
        if (kDebugMode) {
          print(saveFile.path);
        }
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          await Dio().download(
            url,
            saveFile.path,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                  'Successfully saved to Download folder',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
          );
        }
      }
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Download failed',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
}