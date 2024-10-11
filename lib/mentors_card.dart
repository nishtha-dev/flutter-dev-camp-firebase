import 'package:flutter/material.dart';
import 'package:flutter_devcamp_ui/mentors_details.dart';
import 'package:flutter_devcamp_ui/mentors_model.dart';

class MentorsUI extends StatelessWidget {
  final MentorsModel mentorsModel;

  const MentorsUI({required this.mentorsModel, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MentorsDetails(
                  mentorsModel: mentorsModel,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          width: 100,
          child: Stack(
            children: [
              SizedBox(
                width: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Hero(
                    tag: 'mentor-img',
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              mentorsModel.img,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(mentorsModel.name),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: Image.asset('assets/images/flutter.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
