import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_devcamp_ui/mentors_model.dart';


class MentorsDetails extends StatelessWidget {
  final MentorsModel mentorsModel;
  const MentorsDetails({required this.mentorsModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          mentorsModel.name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Hero(tag: 'mentor-img', child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(mentorsModel.img))),
            const SizedBox(height: 10),

            Row(
              children: [
                const Text('LinkedIn Profile => ',
                style: TextStyle(fontSize: 18),),
                InkWell(
                  onTap: () {
                    _launchUrl(Uri.parse(mentorsModel.url));
                  },
                  child: Text(
                    mentorsModel.name,
                    style: const TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        decorationColor: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
