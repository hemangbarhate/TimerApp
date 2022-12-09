import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:drop_shadow/drop_shadow.dart';

import '../models/StopwatchOperation.dart';
import '../models/stop_watch.dart';

class TimerCard extends StatefulWidget {
  final Stopwatch1 stopwatch;
  int index;

  TimerCard(this.stopwatch, this.index, {super.key});

  @override
  State<TimerCard> createState() => _TimerCardState();
}

class _TimerCardState extends State<TimerCard>
    with SingleTickerProviderStateMixin {
  late TimerController _timerController;
  var _time = 60;
  Color redorgreen = Color(0xffed1c24); //green Color(0xff59ed1d)

  final _Time = [
    60,
    59,
    58,
    57,
    56,
    55,
    54,
    53,
    52,
    51,
    50,
    49,
    48,
    47,
    46,
    45,
    44,
    43,
    42,
    41,
    40,
    39,
    38,
    37,
    36,
    35,
    34,
    33,
    32,
    31,
    30,
    29,
    28,
    27,
    26,
    25,
    24,
    23,
    22,
    21,
    20,
    19,
    18,
    17,
    16,
    15,
    14,
    13,
    12,
    11,
    10,
    9,
    8,
    7,
    6,
    5,
    4,
    3,
    2,
    1
  ];

  @override
  void initState() {
    // initialize timer controller
    _timerController = TimerController(this);
    super.initState();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: Colors.black54,
            shape: const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(30))),
            title: const Text(
              ' ',
              style: TextStyle(color: Colors.white),
            ),
            content: Column(
              children: [
                const Text(
                  '--------------------------',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  widget.stopwatch.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                const Text(
                  '--------------------------',
                  style: TextStyle(color: Colors.white),
                ),
                SimpleTimer(
                  duration: Duration(minutes: _time),
                  controller: _timerController,
                  timerStyle: TimerStyle.expanding_sector,
                  onStart: handleTimerOnStart,
                  onEnd: handleTimerOnEnd,
                  valueListener: timerValueChangeListener,
                  backgroundColor: Colors.black,
                  progressIndicatorColor: Colors.grey,
                  progressIndicatorDirection:
                  TimerProgressIndicatorDirection.clockwise,
                  progressTextCountDirection:
                  TimerProgressTextCountDirection.count_down,
                  progressTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  strokeWidth: 10,
                ),
                const Text(
                  '---------------------------------',
                  style: TextStyle(color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          _timerController.add(const Duration(minutes: 1),
                              start: true);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: const Text("+1",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25))),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                        onPressed: () {
                          _timerController.add(const Duration(minutes: 5),
                              start: true);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: const Text("+5",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25))),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                        onPressed: () {
                          _timerController.subtract(const Duration(minutes: 1),
                              start: true);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text("-1",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25))),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                        onPressed: () {
                          _timerController.subtract(const Duration(minutes: 5),
                              start: true);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text("-5",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25))),
                  ],
                ),
                const Text(
                  '---------------------------------',
                  style: TextStyle(color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => Padding(
                            padding: const EdgeInsets.fromLTRB(0, 180, 0, 180),
                            child: AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                              title: const Text('Edit Time(minutes)',style: TextStyle(color: Colors.black),),
                              content: Column(
                                children: [
                                  DropdownButtonFormField(
                                      value: _time,
                                      items: _Time.map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.toString()),
                                      )).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          _time = val as int;
                                        });
                                      }),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _timerController.subtract(
                                        const Duration(minutes: 60),
                                        start: true);
                                    _timerController.add(Duration(minutes: _time),
                                        start: true);
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(backgroundColor: Colors.green),
                      iconSize: 30,
                      icon: const Icon(Icons.edit,color: Colors.white,),
                    ),
                    IconButton(
                      onPressed: _timerController.reset,
                      style: TextButton.styleFrom(backgroundColor: Colors.red),
                      iconSize: 40,
                      icon: const Icon(Icons.restart_alt,color: Colors.white,),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: (){
                    Navigator.pop(context, 'Cancel');
                    },
                  child: const Text('Go Back',style: TextStyle(color: Colors.white,fontSize: 20),),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 14, 10, 0),
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/${widget.stopwatch.title}1.jpg'), fit: BoxFit.cover),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/${widget.stopwatch.title}.png',
                    height: 60, width: 90),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 135,
                  child: SimpleTimer(
                    duration: Duration(minutes: _time),
                    controller: _timerController,
                    timerStyle: TimerStyle.expanding_sector,
                    onStart: handleTimerOnStart,
                    onEnd: handleTimerOnEnd,
                    valueListener: timerValueChangeListener,
                    backgroundColor: Colors.transparent,
                    progressIndicatorColor: Colors.grey,
                    progressIndicatorDirection:
                        TimerProgressIndicatorDirection.clockwise,
                    progressTextCountDirection:
                        TimerProgressTextCountDirection.count_down,
                    progressTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    strokeWidth: 10,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          // color: Colors.white,
                          child: IconButton(
                            onPressed: _timerController.start,
                            iconSize: 35,
                            icon: const Icon(
                              Icons.play_arrow,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          // color: Colors.white,
                          margin: EdgeInsets.all(5),
                          child: IconButton(
                            onPressed: _timerController.pause,
                            iconSize: 35,
                            icon: const Icon(
                              Icons.pause,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          // color: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              Provider.of<StopwatchOperation>(context, listen: false)
                                  .removeStopwatch(widget.index);
                            },
                            style: TextButton.styleFrom(backgroundColor: Colors.blue),
                            iconSize: 35,
                            icon: const Icon(
                              Icons.delete_outline,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void timerValueChangeListener(Duration timeElapsed) {}
  void handleTimerOnStart() {
    print("timer has just started");
  }

  void handleTimerOnEnd() {
    print("timer has ended");
  }
}
