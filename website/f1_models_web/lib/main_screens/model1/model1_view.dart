import 'dart:convert';

import 'package:f1_models_web/widgets/centered_view/centered_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'DataModel.dart';

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

class Model1View extends StatefulWidget {
  const Model1View({Key? key}) : super(key: key);

  @override
  State<Model1View> createState() => _Model1ViewState();
}

Future<DataModel> submitData(String pitstopNo, String tyreAge, String lapsLeft, String position, String raceTrack, String totalLaps, String tyre) async{
  http.Response response = await http.post(Uri.parse('http://127.0.0.1:5000/model1'),
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

class _Model1ViewState extends State<Model1View> {

  _Model1ViewState(){
    _selectedTyre = _tyresList[0];
    _selectedTrack = _trackList[0];
  }

  Future<DataModel>? _dataModel;
  TextEditingController pitStopNoController = TextEditingController();
  TextEditingController tyreAgeController = TextEditingController();
  TextEditingController lapsLeftController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  // TextEditingController racetrackController = TextEditingController();
  TextEditingController totalLapsController = TextEditingController();
  // TextEditingController tyreController = TextEditingController();

  String currentTyre="", trackQual="";
  String output = 'Tyre';

  final _tyresList = ["soft","medium","hard"];
  String? _selectedTyre="";
  String? tyreController="";

  final _trackList = ["belgian","italian","emilia romagna","monza","tuscany","spanish","french","portuguese","silverstone","dutch","bahrain","austin","miami","hungary","abu dhabi","united states","bahrain","austrian","canada","styrian","russian","eifel","saudi arabian","australia","azerbaijan"];
  String? _selectedTrack = "";
  String? racetrackController="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ...List<int>.generate(1, (index) => index).map((e) => SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
              child: const Text('Using Decision Tree model',style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),),
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
                        controller: pitStopNoController,
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter tyre age'),
                        controller: tyreAgeController,
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter laps left'),
                        controller: lapsLeftController,
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter position'),
                        controller: positionController,
                      ),
                      const SizedBox(height: 10,),
                      DropdownButtonFormField(
                        value: _selectedTrack,
                        items: _trackList.map((e) => DropdownMenuItem(child: Text(e), value: e,)
                        ).toList(),
                        onChanged: (val){
                          setState(() {
                            _selectedTrack = val as String;
                            racetrackController = _selectedTrack;
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
                        controller: totalLapsController,
                      ),
                      const SizedBox(height: 10,),
                      DropdownButtonFormField(
                        value: _selectedTyre,
                        items: _tyresList.map((e) => DropdownMenuItem(child: Text(e), value: e,)
                        ).toList(),
                        onChanged: (val){
                          setState(() {
                            _selectedTyre = val as String;
                            tyreController = _selectedTyre;
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
                      //   controller: tyreController,
                      // ),
                      const SizedBox(height: 15,),
                      ElevatedButton(onPressed: () async{
                        if (tyreController=="soft"){
                          currentTyre = "1";
                        }
                        if (tyreController=="medium"){
                          currentTyre = "2";
                        }
                        if (tyreController=="hard"){
                          currentTyre = "3";
                        }
                        if (racetrackController=="belgian" || racetrackController=="italian" || racetrackController=="emilia romagna" || racetrackController=="monza" || racetrackController=="tuscany"){
                          trackQual = "0.5";
                        }
                        if (racetrackController=="spanish" || racetrackController=="french" || racetrackController=="portuguese"){
                          trackQual = "0.4";
                        }
                        if (racetrackController=="silverstone" || racetrackController=="dutch" || racetrackController=="bahrain" || racetrackController=="austin" || racetrackController=="miami" || racetrackController=="hungary" || racetrackController=="abu dhabi" || racetrackController=="united states" || racetrackController=="bahrain"){
                          trackQual = "0.3";
                        }
                        if (racetrackController=="austrian" || racetrackController=="canada" || racetrackController=="styrian" || racetrackController=="russian" || racetrackController=="eifel" || racetrackController=="saudi arabian"){
                          trackQual = "0.2";
                        }
                        if (racetrackController=="australian" || racetrackController=="azerbaijan"){
                          trackQual = "0.1";
                        }
                        String pitstopNo = pitStopNoController.text.toString();
                        String tyreAge = tyreAgeController.text.toString();
                        String lapsLeft = lapsLeftController.text.toString();
                        String position = positionController.text.toString();
                        String raceTrack = trackQual;
                        String totalLaps = totalLapsController.text.toString();
                        String tyre = currentTyre;

                        // DataModel data = await
                        setState(() {
                          _dataModel = submitData(pitstopNo, tyreAge, lapsLeft, position, raceTrack, totalLaps, tyre);
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
                            child: Center(child: (_dataModel == null) ? Text(output,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w800),) : buildFutureBuilder()),
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
      future: _dataModel,
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

