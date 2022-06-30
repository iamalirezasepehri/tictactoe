import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isturnO = true;
  List<String> XorOList = ['', '', '', '', '', '', '', '', ''];
  int filledbox = 0;
  bool gamehasresult = false;
  int scorex = 0;
  int scoreo = 0;
  String winnertitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('TicTacToe'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              cleargame();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Getscoreboard(),
            resetbutton(),
            getGridView(),
            getturn(),
          ],
        ),
      ),
    );
  }

  Widget getturn() {
    return Text(
      isturnO ? 'turn O' : 'turn X',
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ),
    );
  }

  Widget getGridView() {
    return Expanded(
      child: GridView.builder(
        itemCount: 9,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              tapped(index);
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Center(
                child: Text(
                  XorOList[index],
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: XorOList[index] == 'X' ? Colors.white : Colors.red,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void tapped(int index) {
    if (gamehasresult == true) {
      return;
    }
    setState(() {
      if (XorOList[index] != '') {
        return;
      }
      if (isturnO) {
        XorOList[index] = 'O';
        filledbox = filledbox + 1;
      } else {
        XorOList[index] = 'X';
        filledbox = filledbox + 1;
      }

      isturnO = !isturnO;
      checkwinner();
    });
  }

  void checkwinner() {
    if (XorOList[0] == XorOList[1] &&
        XorOList[0] == XorOList[2] &&
        XorOList[0] != '') {
      setresult(XorOList[0], 'the winner is ' + XorOList[0]);
      return;
    }
    if (XorOList[3] == XorOList[4] &&
        XorOList[3] == XorOList[5] &&
        XorOList[3] != '') {
      setresult(XorOList[3], 'the winner is ' + XorOList[3]);
      return;
    }
    if (XorOList[6] == XorOList[7] &&
        XorOList[6] == XorOList[8] &&
        XorOList[6] != '') {
      setresult(XorOList[6], 'the winner is ' + XorOList[6]);
      return;
    }
    if (XorOList[0] == XorOList[3] &&
        XorOList[0] == XorOList[6] &&
        XorOList[0] != '') {
      setresult(XorOList[0], 'the winner is ' + XorOList[0]);
      return;
    }
    if (XorOList[1] == XorOList[4] &&
        XorOList[1] == XorOList[7] &&
        XorOList[1] != '') {
      setresult(XorOList[1], 'the winner is ' + XorOList[1]);
      return;
    }
    if (XorOList[2] == XorOList[5] &&
        XorOList[2] == XorOList[8] &&
        XorOList[2] != '') {
      setresult(XorOList[2], 'the winner is ' + XorOList[2]);
      return;
    }
    if (XorOList[0] == XorOList[4] &&
        XorOList[0] == XorOList[8] &&
        XorOList[0] != '') {
      setresult(XorOList[0], 'the winner is ' + XorOList[0]);
      return;
    }
    if (XorOList[2] == XorOList[4] &&
        XorOList[2] == XorOList[6] &&
        XorOList[2] != '') {
      setresult(XorOList[2], 'the winner is ' + XorOList[2]);
      return;
    }
    if (filledbox == 9) {
      setresult('', 'draw');
    }
  }

  Widget Getscoreboard() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Player O',
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$scoreo',
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Player X',
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$scorex',
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  cleargame() {
    setState(() {
      for (int i = 0; i < XorOList.length; i++) {
        XorOList[i] = '';
      }
    });
    filledbox = 0;
  }

  setresult(String winner, String title) {
    gamehasresult = true;
    winnertitle = title;
    setState(() {
      if (winner == 'X') {
        scorex = scorex + 1;
      } else if (winner == 'O') {
        scoreo = scoreo + 1;
      } else {
        scorex = scorex + 1;
        scoreo = scoreo + 1;
      }
    });
  }

  Widget resetbutton() {
    return Visibility(
      visible: gamehasresult,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: Size(300, 30),
            primary: Colors.white,
            side: BorderSide(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            setState(() {
              gamehasresult = false;
              cleargame();
            });
          },
          child: Text(
            '$winnertitle ' + ',play again!',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}
