import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_fetch_data_api/models/Photo.dart';
import 'package:flutter_app_fetch_data_api/screens/PhotoDetailScreen.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response =
  await client.get('https://jsonplaceholder.typicode.com/photos');

  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>
List<Photo> parsePhotos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}


class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),

      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),

    );
  }
}

class PhotosList extends StatelessWidget {

  final List<Photo> photos;
  PhotosList({Key key, this.photos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        //return Image.network(photos[index].thumbnailUrl);
        return ListTile(
          title: Text(photos[index].title),
          subtitle: Text(photos[index].thumbnailUrl),
          leading: Image.network(photos[index].thumbnailUrl),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => PhotoDetailScreen(objPhoto: photos[index]),
              ),
            );
          },
        );
      },
    );
  }
}