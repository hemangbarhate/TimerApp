import 'package:flutter/material.dart';
import 'package:simple_timer/simple_timer.dart';
import 'stop_watch.dart';
//controller

class StopwatchOperation extends ChangeNotifier{
  late List<Stopwatch1> stopwatches = [];

  List<Stopwatch1> get getStopwatches{
    return stopwatches;
  }

  void addStopwatch(String title){
    //edited
    Stopwatch1 stopwatch = Stopwatch1(title);
    stopwatches.add(stopwatch);
    notifyListeners();
  }

  void removeStopwatch(int index){
    stopwatches.removeAt(index);
    notifyListeners();
  }

// StopwatchOperation(){
//   addStopwatch("FirstGame");
// }
}