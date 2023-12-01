import 'package:flutter/material.dart';
import 'package:genshin_waifu/screen/chara_detail.dart';

class DetailScreen extends StatelessWidget {
  final dynamic characterDetail;

  DetailScreen({required this.characterDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(characterDetail['character_name']),
      ),
      body: Padding(
        padding: EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              characterDetail['namecard_url'],
              width: double.infinity,
              height: 200.0,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipOval(
                  child: Image.network(
                    characterDetail['profile_picture_url'],
                    width: 125.0,
                    height: 125.0,
                    fit: BoxFit.cover,
                  ),
                ),
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${characterDetail['character_name']}'),
                  Text('Vision: ${characterDetail['vision']}'),
                  Text('Region: ${characterDetail['region']}'),
                  Text('Constellation: ${characterDetail['constellation']}'),
                  Text('Weapon: ${characterDetail['weapon_type']}'),
                  Text('BirthDay: ${characterDetail['birthday']}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
