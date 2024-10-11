import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devcamp_ui/mentors_card.dart';
import 'package:flutter_devcamp_ui/mentors_model.dart';
import 'package:flutter_devcamp_ui/screens/profile_screen.dart';

class FlutterDevCampUI extends StatefulWidget {
  const FlutterDevCampUI({super.key});

  @override
  State<FlutterDevCampUI> createState() => _FlutterDevCampUIState();
}

class _FlutterDevCampUIState extends State<FlutterDevCampUI> {
  bool isTopicsVisible = false;

  final List<MentorsModel> mentorsModel = [
    MentorsModel('assets/images/simon.jpeg', 'Simon',
        'https://www.linkedin.com/in/simonlightfoot/'),
    MentorsModel('assets/images/franklin.jpeg', 'Franklin',
        'https://www.linkedin.com/in/franklin-oladipo/'),
    MentorsModel('assets/images/nishtha.jpeg', 'Nishtha',
        'https://www.linkedin.com/in/nishtha-saraswat/'),
    MentorsModel('assets/images/renuka.jpeg', 'Renuka',
        'https://www.linkedin.com/in/renukakelkar/'),
    MentorsModel('assets/images/shree.jpeg', 'Shree',
        'https://www.linkedin.com/in/shrihriday/'),
    MentorsModel('assets/images/sumith.jpeg', 'Sumith',
        'https://www.linkedin.com/in/sumith-damodaran/'),
    MentorsModel('assets/images/yeasin.jpeg', 'Yeasin',
        'https://www.linkedin.com/in/mdyeasinsheikh/'),
    MentorsModel('assets/images/anthony.jpeg', 'Anthony',
        'https://www.linkedin.com/in/atuoha-anthony/'),
  ];

  final List<Widget> topics = [
    const Text('Introduction to flutter'),
    const Text('Flutter Basics and Layout'),
    const Text('Intro to state management Riverpod with API'),
    const Text('Riverpod with Firebase'),
    const Text('Flutter and API Integration'),
    const Text('Flutter with Firebase database , storage'),
    const Text('Riverpod With advance Concepts'),
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _userFeedback;
  final List<String> _userFeedbacks = [];

  final TextEditingController _textEditingCtrl = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Flutter DevCamp',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ProfileScreen()));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              )),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Welcome to Flutter DevCamp',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset('assets/images/devcamp_img2.jpg'),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isTopicsVisible = !isTopicsVisible;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          const WidgetStatePropertyAll<Color>(Colors.blue),
                      shape: WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    child: Text(
                      '${isTopicsVisible ? 'Hide' : 'Reveal'} Topics',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: isTopicsVisible,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: topics.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text('${index + 1}.'),
                          const SizedBox(width: 4),
                          topics[index],
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Mentors List',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: mentorsModel.length,
                    itemBuilder: (context, index) {
                      return MentorsUI(mentorsModel: mentorsModel[index]);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text(
                      'Write your feedback',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.check_circle_sharp,
                      color: Colors.green,
                    ),
                  ],
                ),
                _userFeedbacks.isEmpty
                    ? const SizedBox(height: 6)
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _userFeedbacks.length,
                        itemBuilder: (context, index) {
                          return Text(
                            _userFeedbacks[index],
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          );
                        }),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _textEditingCtrl,
                  decoration: InputDecoration(
                    label: const Text('Write your feedback'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _userFeedback = value;
                  },
                ),
                const SizedBox(height: 8),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showDialog(context);
                      }
                    },
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      backgroundColor: WidgetStateColor.resolveWith((states) {
                        if (states.contains(WidgetState.pressed)) {
                          return Colors.orange;
                        }
                        if (states.contains(WidgetState.disabled)) {
                          return Colors.amberAccent;
                        }
                        return Colors.green;
                      }),
                    ),
                    child: const Text(
                      'Submit your feedback',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Are you sure you want to submit your feedback'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (_userFeedback != null) {
                    setState(() {
                      _userFeedbacks.add(_userFeedback!);
                    });
                    _textEditingCtrl.clear();
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          );
        });
  }
}
