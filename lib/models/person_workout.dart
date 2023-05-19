import 'package:dio/dio.dart';

class PersonWorkout {
  int id;
  String name;
  String description;
  int userId;

  PersonWorkout(
      {required this.id,
      required this.name,
      required this.description,
      required this.userId});

  factory PersonWorkout.fromJson(Map<String, dynamic> json) {
    return PersonWorkout(
      id: json['ID_Person_workout'],
      name: json['Name'],
      description: json['Description'],
      userId: json['User_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID_Person_workout': id,
      'Name': name,
      'Description': description,
      'User_id': userId,
    };
  }
}

class PersonWorkoutApiService {
  final Dio _dio = Dio();

  Future<List<PersonWorkout>> getPersonWorkouts() async {
    try {
      final response = await _dio.get('http://localhost:5000/person_workouts');
      return (response.data as List)
          .map((workout) => PersonWorkout.fromJson(workout))
          .toList();
    } catch (e) {
      throw Exception('Failed to get person workouts: $e');
    }
  }

  Future<void> addPersonWorkout(PersonWorkout workout) async {
    try {
      await _dio.post('http://localhost:5000/person_workout',
          data: workout.toJson());
    } catch (e) {
      throw Exception('Failed to add person workout: $e');
    }
  }

  Future<void> updatePersonWorkout(PersonWorkout workout) async {
    try {
      await _dio.put('http://localhost:5000/person_workout/${workout.id}',
          data: workout.toJson());
    } catch (e) {
      throw Exception('Failed to update person workout: $e');
    }
  }

  Future<void> deletePersonWorkout(int id) async {
    try {
      await _dio.delete('http://localhost:5000/person_workout/$id');
    } catch (e) {
      throw Exception('Failed to delete person workout: $e');
    }
  }
}
