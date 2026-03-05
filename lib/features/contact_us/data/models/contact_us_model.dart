class ContactUsModel {
  final String name;
  final String email;
  final String subject;
  final String body;

  ContactUsModel({
    required this.name,
    required this.email,
    required this.subject,
    required this.body,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "subject": subject,
      "body": body,
    };
  }
}