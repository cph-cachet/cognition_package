part of cognition_package_ui;

var score = 0;
var wrongSwipe = 0;
var rightSwipe = 0;
bool even = false;

class Flanker extends StatefulWidget {
  final numberOfCards;
  const Flanker({this.numberOfCards});
  @override
  _FlankerState createState() => _FlankerState(numberOfCards);
}

class _FlankerState extends State<Flanker> {
  final int numberOfCards;
  List<Widget> flankerCards = [];
  List<FlankerCard> cards(amount) {
    List<FlankerCard> cards = [];
    for (var i = 0; i < amount; i++) {
      even = !even;
      if (Random().nextBool()) {
        cards.add(
          FlankerCard('→', even ? 0xff003F6E : 0xffC32C39),
        );
      } else {
        cards.add(FlankerCard('←', even ? 0xff003F6E : 0xffC32C39));
      }
    }
    return cards;
  }

  _FlankerState(this.numberOfCards);

  @override
  initState() {
    super.initState();
    flankerCards = cards(numberOfCards);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Stack(
        children: flankerCards,
      ),
    );
  }
}

class FlankerCard extends StatelessWidget {
  final int color;
  final String direction;
  FlankerCard(this.direction, this.color);

  final String right = '→';
  final String left = '←';

  String distractors() {
    String ret = '';
    for (var i = 0; i < 3; i++) {
      if (i == 1) {
        ret += direction;
      } else if (Random().nextBool()) {
        ret += '←←';
      } else {
        ret += '→→';
      }
    }
    return ret;
  }

  void onSwipeRight(offset) {
    if (direction == '→') {
      rightSwipe = rightSwipe + 1;
    } else {
      wrongSwipe = wrongSwipe + 1;
    }
    score = score + 1;
  }

  void onSwipeLeft(offset) {
    if (direction == '←') {
      rightSwipe = rightSwipe + 1;
    } else {
      wrongSwipe = wrongSwipe + 1;
    }
    score = score + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Swipable(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Color(color),
        ),
        child: Center(
            child: Text(
          distractors(),
          style: TextStyle(fontSize: 55, color: Colors.white),
        )),
      ),
      onSwipeRight: onSwipeRight,
      onSwipeLeft: onSwipeLeft,
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

// ignore: camel_case_types
class _RPUI_FlankerActivityBodyState extends State<RPUIFlankerActivityBody> {
  late ActivityStatus activityStatus;

  @override
  initState() {
    super.initState();
    if (widget.activity.includeInstructions) {
      activityStatus = ActivityStatus.Instruction;
      widget.eventLogger.instructionStarted();
    } else {
      activityStatus = ActivityStatus.Test;
      widget.eventLogger.testStarted();
      startTest();
    }
  }

  late Timer testTimer;
  int seconds = 0;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    testTimer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (seconds < 0) {
            timer.cancel();
          } else {
            seconds = seconds + 1;
          }
        },
      ),
    );
  }

  void startTest() async {
    startTimer();
    await Future.delayed(Duration(seconds: 1));

    if (score == widget.activity.numberOfCards) {
      if (this.mounted) {
        widget.eventLogger.testEnded();

        var flankerScore =
            widget.activity.calculateScore({'mistakes': wrongSwipe});
        RPFlankerResult flankerResult =
            new RPFlankerResult(identifier: 'FlankerTaskResult');
        var taskResults = flankerResult.makeResult(
            wrongSwipe, rightSwipe, seconds, flankerScore);
        testTimer.cancel();
        seconds = 0;
        widget.onResultChange(taskResults.results);
        if (widget.activity.includeResults) {
          widget.eventLogger.resultsShown();
          setState(() {
            activityStatus = ActivityStatus.Result;
          });
        }
      }
    }

    Timer(Duration(seconds: widget.activity.lengthOfTest), () {
      if (this.mounted) {
        widget.eventLogger.testEnded();
        var flankerScore =
            widget.activity.calculateScore({'mistakes': wrongSwipe});
        RPFlankerResult flankerResult =
            new RPFlankerResult(identifier: 'FlankerTaskResult');
        var taskResults = flankerResult.makeResult(
            wrongSwipe, rightSwipe, seconds, flankerScore);
        testTimer.cancel();
        seconds = 0;
        widget.onResultChange(taskResults.results);
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
    if (score == widget.activity.numberOfCards) {
      if (this.mounted) {
        widget.eventLogger.testEnded();
        var flankerScore =
            widget.activity.calculateScore({'mistakes': wrongSwipe});
        RPFlankerResult flankerResult =
            new RPFlankerResult(identifier: 'FlankerTaskResult');
        var taskResults = flankerResult.makeResult(
            wrongSwipe, rightSwipe, seconds, flankerScore);
        testTimer.cancel();
        widget.onResultChange(taskResults.results);
        if (widget.activity.includeResults) {
          widget.eventLogger.resultsShown();
          setState(() {
            activityStatus = ActivityStatus.Result;
          });
        }
      }
    }

    switch (activityStatus) {
      case ActivityStatus.Instruction:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Swipe the cards in the direction of the middle arrow on each card.',
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Ignore all other arrows on the cards, they are only there to distract you',
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
                            'packages/cognition_package/assets/images/flanker.png'))),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              // ignore: deprecated_member_use
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
      case ActivityStatus.Test:
        return Scaffold(
          body: Center(
              child: Flanker(numberOfCards: widget.activity.numberOfCards)),
        );
      case ActivityStatus.Result:
        return Center(
          child: Text(
            'results:  $score',
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
        );
      default:
        return Container();
    }
  }
}
