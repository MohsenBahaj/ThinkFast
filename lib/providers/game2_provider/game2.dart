import 'dart:math';
import 'package:flutter/material.dart';

class SequenceProvider with ChangeNotifier {
  List<int> _sequence = [];
  int _missingIndex = -1;
  int _level = 1;
  bool _isCorrect = false;
  int _score = 0;

  List<int> get sequence => _sequence;
  int get missingIndex => _missingIndex;
  bool get isCorrect => _isCorrect;
  int get score => _score;
  int get level => _level;

  // Generate a new sequence
  void generateSequence() {
    List<int> newSequence = [];
    int start = Random().nextInt(10) + 1;
    int step = Random().nextInt(5) + 1;

    for (int i = 0; i < 5; i++) {
      newSequence.add(start + i * step);
    }

    // Hide a random element
    _missingIndex = Random().nextInt(newSequence.length);
    newSequence[_missingIndex] = -1; // Placeholder for missing value

    _sequence = newSequence;
    _isCorrect = false;
    Future.delayed(Duration(microseconds: 200));
    notifyListeners();
  }

  // Check the answer
  void checkAnswer(int answer) {
    int prev = _missingIndex > 0 ? _sequence[_missingIndex - 1] : _sequence[0];
    int next = _missingIndex < _sequence.length - 1
        ? _sequence[_missingIndex + 1]
        : _sequence[_sequence.length - 1];

    int step = next - prev;
    int correctAnswer = prev + step;

    if (answer == correctAnswer) {
      _isCorrect = true;
      _score += 10;
      nextLevel();
    } else {
      _isCorrect = false;
    }
    notifyListeners();
  }

  // Move to the next level
  void nextLevel() {
    _level++;
    generateSequence();
  }

  // Reset the game
  void resetGame() {
    _level = 1;
    _score = 0;
    generateSequence();
  }
}
