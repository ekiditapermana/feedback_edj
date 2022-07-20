class SurveyModel {
  final int no;
  final String phoneNumber;
  final String notes;

  SurveyModel(
      {required this.no, required this.phoneNumber, required this.notes});

  factory SurveyModel.fromJson(Map<String, dynamic> json) => SurveyModel(
      no: json['no'], phoneNumber: json['phone_number'], notes: json['notes'],);
}
