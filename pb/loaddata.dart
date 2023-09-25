import 'package:pocketbase/pocketbase.dart';
import 'package:ubuapp/mockup/data.dart';

Future<void> loaddata() async {
  final String apiUrl = 'http://127.0.0.1:8090';
  final pb = PocketBase(apiUrl);

  final String collectionName = 'UBU_APP';

  for (int i = 0; i < 100; i++) {
    final course = randomCourse();

    final body = {
      "courseid": course[0],
      "title": course[1],
      "lecturer": course[2],
    };

    final record = await pb.collection('UBU_APP').create(body: body);

    if (record != null) {
      print('Row $i Loaded');
    } else {
      print('Failed to load Row $i');
    }
  }

  print('Done loading 100 rows');
}

void main() {
  loaddata();
}
