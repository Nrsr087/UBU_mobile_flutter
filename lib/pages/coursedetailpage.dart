import 'package:flutter/material.dart';

class CourseDetailPage extends StatefulWidget {
  final dynamic course;

  CourseDetailPage({super.key, this.course});

  @override
  State<CourseDetailPage> createState() {
    return _StateCourseDetailPage();
  }
}

class _StateCourseDetailPage extends State<CourseDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course ${widget.course[1]}"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: const AssetImage('assets/images/coursebg.jpg'),
          fit: BoxFit.cover,
        )),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Center(child: Text('the descriptive detail.')),
        ),
      ),
    );
  }
}
