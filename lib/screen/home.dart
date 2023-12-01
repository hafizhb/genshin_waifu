import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:genshin_waifu/screen/screen_detail.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    // Panggil fetchUsers di initState
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genshin Waifu'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return buildCharacterItem(user, index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Panggil fetchUsers saat tombol ditekan
          fetchUsers();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget buildCharacterItem(dynamic user, int index) {
    final character_name = user['character_name'];
    final vision = user['vision'];
    final imageUrl = user['profile_picture_url'];

    return InkWell(
      onTap: () {
        // Navigasi ke halaman detail saat item diklik
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(characterDetail: user),
          ),
        );
      },
      child: ListTile(
        leading: Image.network(imageUrl),
        title: Text(character_name),
        subtitle: Text(vision),
      ),
    );
  }

  Future<void> fetchUsers() async {
    try {
      print('fetchUsers Called');
      const url = 'https://genshin-waifu-default-rtdb.asia-southeast1.firebasedatabase.app/character/.json';
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);

        if (json.containsKey('results')) {
          setState(() {
            users = json['results'];
          });
        } else {
          print('Results not found in JSON');
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }

      print('fetchUsers completed');
    } catch (error) {
      print('Error during fetchUsers: $error');
    }
  }
}
