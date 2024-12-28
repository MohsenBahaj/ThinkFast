import 'dart:math';
import 'package:flutter/material.dart';
import 'package:percent_indicator_premium/percent_indicator_premium.dart';
import 'package:provider/provider.dart';
import 'package:test/constants/colors/colors.dart';
import 'package:test/providers/game1_provider/game_1_provider.dart';
import 'package:test/providers/game1_provider/question_provider.dart';

class GameOneHomePage extends StatefulWidget {
  final int level;
  final int min;
  final int max;

  const GameOneHomePage(
      {super.key, required this.level, required this.min, required this.max});

  @override
  State<GameOneHomePage> createState() => _GameOneHomePageState();
}

class _GameOneHomePageState extends State<GameOneHomePage> {
  @override
  void initState() {
    super.initState();
    final gameState = Provider.of<GameState>(context, listen: false);
    gameState.generateNextQuestion(1, widget.level, widget.max, widget.min);
    gameState.generateNextQuestion(2, widget.level, widget.max, widget.min);
  }

  late GameState gameState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    gameState = Provider.of<GameState>(context, listen: false);
  }

  @override
  void dispose() {
    gameState.player1Progress.progress = 0.0;
    gameState.player2Progress.progress = 0.0;
    gameState.gameOver = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          gameState.appBarAcive = !gameState.appBarAcive;
        });
      },
      child: Scaffold(
        backgroundColor: AppColors.backgrounColor,
        appBar: AppBar(
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: AppColors.backgrounColor,
        ),
        body: gameState.gameOver
            ? Center(
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    Text(
                      'Player ${gameState.player1Progress.progress >= 1.0 ? '2' : '1'} Wins!',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                            color: AppColors.level1,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Center(
                            child: Text(
                              'Try Again',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    flex: 2,
                    child:
                        Consumer<GameState>(builder: (context, dynamic, child) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 3, color: dynamic.player1Border)),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Expanded(
                              child: GridView.count(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 2,
                                children:
                                    gameState.player1Options.map((option) {
                                  return GestureDetector(
                                    onTap: () => gameState.handlePlayerAnswer(
                                        1,
                                        gameState.player1Options
                                            .indexOf(option),
                                        widget.level,
                                        widget.max,
                                        widget.min),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: option.color,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Transform.rotate(
                                          angle: pi,
                                          child: Text(
                                            "${option.value}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Transform.rotate(
                              angle: pi,
                              child: Text(
                                (() {
                                  if (widget.level == 1) {
                                    return '${gameState.currentQuestion1[0]} + ${gameState.currentQuestion1[1]} = ?';
                                  } else if (widget.level == 2) {
                                    return '${gameState.currentQuestion1[0]} - ${gameState.currentQuestion1[1]} = ?';
                                  } else if (widget.level == 3) {
                                    return '${gameState.currentQuestion1[0]} + ${gameState.currentQuestion1[1]} * ${gameState.currentQuestion1[2]} = ?';
                                  } else if (widget.level == 4) {
                                    return '${gameState.currentQuestion1[0]} * ${gameState.currentQuestion1[1]} - ${gameState.currentQuestion1[2]} = ?';
                                  } else {
                                    return 'Invalid Level';
                                  }
                                })(),
                                style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 70),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Transform.rotate(
                                angle: pi,
                                child: HorizontalPercentIndicator(
                                    loadingPercent:
                                        gameState.player1Progress.progress),
                              ),
                            ),
                            Transform.rotate(
                              angle: pi,
                              child: Text(
                                'Player 2 ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      );
                    }),
                  ),
                  Divider(),
                  Expanded(
                    flex: 2,
                    child:
                        Consumer<GameState>(builder: (context, dynamic, child) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4, color: dynamic.player2Border)),
                        child: Column(
                          children: [
                            Text(
                              'Player 1 ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: HorizontalPercentIndicator(
                                  loadingPercent:
                                      gameState.player2Progress.progress),
                            ),
                            SizedBox(height: 20),
                            Text(
                              (() {
                                if (widget.level == 1) {
                                  return '${gameState.currentQuestion2[0]} + ${gameState.currentQuestion2[1]} = ?';
                                } else if (widget.level == 2) {
                                  return '${gameState.currentQuestion2[0]} - ${gameState.currentQuestion2[1]} = ?';
                                } else if (widget.level == 3) {
                                  return '${gameState.currentQuestion2[0]} + ${gameState.currentQuestion2[1]} * ${gameState.currentQuestion2[2]} = ?';
                                } else if (widget.level == 4) {
                                  return '${gameState.currentQuestion2[0]} * ${gameState.currentQuestion2[1]} - ${gameState.currentQuestion2[2]} = ?';
                                } else {
                                  return 'Invalid Level';
                                }
                              })(),
                              style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: GridView.count(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 2,
                                children:
                                    gameState.player2Options.map((option) {
                                  return GestureDetector(
                                    onTap: () => gameState.handlePlayerAnswer(
                                        2,
                                        gameState.player2Options
                                            .indexOf(option),
                                        widget.level,
                                        widget.max,
                                        widget.min),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: option.color,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${option.value}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
      ),
    );
  }
}
