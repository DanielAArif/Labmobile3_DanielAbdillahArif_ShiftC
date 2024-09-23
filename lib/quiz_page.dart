import 'package:flutter/material.dart';
import 'package:labmobile3/sidemenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> _questions = [
    Question('Apa ibu kota Jawa Tengah?', ['Semarang', 'Surabaya', 'Bandung'],
        'Semarang'),
    Question('Di mana letak pegunungan Himalaya?', ['Asia', 'Eropa', 'Afrika'],
        'Asia'),
    Question('Sungai terpanjang di dunia adalah?', ['Amazon', 'Nil', 'Yangtze'],
        'Nil'),
    Question('Benua terbesar di dunia adalah?', ['Asia', 'Afrika', 'Amerika'],
        'Asia'),
    Question('Pulau terbesar di Indonesia adalah?',
        ['Sumatra', 'Kalimantan', 'Jawa'], 'Kalimantan'),
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;
  var namauser;

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    namauser = prefs.getString('username');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _answerQuestion(String answer) {
    if (_questions[_currentQuestionIndex].correctAnswer == answer) {
      setState(() {
        _score++;
      });
    }

    setState(() {
      _currentQuestionIndex++;
    });

    if (_currentQuestionIndex >= _questions.length) {
      _showResult();
    }
  }

  void _showResult() {
    _loadUsername();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Quiz Finished'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Your score: $_score/${_questions.length}'),
            Text('Username: $namauser'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: Text('Go to Home'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _loadUsername();
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Page'),
      ),
      drawer: SideMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_currentQuestionIndex < _questions.length) ...[
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _questions[_currentQuestionIndex].questionText,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: _questions[_currentQuestionIndex]
                              .answers
                              .map((answer) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () => _answerQuestion(answer),
                                child: Text(answer),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                Text(
                  'Quiz Finished!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'Your score: $_score/${_questions.length}',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  'Username: $namauser',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                  child: Text('Go to Home'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> answers;
  final String correctAnswer;

  Question(this.questionText, this.answers, this.correctAnswer);
}
