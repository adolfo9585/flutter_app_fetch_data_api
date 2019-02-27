import 'package:flutter/material.dart';
import 'package:flutter_app_fetch_data_api/models/Photo.dart';

class PhotoDetailScreen extends StatelessWidget{

  final Photo objPhoto;

  PhotoDetailScreen ({Key key, @required this.objPhoto}) : super (key:key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("${objPhoto.title}"),
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
                child: Column(
                  children: <Widget>[
                Image.network('${objPhoto.thumbnailUrl}'),

                    RaisedButton(
                      child: Text('Prender'),
                      onPressed: () {
                        Image.network('https://via.placeholder.com/150/771796');
                      },
                    ),
                  ],
                )
            )
        )
    );
  }
}