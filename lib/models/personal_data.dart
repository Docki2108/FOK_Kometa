class PersonalData {
  String? secondName;
  String? firstName;
  String? patronymic;
  String? mobileNumber;

  PersonalData(
      {this.secondName, this.firstName, this.patronymic, this.mobileNumber});

  factory PersonalData.fromJson(Map<String, dynamic> json) {
    return PersonalData(
      secondName: json['Second_name'],
      firstName: json['First_name'],
      patronymic: json['Patronymic'],
      mobileNumber: json['Mobile_number'],
    );
  }
}
