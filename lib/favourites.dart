import 'package:auto_size_text/auto_size_text.dart';
import 'package:chuck_norris_tinder/chuck_norris_api/chuck_norris_joke.dart';
import 'package:chuck_norris_tinder/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  FavouritesState createState() => FavouritesState();
}

class FavouritesState extends State<Favourites> {
  static final collection = FirebaseFirestore.instance.collection("favourites");
  late List<FavouritesEntry> list;

  void removeFromList(FavouritesEntry entry) {
    setState(() {
      list.remove(entry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: collection.get(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Loading());
        }
        list = snapshot.data!.docs
            .map((e) =>
                FavouritesEntry(this, ChuckNorrisJoke.fromJson(e.data())))
            .toList();
        return ListView(
          padding: const EdgeInsets.all(3),
          children: list,
        );
      },
    );
  }
}

class FavouritesEntry extends StatelessWidget {
  static final collection = FirebaseFirestore.instance.collection("favourites");
  final FavouritesState parent;
  final ChuckNorrisJoke apiModel;

  const FavouritesEntry(this.parent, this.apiModel, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(3),
      color: Color(apiModel.color!),
      child: Container(
        height: 150,
        margin: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: AutoSizeText(
                textAlign: TextAlign.center,
                apiModel.value,
                style: const TextStyle(fontSize: 18),
                maxLines: 12,
              ),
            ),
            SizedBox(
              child: IconButton(
                icon: const Icon(Icons.star),
                tooltip: 'Add to favourites',
                onPressed: () {
                  collection.doc(apiModel.id).delete();
                  parent.removeFromList(this);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
