# labmobile3

Tugas Pertemuan 3 Praktikum Pemrograman Mobile Shift C

Nama    : Daniel Abdillah Arif
NIM     : H1D022055

# Penjelasan Source Code
1. Halaman Login
Pada halaman login SC-nya sama dengan pada Tugas 2, hanya merubah tampilan
2. Halaman Home Page
Pada halaman homepage hanya menambah tombol yang menuju ke halaman Quiz.
3. Side Menu
Pada Sidemenu menampilkan teks yang digunakan untuk menuju ke halaman lain, yaitu halaman home dan halaman quiz
4. Halaman Quiz
Pada halaman quiz, user akan mengerjakan lima soal yang ada kemudian akan ditampilkan skor dan username ketika sudah selesai mengerjakan soal.

- State Management dengan _QuizPageState
class _QuizPageState extends State<QuizPage> {
  List<Question> _questions = [
    Question('Apa ibu kota Jawa Tengah?', ['Semarang', 'Surabaya', 'Bandung'], 'Semarang'),
    Question('Di mana letak pegunungan Himalaya?', ['Asia', 'Eropa', 'Afrika'], 'Asia'),
    Question('Sungai terpanjang di dunia adalah?', ['Amazon', 'Nil', 'Yangtze'], 'Nil'),
    Question('Benua terbesar di dunia adalah?', ['Asia', 'Afrika', 'Amerika'], 'Asia'),
    Question('Pulau terbesar di Indonesia adalah?', ['Sumatra', 'Kalimantan', 'Jawa'], 'Kalimantan'),
  ];
  int _currentQuestionIndex = 0;
  int _score = 0;
  var namauser;
}
Di dalam kelas _QuizPageState, kita menyimpan daftar pertanyaan dalam variabel _questions, dan beberapa variabel seperti _currentQuestionIndex untuk melacak indeks pertanyaan saat ini, dan _score untuk menyimpan skor pengguna. namauser menyimpan nama pengguna yang akan diambil dari SharedPreferences.

- Memuat nama pengguna dengan _loadUsername
  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    namauser = prefs.getString('username');
    setState(() {});
  }
  Fungsi _loadUsername digunakan untuk mengambil nama pengguna yang telah disimpan sebelumnya di SharedPreferences.

- Method _answerQuestion
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
Metode _answerQuestion memeriksa apakah jawaban yang diberikan benar. Jika benar, skor ditambah satu. Kemudian, indeks pertanyaan diperbarui, dan jika semua pertanyaan telah dijawab, hasil kuis ditampilkan.

- Method _showResult
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
Metode _showResult menampilkan dialog hasil kuis setelah semua pertanyaan dijawab. Ini menunjukkan skor dan nama pengguna, serta tombol untuk kembali ke halaman sebelumnya.

# Sreenshot
Halaman Login:

![Halaman Login](login.png)

Halaman Home Page:

![Halaman Home Page](home.png)

Side Menu:

![Side Menu](sidemenu.png)

Halaman Quiz:

![Halaman Quiz](quiz.png)

Pop up Hasil Quiz:

![Pop up Hasil Quiz](quiz_result.png)