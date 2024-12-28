// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:test/constants/colors/colors.dart';

// class Option {
//   final int value;
//   bool isCorrect;
//   Color color;

//   Option({
//     required this.value,
//     this.isCorrect = false,
//     this.color = const Color(0xFF172B40), // Default color
//   });
// }

// class PlayerProgress {
//   double progress = 0.0;

//   void updateProgress(bool correctAnswer) {
//     if (correctAnswer) {
//       progress += 0.1; // Increase progress
//     } else {
//       progress -= 0.1; // Decrease progress
//     }

//     if (progress >= 1.0) {
//       progress = 1.0; // Player wins or reach 100%
//     }

//     if (progress <= 0.0) {
//       progress = 0.0; // Ensure the progress doesn't go below 0
//     }
//   }
// }

// class GameState with ChangeNotifier {
//   bool gameOver = false;
//   int seconds = 0;
//   PlayerProgress player1Progress = PlayerProgress();
//   PlayerProgress player2Progress = PlayerProgress();
//   List<Option> player1Options = [];
//   List<Option> player2Options = [];
//   Color player1Border = AppColors.backgrounColor;
//   Color player2Border = AppColors.backgrounColor;
//   List<int> currentQuestion1 = [];
//   List<int> currentQuestion2 = [];
//   bool appBarAcive = false;
//   void generateNextQuestion(int playerId, int level, int max, int min) {
//     int range = max - min;
//     List<int> currentQuestion =
//         playerId == 1 ? currentQuestion1 : currentQuestion2;
//     List<Option> options = [];
//     if (level == 1) {
//       currentQuestion = [
//         Random().nextInt(range) + min + 1,
//         Random().nextInt(range) + min + 1,
//         0
//       ];

//       currentQuestion[2] = currentQuestion[0] + currentQuestion[1];
//       range = (currentQuestion[2] + 10) - (currentQuestion[2] - 10);
//       options = List.generate(5, (index) {
//         return Option(
//             value: Random().nextInt(range) + (currentQuestion[2] - 10) + 1);
//       });

//       options.add(Option(
//           value: currentQuestion[2],
//           isCorrect: true)); // Add the correct answer
//       options.shuffle();
//     } else if (level == 2) {
//       currentQuestion = [
//         Random().nextInt(range) + 1,
//         Random().nextInt(range) + 1,
//         0
//       ];
//       currentQuestion[2] = currentQuestion[0] - currentQuestion[1];

//       options = List.generate(5, (index) {
//         return Option(value: Random().nextInt(range) + 1);
//       });

//       options.add(Option(
//           value: currentQuestion[2],
//           isCorrect: true)); // Add the correct answer
//       options.shuffle();
//     } else if (level == 3) {
//       currentQuestion = [
//         Random().nextInt(range) + 1,
//         Random().nextInt(range) + 1,
//         Random().nextInt(range) + 1,
//         0
//       ];
//       currentQuestion[3] =
//           currentQuestion[0] + currentQuestion[1] * currentQuestion[2];

//       options = List.generate(5, (index) {
//         return Option(value: Random().nextInt(currentQuestion[3]) + 1);
//       });

//       options.add(Option(
//           value: currentQuestion[3],
//           isCorrect: true)); // Add the correct answer
//       options.shuffle();
//     } else if (level == 4) {
//       currentQuestion = [
//         Random().nextInt(range) + 1, // a
//         Random().nextInt(range) + 1, // b
//         0, // c (temporary placeholder)
//         0 // result
//       ];

//       // Compute a * b first
//       int product = currentQuestion[0] * currentQuestion[1];

//       // Generate c such that result is non-negative
//       currentQuestion[2] = Random().nextInt(product + 1); // c <= product

//       // Calculate the result
//       currentQuestion[3] = product - currentQuestion[2];

//       // Generate options
//       options = List.generate(5, (index) {
//         return Option(
//             value: Random().nextInt(product + 1)); // Ensure valid range
//       });

//       // Add the correct answer
//       options.add(Option(
//         value: currentQuestion[3],
//         isCorrect: true,
//       ));

//       // Shuffle options
//       options.shuffle();
//     }

//     if (playerId == 1) {
//       player1Options = options;
//       currentQuestion1 = currentQuestion;
//     } else {
//       player2Options = options;
//       currentQuestion2 = currentQuestion;
//     }
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       notifyListeners();
//     });
//   }

//   void handlePlayerAnswer(
//       int playerId, int selectedIndex, int level, int max, int min) async {
//     // Make the function async
//     List<Option> options = playerId == 1 ? player1Options : player2Options;
//     int correctAnswer = 0;
//     if (level == 1 || level == 2) {
//       correctAnswer = playerId == 1 ? currentQuestion1[2] : currentQuestion2[2];
//     } else if (level == 3 || level == 4) {
//       correctAnswer = playerId == 1 ? currentQuestion1[3] : currentQuestion2[3];
//     }

//     Option selectedOption = options[selectedIndex];

//     if (selectedOption.value == correctAnswer) {
//       if (playerId == 1) {
//         player1Border = AppColors.level1;
//       } else if (playerId == 2) {
//         player2Border = AppColors.level1;
//       }
//       notifyListeners();
//       selectedOption.color = AppColors.level1; // Correct answer
//       updateProgress(playerId, true); // Update progress
//       generateNextQuestion(playerId, level, max, min); // Next question
//     } else {
//       if (playerId == 1) {
//         player1Border = AppColors.level4;
//       } else if (playerId == 2) {
//         player2Border = AppColors.level4;
//       }

//       selectedOption.color = AppColors.level4; // Incorrect answer
//       notifyListeners();
//       updateProgress(playerId, false); // Update progress
//     }

//     // Wait for 1 second before resetting borders
//     await Future.delayed(Duration(milliseconds: 200));

//     // Reset border colors after delay
//     player2Border = AppColors.backgrounColor;
//     player1Border = AppColors.backgrounColor;
//     notifyListeners();
//   }

//   void updateProgress(int playerId, bool correctAnswer) {
//     if (playerId == 1) {
//       player1Progress.updateProgress(correctAnswer);
//     } else {
//       player2Progress.updateProgress(correctAnswer);
//     }

//     if (player1Progress.progress >= 1.0 || player2Progress.progress >= 1.0) {
//       gameOver = true;
//     }
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       notifyListeners();
//     });
//   }
// }
