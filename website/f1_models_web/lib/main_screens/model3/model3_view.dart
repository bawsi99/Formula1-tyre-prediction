import 'dart:convert';

import 'package:f1_models_web/widgets/centered_view/centered_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model1/DataModel.dart';

class Model3View extends StatefulWidget {
  const Model3View({Key? key}) : super(key: key);

  @override
  State<Model3View> createState() => _Model3ViewState();
}

Future<DataModel> submitData(String pitstopNo, String tyreAge, String lapsLeft, String position, String raceTrack, String totalLaps, String tyre) async{
  http.Response response = await http.post(Uri.parse('http://127.0.0.1:5000/model3'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:jsonEncode(<String,String>{
        "pitstop_no" : pitstopNo,
        "tyre_age": tyreAge,
        "laps_left": lapsLeft,
        "position" : position,
        "race_track": raceTrack,
        "total_laps": totalLaps,
        "tyre" : tyre
      })
  );

  String resBody = response.body;
  //print(resBody);
  var data = json.decode(resBody);
  //print(data);

  if(response.statusCode == 201 || response.statusCode == 200){
    return dataModelFromJson(resBody);
  }
  else{
    throw Exception('Failed to submit data');
  }

}

class _Model3ViewState extends State<Model3View> {

  _Model3ViewState(){
    _selectedTyre = _tyresList[0];
    _selectedTrack = _trackList[0];
  }

  Future<DataModel>? _dataModel3;
  TextEditingController pitStopNoController3 = TextEditingController();
  TextEditingController tyreAgeController3 = TextEditingController();
  TextEditingController lapsLeftController3 = TextEditingController();
  TextEditingController positionController3 = TextEditingController();
  // TextEditingController racetrackController3 = TextEditingController();
  TextEditingController totalLapsController3 = TextEditingController();
  // TextEditingController tyreController3 = TextEditingController();
  String currentTyre3="", trackQual3="";
  String output = 'Tyre';

  final _tyresList = ["soft","medium","hard"];
  String? _selectedTyre="";
  String? tyreController3="";

  final _trackList = ["belgian","italian","emilia romagna","monza","tuscany","spanish","french","portuguese","silverstone","dutch","bahrain","austin","miami","hungary","abu dhabi","united states","bahrain","austrian","canada","styrian","russian","eifel","saudi arabian","australia","azerbaijan"];
  String? _selectedTrack = "";
  String? racetrackController3="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            ...List<int>.generate(1, (index) => index).map((e) => SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                  child: const Text('Using RL model',style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),),
                )
            )),
            ...List<int>.generate(1, (index) => index).map((e) => SliverToBoxAdapter(
              child: CenteredView(
                  child:Container(
                    padding: const EdgeInsets.all(50),
                    width: 800,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter pit stop number'),
                          controller: pitStopNoController3,
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter tyre age'),
                          controller: tyreAgeController3,
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter laps left'),
                          controller: lapsLeftController3,
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter position'),
                          controller: positionController3,
                        ),
                        const SizedBox(height: 10,),
                        DropdownButtonFormField(
                          value: _selectedTrack,
                          items: _trackList.map((e) => DropdownMenuItem(child: Text(e), value: e,)
                          ).toList(),
                          onChanged: (val){
                            setState(() {
                              _selectedTrack = val as String;
                              racetrackController3 = _selectedTrack;
                            });
                          },
                          decoration: const InputDecoration(
                              labelText: "Select the race track",
                              border: UnderlineInputBorder()
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter total laps'),
                          controller: totalLapsController3,
                        ),
                        const SizedBox(height: 10,),
                        DropdownButtonFormField(
                          value: _selectedTyre,
                          items: _tyresList.map((e) => DropdownMenuItem(child: Text(e), value: e,)
                          ).toList(),
                          onChanged: (val){
                            setState(() {
                              _selectedTyre = val as String;
                              tyreController3 = _selectedTyre;
                            });
                          },
                          decoration: const InputDecoration(
                              labelText: "Select the current tyre",
                              border: UnderlineInputBorder()
                          ),
                        ),
                        const SizedBox(height: 10,),
                        const SizedBox(height: 15,),
                        ElevatedButton(onPressed: () async{
                          if (tyreController3=="soft"){
                            currentTyre3 = "1";
                          }
                          if (tyreController3=="medium"){
                            currentTyre3 = "2";
                          }
                          if (tyreController3=="hard"){
                            currentTyre3 = "3";
                          }
                          if (racetrackController3=="belgian" || racetrackController3=="italian" || racetrackController3=="emilia romagna" || racetrackController3=="monza" || racetrackController3=="tuscany"){
                            trackQual3 = "0.5";
                          }
                          if (racetrackController3=="spanish" || racetrackController3=="french" || racetrackController3=="portuguese"){
                            trackQual3 = "0.4";
                          }
                          if (racetrackController3=="silverstone" || racetrackController3=="dutch" || racetrackController3=="bahrain" || racetrackController3=="austin" || racetrackController3=="miami" || racetrackController3=="hungary" || racetrackController3=="abu dhabi" || racetrackController3=="united states" || racetrackController3=="bahrain"){
                            trackQual3 = "0.3";
                          }
                          if (racetrackController3=="austrian" || racetrackController3=="canada" || racetrackController3=="styrian" || racetrackController3=="russian" || racetrackController3=="eifel" || racetrackController3=="saudi arabian"){
                            trackQual3 = "0.2";
                          }
                          if (racetrackController3=="australian" || racetrackController3=="azerbaijan"){
                            trackQual3 = "0.1";
                          }
                          String pitstopNo = pitStopNoController3.text.toString();
                          String tyreAge = tyreAgeController3.text.toString();
                          String lapsLeft = lapsLeftController3.text.toString();
                          String position = positionController3.text.toString();
                          String raceTrack = trackQual3;
                          String totalLaps = totalLapsController3.text.toString();
                          String tyre = currentTyre3;

                          // DataModel data = await
                          setState(() {
                            _dataModel3 = submitData(pitstopNo, tyreAge, lapsLeft, position, raceTrack, totalLaps, tyre);
                          });
                        }, child: const Text('PREDICT')
                        ),
                        const SizedBox(height: 30,),
                        Row(
                          children: [
                            const Expanded(child: Center(
                              child: Text('Recommended tyre change',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600)),
                            )),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                              decoration: BoxDecoration(color: const Color.fromARGB(
                                  255, 255, 24, 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(child: (_dataModel3 == null) ? Text(output,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w800),) : buildFutureBuilder()),
                            ),
                          ],
                        ),

                      ],
                    ),
                  )

              ),
            ),
            )
          ],
        )
    );
  }
  FutureBuilder<DataModel> buildFutureBuilder() {
    return FutureBuilder<DataModel>(
      future: _dataModel3,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.result, style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w600));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

