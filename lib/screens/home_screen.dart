import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/Timecard.dart';
import '../models/StopwatchOperation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _games = [
    "Bank Heist",
    "Escape from Tihar Jail",
    "Mission : Save India",
    "Murder @Singania Mansion",
    "Riddler's Den",
    "Yin Yang"
  ];
  final _counterTime = [
    60
  ];
  String _selectedValue = "Bank Heist";
  int _varTime = 60;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Image.asset('assets/Escape Games.png',height:50),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            TextEditingController _titlecontrol = TextEditingController();
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => Padding(
                padding: const EdgeInsets.fromLTRB(0, 200, 0, 250),
                child: AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  title: const Text('Add Name of Game'),
                  content: Column(
                    children: [
                      DropdownButtonFormField(
                          value: _selectedValue,
                          items: _games
                              .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedValue = val as String;
                            });
                          }),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<StopwatchOperation>(context, listen: false)
                            .addStopwatch(_selectedValue);
                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            );
          },
          backgroundColor: Colors.amber,
          splashColor: Colors.amberAccent,
          child: const Icon(Icons.add,size: 40,color: Colors.black,),
        ),
        body: Consumer<StopwatchOperation>(
            builder: (context, StopwatchOperation data, child) {
              return data.getStopwatches.isNotEmpty
                  ? ListView.builder(
                itemCount: data.getStopwatches.length,
                itemBuilder: (BuildContext context, int index) {
                  return TimerCard(data.stopwatches[index], index);
                },
              )
                  : const Center(
                child: Text(
                  "Add The Timer",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              );
            }),
      ),
    );
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async{
    bool? exitApp = await showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Really ??"),
            content:  const Text("Do yo really want to close app. Your data can be lost"),
            actions: [
              TextButton(onPressed: (){Navigator.of(context).pop(false);}, child: const Text("No"),),
              TextButton(onPressed: (){Navigator.of(context).pop(true);}, child: const Text("Yes"),),
            ],
          );
    },);
    return exitApp ?? false;
  }
}
