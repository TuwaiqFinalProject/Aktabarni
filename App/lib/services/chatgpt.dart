import 'dart:convert';
// ignore: unused_import
import 'dart:typed_data';
import 'package:final_project/models/exam_model.dart';
import 'package:final_project/models/request_data.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class GPTService {
  static const url = '---';
  static const key = '---';
  static const org = '---';
  File? selectedPdf;

  Future<Exam> getExam() async {
    final uri = Uri.parse(url);
    final request = await http.post(
      uri,
      headers: {
        'OpenAI-Organization': org,
        'Authorization': key,
        'Content-Type': 'application/json'
      },
      body: json.encode(
        {
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "system",
              "content":
                  "You are a teacher who create exams for student, Students will provide you with text and type of questions either multiple choices or true or false and number of questions and your job is to create for them questions from the text they provided, also with the right answer, response in a json format the questions will be list every question with key question and a list choices , questions in list and choices in list and correct answer if the user choose the multiple choices type give them four choices,the response have to be in this format in multiple choice or true or false question {questions:[{question : \"here is the question\",choices: [\"list of all choices either multiple choice or true or false\"],correct_answer:\"here the correct answer\"}]}"
            },
            {"role": "user", "content": "text: ${Data.text}"},
            {
              "role": "user",
              "content": "type of questions: ${Data.typOfQuestions}"
            },
            {
              "role": "user",
              "content": "number of questions: ${Data.numberOfQuestions}"
            }
          ]
        },
      ),
    );
    final jsonData = json.decode(request.body);
    print(
        'json type: ${jsonData['choices'][0]['message']['content'].runtimeType}');
    print('json data: ${jsonData['choices'][0]['message']['content']}');
    final decodeContent =
        json.decode(jsonData['choices'][0]['message']['content']);

    print('DATA TYPE: ${decodeContent.runtimeType}');
    print('DATA: $decodeContent');
    Exam exam = Exam.fromJson(decodeContent);
    print('Exam: ${exam.questions!.length}}');
    print('Exam type: ${exam.questions}');

    return exam;
  }

  // Function to handle PDF file selection.
  Future<bool> selectPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      // Uint8List? selectedPdf = result.files.single.bytes; // TODO : web only
      selectedPdf = File(result.files.single.path!);
      extractTextFromPDF(selectedPdf!);
      return true;
    }
    return false;
  }

  // TODO : if it is web , the type have to be "Uint8List" rather than "File"
  Future extractTextFromPDF(File file) async {
    //Load the PDF document
    final PdfDocument document =
        PdfDocument(inputBytes: file.readAsBytesSync());
    // final PdfDocument document =
    //     PdfDocument(inputBytes: file); // TODO : for web only

    //Create PDF text extractor to extract text
    PdfTextExtractor extractor = PdfTextExtractor(document);

    //Extract text
    Data.text = extractor.extractText();

    // Dispose the document
    document.dispose();
  }
}
