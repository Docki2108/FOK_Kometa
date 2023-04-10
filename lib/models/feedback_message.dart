// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'user_model.dart';

// class FeedbackMessageModel {
//   int id_feedback_message;
//   String message;
//   UserModel supa_user;
//   FeedbackMessageModel({
//     required this.id_feedback_message,
//     required this.message,
//     required this.supa_user,
//   });

//   FeedbackMessageModel copyWith({
//     int? id_feedback_message,
//     String? message,
//     UserModel? supa_user,
//   }) {
//     return FeedbackMessageModel(
//       id_feedback_message: id_feedback_message ?? this.id_feedback_message,
//       message: message ?? this.message,
//       supa_user: supa_user ?? this.supa_user,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id_feedback_message': id_feedback_message,
//       'message': message,
//       'supa_user': supa_user.toMap(),
//     };
//   }

//   factory FeedbackMessageModel.fromMap(Map<String, dynamic> map) {
//     return FeedbackMessageModel(
//       id_feedback_message: map['id_feedback_message'] as int,
//       message: map['message'] as String,
//       supa_user: UserModel.fromMap(map['supa_user'] as Map<String, dynamic>),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory FeedbackMessageModel.fromJson(String source) =>
//       FeedbackMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() =>
//       'FeedbackMessageModel(id_feedback_message: $id_feedback_message, message: $message, supa_user: $supa_user)';

//   @override
//   bool operator ==(covariant FeedbackMessageModel other) {
//     if (identical(this, other)) return true;

//     return other.id_feedback_message == id_feedback_message &&
//         other.message == message &&
//         other.supa_user == supa_user;
//   }

//   @override
//   int get hashCode =>
//       id_feedback_message.hashCode ^ message.hashCode ^ supa_user.hashCode;
// }
