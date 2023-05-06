import 'package:hive/hive.dart';
part 'weight_model.g.dart';

@HiveType(typeId: 0)
class Weight extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  double weight;

  Weight(this.date, this.weight);
}
