import 'package:hive/hive.dart';

import '../hive/weight_model.dart';

class HiveService {
  static const String _boxName = 'weights';

  static Future<Box<Weight>> openBox(String email) async {
    return await Hive.openBox<Weight>('$_boxName-$email');
  }

  static Future<void> addWeight(String email, Weight weight) async {
    final box = await openBox(email);
    await box.add(weight);
  }

  static Future<List<Weight>> getWeights(String email) async {
    final box = await openBox(email);
    return box.values.toList().cast<Weight>();
  }

  static Future<void> deleteWeight(String email, Weight weight) async {
    final box = await openBox(email);
    final key = box.values.firstWhere((element) => element == weight).key;
    await box.delete(key);
  }
}
