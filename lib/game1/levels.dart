import 'package:flutter/material.dart';
import 'package:test/constants/colors/colors.dart';
import 'package:test/game1/one_player.dart';
import 'package:test/game1/two_players.dart';

class ChooseLevel extends StatefulWidget {
  final int playersNumber;
  const ChooseLevel({super.key, required this.playersNumber});

  @override
  State<ChooseLevel> createState() => _ChooseLevelState();
}

class _ChooseLevelState extends State<ChooseLevel> {
  int selectedMin = 1;
  int selectedMax = 10;

  final TextEditingController minController = TextEditingController(text: "1");
  final TextEditingController maxController = TextEditingController(text: "10");

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    var levelContainerWidth = (width / 2) - 30;

    return Scaffold(
      backgroundColor: AppColors.backgrounColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.appColor,
        title: const Text(
          'ThinkFast',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(height: 50),
            const Text(
              "Choose Level : ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLevelButton(
                    context,
                    levelContainerWidth,
                    'Level 1: a + b',
                    AppColors.level1,
                    1,
                    widget.playersNumber),
                _buildLevelButton(
                    context,
                    levelContainerWidth,
                    'Level 2: a - b',
                    AppColors.level2,
                    2,
                    widget.playersNumber),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLevelButton(
                    context,
                    levelContainerWidth,
                    'Level 3: a * b + c',
                    AppColors.level3,
                    3,
                    widget.playersNumber),
                _buildLevelButton(
                    context,
                    levelContainerWidth,
                    'Level 4: a * b - c',
                    AppColors.level4,
                    4,
                    widget.playersNumber),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Enter The Range : ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildRangeInput('Min', minController, (value) {
                  setState(() {
                    selectedMin = int.tryParse(value) ?? selectedMin;
                  });
                }),
                _buildRangeInput('Max', maxController, (value) {
                  setState(() {
                    selectedMax = int.tryParse(value) ?? selectedMax;
                  });
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelButton(BuildContext context, double width, String label,
      Color color, int level, int numOfPlayers) {
    return GestureDetector(
      onTap: () {
        numOfPlayers == 2
            ? Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (c) => GameOneHomePage(
                    level: level,
                    min: selectedMin,
                    max: selectedMax,
                  ),
                ),
              )
            : Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (c) => OnePlayer(
                    level: level,
                    min: selectedMin,
                    max: selectedMax,
                  ),
                ),
              );
      },
      child: Container(
        height: 50,
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }

  Widget _buildRangeInput(String label, TextEditingController controller,
      Function(String) onChanged) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
        const SizedBox(width: 8), // Add spacing between text and input field
        SizedBox(
          width: 100, // Fixed width for TextFormField
          height: 40,
          child: TextFormField(
            controller: controller,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              fillColor: AppColors.appColor,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6), // Rounded border
              ),
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
