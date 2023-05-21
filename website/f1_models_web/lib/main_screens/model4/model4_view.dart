import 'dart:convert';

import 'package:f1_models_web/widgets/centered_view/centered_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model1/DataModel.dart';

// class Model1View extends StatelessWidget {
//   const Model1View({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//     );
//   }
// }

class Model4View extends StatefulWidget {
  const Model4View({Key? key}) : super(key: key);

  @override
  State<Model4View> createState() => _Model4ViewState();
}

Future<DataModel> submitData(String pitstopNo, String tyreAge,String lapsCompleted, String lapsLeft, String position, String raceTrack, String totalLaps, String H, String I, String J) async{
  http.Response response = await http.post(Uri.parse('http://127.0.0.1:5000/model4'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:jsonEncode(<String,String>{
        "pitstop_no" : pitstopNo,
        "tyre_age": tyreAge,
        "laps_completed": lapsCompleted,
        "laps_left": lapsLeft,
        "position" : position,
        "race_track": raceTrack,
        "total_laps": totalLaps,
        "H" : H,
        "I" : I,
        "J" : J
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

class _Model4ViewState extends State<Model4View> {

  _Model4ViewState(){
    _selectedTyre = _tyresList[0];
    _selectedTrack = _trackList[0];
  }

  Future<DataModel>? _dataModel4;
  TextEditingController pitStopNoController4 = TextEditingController();
  TextEditingController tyreAgeController4 = TextEditingController();
  TextEditingController lapsCompletedController4 = TextEditingController();
  TextEditingController lapsLeftController4 = TextEditingController();
  TextEditingController positionController4 = TextEditingController();
  // TextEditingController racetrackController4 = TextEditingController();
  TextEditingController totalLapsController4 = TextEditingController();
  // TextEditingController tyreController4 = TextEditingController();
  String H="", I="", J="", trackQual4="";
  String output = 'Tyre';

  final _tyresList = ["soft","medium","hard"];
  String? _selectedTyre="";
  String? tyreController4="";

  final _trackList = ["belgian","italian","emilia romagna","monza","tuscany","spanish","french","portuguese","silverstone","dutch","bahrain","austin","miami","hungary","abu dhabi","united states","bahrain","austrian","canada","styrian","russian","eifel","saudi arabian","australia","azerbaijan"];
  String? _selectedTrack = "";
  String? racetrackController4="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            ...List<int>.generate(1, (index) => index).map((e) => SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                  child: const Text('Using ANN model',style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),),
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
                          controller: pitStopNoController4,
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter tyre age'),
                          controller: tyreAgeController4,
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter laps completed'),
                          controller: lapsCompletedController4,
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter laps left'),
                          controller: lapsLeftController4,
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter position'),
                          controller: positionController4,
                        ),
                        const SizedBox(height: 10,),
                        DropdownButtonFormField(
                          value: _selectedTrack,
                          items: _trackList.map((e) => DropdownMenuItem(child: Text(e), value: e,)
                          ).toList(),
                          onChanged: (val){
                            setState(() {
                              _selectedTrack = val as String;
                              racetrackController4 = _selectedTrack;
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
                          controller: totalLapsController4,
                        ),
                        const SizedBox(height: 10,),
                        DropdownButtonFormField(
                          value: _selectedTyre,
                          items: _tyresList.map((e) => DropdownMenuItem(child: Text(e), value: e,)
                          ).toList(),
                          onChanged: (val){
                            setState(() {
                              _selectedTyre = val as String;
                              tyreController4 = _selectedTyre;
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
                          if (tyreController4=="soft"){
                            H = "0";
                            I = "0";
                            J = "1";
                          }
                          if (tyreController4=="medium"){
                            H = "0";
                            I = "1";
                            J = "0";
                          }
                          if (tyreController4=="hard"){
                            H = "1";
                            I = "0";
                            J = "0";
                          }
                          if (racetrackController4=="belgian" || racetrackController4=="italian" || racetrackController4=="emilia romagna" || racetrackController4=="monza" || racetrackController4=="tuscany"){
                            trackQual4 = "0.5";
                          }
                          if (racetrackController4=="spanish" || racetrackController4=="french" || racetrackController4=="portuguese"){
                            trackQual4 = "0.4";
                          }
                          if (racetrackController4=="silverstone" || racetrackController4=="dutch" || racetrackController4=="bahrain" || racetrackController4=="austin" || racetrackController4=="miami" || racetrackController4=="hungary" || racetrackController4=="abu dhabi" || racetrackController4=="united states" || racetrackController4=="bahrain"){
                            trackQual4 = "0.3";
                          }
                          if (racetrackController4=="austrian" || racetrackController4=="canada" || racetrackController4=="styrian" || racetrackController4=="russian" || racetrackController4=="eifel" || racetrackController4=="saudi arabian"){
                            trackQual4 = "0.2";
                          }
                          if (racetrackController4=="australian" || racetrackController4=="azerbaijan"){
                            trackQual4 = "0.1";
                          }
                          String pitstopNo = pitStopNoController4.text.toString();
                          String tyreAge = tyreAgeController4.text.toString();
                          String lapsCompleted = lapsCompletedController4.text.toString();
                          String lapsLeft = lapsLeftController4.text.toString();
                          String position = positionController4.text.toString();
                          String raceTrack = trackQual4;
                          String totalLaps = totalLapsController4.text.toString();

                          // DataModel data = await
                          setState(() {
                            _dataModel4 = submitData(pitstopNo, tyreAge, lapsCompleted, lapsLeft, position, raceTrack, totalLaps, H,I,J);
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
                              child: Center(child: (_dataModel4 == null) ? Text(output,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w800),) : buildFutureBuilder()),
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
      future: _dataModel4,
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

