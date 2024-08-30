//Flutter Http Paketi İle İnternetten Veri Alma İşlemleri videosunda kullanılan kodlar:
//Video linki: https://youtu.be/Fj-2YcMrGCY
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Liste extends StatefulWidget {
  const Liste({super.key});

  @override
  State<Liste> createState() => _ListeState();
}

class _ListeState extends State<Liste> {
  List<dynamic> liste = [];

  Future<void> verileriGetir() async {
    var sonuc = await http
        .get(Uri.parse("https://potterapi-fedeperin.vercel.app/en/books"));
    liste = jsonDecode(sonuc.body) ?? [];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    verileriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anasayfa"),
      ),
      body: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: "arama yapın...",
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: liste.length,
              itemBuilder: (context, index) {
                dynamic veri = liste[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(veri["cover"] ?? ""),
                  ),
                  title: Text(veri["title"], maxLines: 1),
                  subtitle: Text(veri["description"], maxLines: 2),
                  onTap: () {},
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(height: 0);
              },
            ),
          ),
        ],
      ),
    );
  }
}
