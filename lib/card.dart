import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chuck_norris_api/chuck_norris_api_model.dart';

class CardWidget extends StatelessWidget {
  final ChuckNorrisAPIModel apiModel;
  final Color color;

  const CardWidget(this.color, this.apiModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: 300,
        height: 400,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  textAlign: TextAlign.center,
                  apiModel.value,
                  style: const TextStyle(fontSize: 20),
                  maxLines: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.open_in_browser),
                      tooltip: 'Open in browser',
                      onPressed: () {
                        _launchURL(apiModel.url);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.star_outline),
                      tooltip: 'Add to favourites',
                      onPressed: () {
                        // TODO:
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }
}
