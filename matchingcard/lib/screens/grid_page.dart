import 'package:flutter/material.dart';
import 'package:matchingcard/utils/logic.dart';
import 'package:matchingcard/widgets/score.dart';

class grid_page extends StatefulWidget {
  Game game = Game(8);
  grid_page({super.key, required this.game});
  
  @override
  State<grid_page> createState() =>  _grid_pageState();
}

class _grid_pageState extends State<grid_page> {
  int tries = 0;
  int score = 0;
  int lives = 6;

  @override
  void initState() {
    super.initState();
    widget.game.initGame();
    setState(() {
      
    });
  }

  Future<void> _showMyDialog(String hey, String pr, String title) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Image.asset(hey),
                ),
                Text(pr),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text("Memory game",
                  style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                scoreBoard("Essais", "$tries"),
                scoreBoard("Score", "$score"),
                scoreBoard("Vie", "$lives"),
              ],
            ),
            SizedBox(
              height: screenWidth,
              width: screenWidth,
              child: GridView.builder(
                  itemCount: widget.game.gameImg!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.game.gameImg![index] = widget.game.cardslist[index];
                            widget.game.check.add({index: widget.game.cardslist[index]});
                          });
                          if (widget.game.check.length == 2) {
                            if (widget.game.check[0].values.first ==
                                widget.game.check[1].values.first) {
                              score += 1;
                              widget.game.check.clear();
                              tries++;
                               if(score == widget.game.cardcount/2){
                                    int i = 0;
                                    lives = 6;
                                    tries = 0;
                                    score = 0;
                                    for(i=0; i<widget.game.cardcount; i++){
                                      widget.game.gameImg![i] = widget.game.hiddenCardpath ;
                                    }
                                    widget.game.initGame();
                                    _showMyDialog("assets/images/heart-inside.png", "bien joué", "Victoire");
                                  }
                            } else {
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                setState(() {
                                  widget.game.gameImg![widget.game.check[0].keys.first] =
                                      widget.game.hiddenCardpath;
                                  widget.game.gameImg![widget.game.check[1].keys.first] =
                                      widget.game.hiddenCardpath;
                                  widget.game.check.clear();
                                  lives--;
                                  tries++;
                                  if (lives == 0) {
                                    int i = 0;
                                    lives = 6;
                                    tries = 0;
                                    score = 0;
                                    for(i=0; i<widget.game.cardcount; i++){
                                      widget.game.gameImg![i] = widget.game.hiddenCardpath ;
                                    }
                                    widget.game.initGame();
                                    _showMyDialog("assets/images/dead-head.png", "plus de vie", "Game over!");
                                  } 
                                 

                                });
                              });
                            }
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                              child: Image.asset(widget.game.gameImg![index],
                                  fit: BoxFit.cover)),
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
