class Exam {
  List<Questions>? questions;
  String? id;
  String? name;
  String? description;
  String? userOwnerId;
  String? createdAt;
  String? userOwnerName;
  bool? isPublic;

  Exam({this.questions});

  Exam.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Exam.fromJsonDatabase(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    userOwnerId = json['user_owner_id'];
    isPublic = json['isPublic'];
    createdAt = json['created_at'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['user_owner_id'] = userOwnerId;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? question;
  List<String>? choices;
  String? correctAnswer;

  Questions({this.question, this.choices, this.correctAnswer});

  Questions.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    choices = json['choices'].cast<String>();
    correctAnswer = json['correct_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['choices'] = choices;
    data['correct_answer'] = correctAnswer;
    return data;
  }
}
