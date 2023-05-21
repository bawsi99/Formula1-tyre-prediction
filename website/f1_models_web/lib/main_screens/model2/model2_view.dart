import 'dart:convert';

import 'package:f1_models_web/widgets/centered_view/centered_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model1/DataModel.dart';

class Model2View extends StatefulWidget {
  const Model2View({Key? key}) : super(key: key);

  @override
  State<Model2View> createState() => _Model2ViewState();
}

Future<DataModel> submitData(String pitstopNo, String tyreAge, String lapsLeft, String position, String raceTrack, String totalLaps, String tyre) async{
  http.Response response = await http.post(Uri.parse('http://127.0.0.1:5000/model2'),
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

class _Model2ViewState extends State<Model2View> {

  _Model2ViewState(){
    _selectedTyre = _tyresList[0];
    _selectedTrack = _trackList[0];
  }

  Future<DataModel>? _dataModel2;
  TextEditingController pitStopNoController2 = TextEditingController();
  TextEditingController tyreAgeController2 = TextEditingController();
  TextEditingController lapsLeftController2 = TextEditingController();
  TextEditingController positionController2 = TextEditingController();
  // TextEditingController racetrackController2 = TextEditingController();
  TextEditingController totalLapsController2 = TextEditingController();
  // TextEditingController tyreController2 = TextEditingController();
  String currentTyre2="", trackQual2="";
  String output = 'Tyre';

  final _tyresList = ["soft","medium","hard"];
  String? _selectedTyre="";
  String? tyreController2="";

  final _trackList = ["belgian","italian","emilia romagna","monza","tuscany","spanish","french","portuguese","silverstone","dutch","bahrain","austin","miami","hungary","abu dhabi","united states","bahrain","austrian","canada","styrian","russian","eifel","saudi arabian","australia","azerbaijan"];
  String? _selectedTrack = "";
  String? racetrackController2="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            ...List<int>.generate(1, (index) => index).map((e) => SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                  child: const Text('Using Random Forest model',style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),),
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
                          controller: pitStopNoController2,
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter tyre age'),
                          controller: tyreAgeController2,
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter laps left'),
                          controller: lapsLeftController2,
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter position'),
                          controller: positionController2,
                        ),
                        const SizedBox(height: 10,),
                        DropdownButtonFormField(
                          value: _selectedTrack,
                          items: _trackList.map((e) => DropdownMenuItem(child: Text(e), value: e,)
                          ).toList(),
                          onChanged: (val){
                            setState(() {
                              _selectedTrack = val as String;
                              racetrackController2 = _selectedTrack;
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
                          controller: totalLapsController2,
                        ),
                        const SizedBox(height: 10,),
                        DropdownButtonFormField(
                          value: _selectedTyre,
                          items: _tyresList.map((e) => DropdownMenuItem(child: Text(e), value: e,)
                          ).toList(),
                          onChanged: (val){
                            setState(() {
                              _selectedTyre = val as String;
                              tyreController2 = _selectedTyre;
                            });
                          },
                          decoration: const InputDecoration(
                              labelText: "Select the current tyre",
                              border: UnderlineInputBorder()
                          ),
                        ),
                        const SizedBox(height: 10,),
                        // TextFormField(
                        //   decoration: const InputDecoration(
                        //       border: OutlineInputBorder(),
                        //       labelText: 'Enter current tyre'),
                        //   controller: tyreController2,
                        // ),
                        const SizedBox(height: 15,),
                        ElevatedButton(onPressed: () async{
                          if (tyreController2=="soft"){
                            currentTyre2 = "1";
                          }
                          if (tyreController2=="medium"){
                            currentTyre2 = "2";
                          }
                          if (tyreController2=="hard"){
                            currentTyre2 = "3";
                          }
                          if (racetrackController2=="belgian" || racetrackController2=="italian" || racetrackController2=="emilia romagna" || racetrackController2=="monza" || racetrackController2=="tuscany"){
                            trackQual2 = "0.5";
                          }
                          if (racetrackController2=="spanish" || racetrackController2=="french" || racetrackController2=="portuguese"){
                            trackQual2 = "0.4";
                          }
                          if (racetrackController2=="silverstone" || racetrackController2=="dutch" || racetrackController2=="bahrain" || racetrackController2=="austin" || racetrackController2=="miami" || racetrackController2=="hungary" || racetrackController2=="abu dhabi" || racetrackController2=="united states" || racetrackController2=="bahrain"){
                            trackQual2 = "0.3";
                          }
                          if (racetrackController2=="austrian" || racetrackController2=="canada" || racetrackController2=="styrian" || racetrackController2=="russian" || racetrackController2=="eifel" || racetrackController2=="saudi arabian"){
                            trackQual2 = "0.2";
                          }
                          if (racetrackController2=="australian" || racetrackController2=="azerbaijan"){
                            trackQual2 = "0.1";
                          }
                          String pitstopNo = pitStopNoController2.text.toString();
                          String tyreAge = tyreAgeController2.text.toString();
                          String lapsLeft = lapsLeftController2.text.toString();
                          String position = positionController2.text.toString();
                          String raceTrack = trackQual2;
                          String totalLaps = totalLapsController2.text.toString();
                          String tyre = currentTyre2;

                          // DataModel data = await
                          setState(() {
                            _dataModel2 = submitData(pitstopNo, tyreAge, lapsLeft, position, raceTrack, totalLaps, tyre);
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
                              child: Center(child: (_dataModel2 == null) ? Text(output,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w800),) : buildFutureBuilder()),
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
      future: _dataModel2,
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

