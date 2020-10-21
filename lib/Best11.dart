import 'package:fpl_predictor/constraints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'apiManager.dart';
import 'package:fpl_predictor/Goalkeepers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert show utf8;
import 'package:google_fonts/google_fonts.dart';
import 'package:flip_card/flip_card.dart';
import 'package:expandable/expandable.dart';
class FootyApp extends StatefulWidget {
  String title;
  @override
  _FootyAppState createState() => _FootyAppState();
}
class _FootyAppState extends State<FootyApp> {
  var TeamList;
  var topPlayerList;
  Future getPlay;
  Future<List<KeeperData>> getKeeperData() async {
    topPlayerList= await a1.getPlayerData();
    //  topPlayerList= convert.jsonDecode(convert.jsonEncode(topPlayerList1))['web_name'];
    List<KeeperData> kData = [];
    positionName[1]='GoalKeeper';
    positionName[2]='Defender';
    positionName[3]='Midfielder';
    positionName[4]='Attacker';
      int count = 0,
        strikerCount = 0,
        midfielderCount = 0,
        defenderCount = 0,
        keeperCount = 0,
        gifcounter=0;
    for (var y in topPlayerList) {
      valueOfPlayer[y['web_name']] = y['points_per_game'];
      playerTeamCode[y['web_name']] = y['team'];
      playerPositionCode[y['web_name']] = y['element_type'];
      goals[y['web_name']]=y['goals_scored'];
      assists[y['web_name']]=y['assists'];
      price[y['web_name']]=(y['now_cost']);
      rank[y['web_name']]=y['ict_index_rank'];
    }
    var mapSort = Map.fromEntries(valueOfPlayer.entries.toList()
      ..sort((e2, e1) => e1.value.compareTo(e2.value)));
    mapSort.forEach((key, value) {
      if (count < 11) {
        if (playerPositionCode[key] == 1 && keeperCount < 2) {
          KeeperData data = KeeperData(
              key, value, playerPositionCode[key], playerTeamCode[key],goals[key],assists[key],rank[key],price[key],positionName[playerPositionCode[key]]);
          kData.add(data);
          keeperCount++;
          count++;
        }
        if (playerPositionCode[key] == 2 && defenderCount < 4) {
          KeeperData data = KeeperData(
              key, value, playerPositionCode[key], playerTeamCode[key],goals[key],assists[key],rank[key],price[key],positionName[playerPositionCode[key]]);
          kData.add(data);
          defenderCount++;
          count++;
        }
        if (playerPositionCode[key] == 3 && midfielderCount < 5) {
          KeeperData data = KeeperData(
              key, value, playerPositionCode[key], playerTeamCode[key],goals[key],assists[key],rank[key],price[key],positionName[playerPositionCode[key]]);
          kData.add(data);
          midfielderCount++;
          count++;
        }
        if (playerPositionCode[key] == 4 && strikerCount < 2) {
          KeeperData data = KeeperData(
              key, value, playerPositionCode[key], playerTeamCode[key],goals[key],assists[key],rank[key],price[key],positionName[playerPositionCode[key]]);
          kData.add(data);
          strikerCount++;
          count++;
        }
      }
    });
  print (kData.length);
    return kData;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlay=getKeeperData();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('FPL Helper',style: GoogleFonts.adamina(fontWeight: FontWeight.bold,letterSpacing: 1.2),),
          backgroundColor: Colors.indigo,
        ),
        backgroundColor: Colors.indigo[800],
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.zero,bottomLeft:Radius.zero,topRight: Radius.circular(24),topLeft: Radius.circular(24)),
              color: Colors.indigo[500]
            ),
            child: FutureBuilder(
                future: getPlay,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    borderOnForeground: false,
                                    color: Colors.white,
                                    elevation: 12.0,
                                    shadowColor: Colors.indigo[800],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        ),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(24.0),
                                            // gradient: LinearGradient(
                                            //   colors: colours,
                                            //   stops: stops,
                                            //   begin: Alignment.topCenter
                                            //  ),
                                            color: Colors.indigo[100],
                                            image: DecorationImage(image:AssetImage("assets/footy.gif"),fit: BoxFit.cover)
                                        ),
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    ('${snapshot.data[index].points}'),
                                                    style: GoogleFonts.playfairDisplay(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: 1.2,
                                                        fontSize: 25),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Text(
                                                    ('(${snapshot.data[index].positionName})'),//editing
                                                    style: GoogleFonts.playfairDisplay(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: 1.2,
                                                        fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  FlipCard(
                                                    direction: FlipDirection.HORIZONTAL,
                                                    back: Container(
                                                      margin: EdgeInsets.only(top: 30.0),
                                                      alignment: Alignment.center,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Center(
                                                              child: Text(
                                                                snapshot.data[index].name,
                                                                style: GoogleFonts.balooThambi(
                                                                  textStyle: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 20.0,
                                                                    fontWeight:
                                                                    FontWeight.bold,),),

                                                              )),
                                                          Center(
                                                              child: Text(
                                                                'Points Per Game',
                                                                style: GoogleFonts.balooThambi(
                                                                    textStyle: TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize: 15.0,)),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    front: Container(
                                                      margin: EdgeInsets.only(top: 30.0),
                                                      child: Column(
                                                        children: [
                                                          CircleAvatar(
                                                            child: Image(
                                                              image: AssetImage(
                                                                "assets/${snapshot.data[index].teamImage.toString()}.png",),
                                                              height: 50,
                                                              width: 50,
                                                              fit: BoxFit.cover,

                                                            ),
                                                            backgroundColor:
                                                            Colors.white,
                                                          ),
                                                          Text("Tap to Flip",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 30.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        Text('Price:${snapshot.data[index].price/10} Mill',style: GoogleFonts.bubblegumSans(fontSize: 25,color: Colors.black),),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text('Goals:${snapshot.data[index].goals}',style: GoogleFonts.bubblegumSans(fontSize: 21,color: Colors.black)),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text('Assists:${snapshot.data[index].assists}',style: GoogleFonts.bubblegumSans(fontSize: 21,color: Colors.black)),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text('ICT Rank:${snapshot.data[index].rank}',style: GoogleFonts.bubblegumSans(fontSize: 21,color: Colors.black)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 40,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),

                                  ),

                              ),
                            );
                          },
                        ),

                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
class KeeperData {
  String points;
  String name;
  int position;
  int teamImage;
  int goals,assists,price,rank;
  String positionName;
  KeeperData(this.points, this.name, this.position, this.teamImage,this.goals,this.assists,this.rank,this.price,this.positionName);
}