import 'package:flutter/material.dart';
import 'package:flutter_quiz/UI/answer_button.dart';
import 'package:flutter_quiz/UI/question_text.dart';
import 'package:flutter_quiz/pages/score_page.dart';

import '../model/questions.dart';
import '../model/quiz.dart';
import '../UI/correct_wrong_overlay.dart';

class QuizPage extends StatefulWidget {

  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Shah Martinez should write a tutorial book for Ray Wenderlich", true),
    new Question("Pizza should have pineapples", false),
    new Question("Trap rappers make sense", false),
    new Question("Swift rules", true),
    new Question("Ray Wenderlich is awesome!", true),
    new Question("Objective-C is concise", false),
    new Question("Mark Zuckerburg is human", false),
  ]);

  // question info
  String questionText;
  int questionNumber;
  bool isCorrect;

  // display state
  bool overlayShouldBeVisible = false;



  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(  // This is our main question page
          children: <Widget>[
            new AnswerButton(true,  () => handleAnswer(true) ),
            new QuestionText(question: questionText, questionNumber: questionNumber),
            new AnswerButton(false, () => handleAnswer(false) )
          ],
        ),
        (overlayShouldBeVisible == true) ? new CorrectWrongOverlay(
            isCorrect: isCorrect,
          onTap: () {
              currentQuestion = quiz.nextQuestion;
              this.setState(() {
                overlayShouldBeVisible = false;
                if (quiz.isQuizFinished) {
                  Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new ScorePage(quiz.score, quiz.length)), (Route route) => route == null );
                  return;
                }
                questionText = currentQuestion.question;
                questionNumber = quiz.questionNumber;
              });
          },) : new Container(),
      ],
    );

  }

  void handleAnswer(bool answer) {

    isCorrect = (answer == currentQuestion.answer);
    quiz.answer(isCorrect);
    setState(() {
      overlayShouldBeVisible = true;
    });
  }
}