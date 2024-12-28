import 'package:flutter/material.dart';
import 'package:test/constants/colors/colors.dart';
import 'package:test/game1/levels.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgrounColor,
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: Text(
          'ThinkFast',
          style: TextStyle(color: Colors.white, fontFamily: "Inria Sans"),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => ChooseLevel(
                                playersNumber: 1,
                              )));
                    },
                    child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                          color: AppColors.level1,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.person, color: Colors.white, size: 60),
                          Text(
                            'one player',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => ChooseLevel(
                                playersNumber: 2,
                              )));
                    },
                    child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                          color: AppColors.level1,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.people, color: Colors.white, size: 60),
                          Text(
                            'Two players',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
