
import 'dart:math';

class Game{
  final String hiddenCardpath = "assets/images/square.png";
  List<String>? gameImg;
  final List<String> cardstart = [
    'assets/images/splash.png',
    'assets/images/coldheart.png',
    'assets/images/hearts.png',
    'assets/images/icarus.png',
    'assets/images/tribal-mask.png',
    'assets/images/heraldic-sun.png',
    'assets/images/love-howl.png',
    'assets/images/moai.png',
    'assets/images/maze.png',
    'assets/images/wrapping-star.png',
    'assets/images/orrery.png',
  ];

  final List<String> cardslist = [];

  List<Map<int, String>> check = [];
  int cardcount = 9;

  Game (int count){
    cardcount = count;
  }

  void shuffle([Random? random]) {
    // TODO: implement shuffle
  }

  void initGame(){
    int i = 0;
    int st = 0;
    cardslist.clear();
    cardstart.shuffle();
    for(i = 0; i<cardcount; i++){
      if(i <= (cardcount/2)-1){
        cardslist.add(cardstart[i]);
      } else {
        cardslist.add(cardstart[st]);
        st++;
      }
    }
    cardslist.shuffle();
    gameImg = List.generate(cardcount, (index) => hiddenCardpath);
  }
}