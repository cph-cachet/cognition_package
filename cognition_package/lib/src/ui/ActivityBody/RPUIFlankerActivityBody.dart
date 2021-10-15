part of cognition_package_ui;

var score = 0;

class Flanker extends StatefulWidget {
  @override
  _FlankerState createState() => _FlankerState();
}

class _FlankerState extends State<Flanker> {
  // Dynamically load cards from database
  List<Widget> flankerCards = [];

  List<FlankerCard> cards(amount) {
    List<FlankerCard> cards = [];
    for (var i = 0; i < amount; i++) {
      if (Random().nextBool()) {
        cards.add(FlankerCard("→"));
      } else {
        cards.add(FlankerCard("←"));
      }
    }
    return cards;
  }

  @override
  initState() {
    super.initState();
    flankerCards = cards(50);
  }

  @override
  Widget build(BuildContext context) {
    // Stack of cards that can be swiped. Set width, height, etc here.
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.7,
      // Important to keep as a stack to have overlay of cards.
      child: Stack(
        children: flankerCards,
      ),
    );
  }
}

// https://pub.dev/packages/flutter_swipable

class FlankerCard extends StatelessWidget {
  // Made to distinguish cards
  // Add your own applicable data here

  final String direction;
  FlankerCard(this.direction);

  final String right = "→";
  final String left = "←";

  String distractors() {
    print("new card");
    String ret = "";
    for (var i = 0; i < 3; i++) {
      if (i == 1) {
        ret += direction;
      } else if (Random().nextBool()) {
        ret += "←←";
      } else {
        ret += "→→";
      }
    }
    return ret;
  }

  void onSwipeRight(Offset) {
    print("swiped right");
    if (direction == "→") {
      score = score + 1;
    }
    print(score);
  }

  void onSwipeLeft(Offset) {
    print("swiped left");
    if (direction == "←") {
      score = score + 1;
    }
    print(score);
  }

  @override
  Widget build(BuildContext context) {
    return Swipable(
      // Set the swipable widget
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Color(0xFFFDA69D),
        ),
        child: Center(
            child: Text(
          distractors(),
          style: TextStyle(fontSize: 55, color: Colors.white),
        )),
      ),
      onSwipeRight: onSwipeRight,
      onSwipeLeft: onSwipeLeft,
      // onSwipeRight, left, up, down, cancel, etc...
    );
  }
}

class RPUIFlankerActivityBody extends StatefulWidget {
  final RPFlankerActivity activity;
  final Function(dynamic) onResultChange;
  final RPActivityEventLogger eventLogger;

  RPUIFlankerActivityBody(this.activity, this.eventLogger, this.onResultChange);

  @override
  _RPUI_FlankerActivityBodyState createState() =>
      _RPUI_FlankerActivityBodyState();
}

class _RPUI_FlankerActivityBodyState extends State<RPUIFlankerActivityBody> {
  late ActivityStatus activityStatus;
  int corsiSpan = 0;
  late int highlightedBlockID;
  late List<int> blocks;
  List<int> tapOrder = [];
  bool readyForTap = false;
  bool finishedTask = false;
  bool failedLast = false;
  String taskInfo = '';
  int numberOfBlocks = 2;

  @override
  initState() {
    super.initState();
    blocks = List.generate(9, (index) => index);
    if (widget.activity.includeInstructions) {
      activityStatus = ActivityStatus.Instruction;
      widget.eventLogger.instructionStarted();
    } else {
      activityStatus = ActivityStatus.Test;
      widget.eventLogger.testStarted();
      startTest();
    }
  }

  void startTest() async {
    setState(() {
      taskInfo = 'Wait';
      readyForTap = false;
      tapOrder.clear();
      blocks.shuffle();
    });
    await Future.delayed(Duration(seconds: 1));
    for (int i = 0; i < numberOfBlocks; i++) {
      if (activityStatus == ActivityStatus.Test && this.mounted) {
        setState(() {
          highlightedBlockID = blocks[i];
        });
      }
      await Future.delayed(Duration(milliseconds: 1000));
    }
    if (activityStatus == ActivityStatus.Test && this.mounted) {
      setState(() {
        readyForTap = true;
        taskInfo = 'Go';
      });
    }

    Timer(Duration(seconds: widget.activity.lengthOfTest), () {
      //when time is up, change window and set result
      if (this.mounted) {
        widget.eventLogger.testEnded();
        widget.onResultChange({"Correct swipes": score});
        if (widget.activity.includeResults) {
          widget.eventLogger.resultsShown();
          setState(() {
            activityStatus = ActivityStatus.Result;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (activityStatus) {
      case ActivityStatus.Instruction:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'swipe the cards in the direction of the middle arrow on each card, disregarding all other arrows on the cards',
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            'packages/research_package/assets/images/Corsiintro.png'))),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                onPressed: () {
                  widget.eventLogger.instructionEnded();
                  widget.eventLogger.testStarted();
                  setState(() {
                    activityStatus = ActivityStatus.Test;
                  });
                  startTest();
                },
                child: Text(
                  'Ready',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        );
        break;
      case ActivityStatus.Test:
        return Scaffold(
          // appBar: AppBar(
          //   title: Text('FLANKER TEST SCORE: ${score}'),
          // ),
          body: Center(child: Flanker()),
        );
      case ActivityStatus.Result:
        return Center(
          child: Text(
            'results:  ${score}',
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
        );
      default:
        return Container();
    }
  }
}
