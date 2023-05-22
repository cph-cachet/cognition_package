part of cognition_package_ui;

/// The [RPUITappingActivityBody] class defines the UI for the
/// instructions and test phase of the continuous visual tracking task.
class RPUITappingActivityBody extends StatefulWidget {
  /// The [RPUITappingActivityBody] activity.
  final RPTappingActivity activity;

  /// The results function for the [RPUITappingActivityBody].
  final void Function(dynamic) onResultChange;

  /// the [RPActivityEventLogger] for the [RPUITappingActivityBody].
  final RPActivityEventLogger eventLogger;

  /// The [RPUITappingActivityBody] constructor.
  const RPUITappingActivityBody(
      this.activity, this.eventLogger, this.onResultChange,
      {super.key});

  @override
  RPUITappingActivityBodyState createState() => RPUITappingActivityBodyState();
}

class RPUITappingActivityBodyState extends State<RPUITappingActivityBody> {
  int taps = 0;
  String countdown = '';
  bool setStart = false;
  bool indexStart = false;
  bool counting = true;
  ActivityStatus activityStatus = ActivityStatus.Instruction;
  Timer? timer;

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

  void startTest() async {
    setState(() {
      activityStatus = ActivityStatus.Test;
    });
    widget.eventLogger.instructionEnded();
    widget.eventLogger.testStarted();
    for (int i = 3; i > 0; i--) {
      if (mounted) {
        setState(() {
          countdown = i.toString();
        });
      }
      await Future<dynamic>.delayed(const Duration(seconds: 1));
    }
    if (mounted) {
      //remove countdown text
      setState(() {
        counting = false;
      });
    }
    timer = Timer(Duration(seconds: widget.activity.lengthOfTest), () {
      //when time is up, change window and set result
      widget.eventLogger.testEnded();
      widget.onResultChange({'Total taps': taps});
      if (widget.activity.includeResults) {
        widget.eventLogger.resultsShown();
        if (mounted) {
          setState(() {
            activityStatus = ActivityStatus.Result;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = CPLocalizations.of(context)!;
    switch (activityStatus) {
      case ActivityStatus.Instruction:
        return Column(
          //entry screen with rules and start button
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                '${locale.translate('tapping.instructions')} ${widget.activity.lengthOfTest} ${locale.translate('seconds')}.',
                style: const TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 20,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            'packages/cognition_package/assets/images/Tappingintro.png'))),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: OutlinedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                onPressed: () async {
                  startTest();
                },
                child: Text(
                  locale.translate('ready'),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        );
      case ActivityStatus.Test:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            counting
                ? Text(countdown, style: const TextStyle(fontSize: 50))
                : Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: OutlinedButton(
                                child: SizedBox(
                                  height: 200,
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                ),
                                onPressed: () {
                                  widget.eventLogger.addCorrectGesture(
                                      'Button tap', 'Pressed the left button');
                                  setState(() {
                                    taps++;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: OutlinedButton(
                                child: SizedBox(
                                  height: 200,
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                ),
                                onPressed: () {
                                  widget.eventLogger.addCorrectGesture(
                                      'Button tap', 'Pressed the right button');
                                  setState(() {
                                    taps++;
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ))
          ],
        );
      case ActivityStatus.Result:
        return Container(
          alignment: Alignment.center,
          child: Text(
            ' $taps ${locale.translate('tapping.final_score')}',
            style: const TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
        );
    }
  }
}
