import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class PlayerScreen2 extends StatefulWidget {
  final String x;
  PlayerScreen2({Key key, @required this.x}) : super(key: key);
  @override
  _PlayerScreen2State createState() => _PlayerScreen2State();
}

class _PlayerScreen2State extends State<PlayerScreen2> {
  var TeamList;
  bool check=true;
  TextEditingController controller;
  var topPlayerList;
  Future getPlay;
  Future<List<KeeperData>> getKeeperData() async {
    topPlayerList = await a1.getPlayerData();
    //  topPlayerList= convert.jsonDecode(convert.jsonEncode(topPlayerList1))['web_name'];
    List<KeeperData> kData = [];
    positionName[1] = 'GoalKeeper';
    positionName[2] = 'Defender';
    positionName[3] = 'Midfielder';
    positionName[4] = 'Attacker';
    int count = 0,
        strikerCount = 0,
        midfielderCount = 0,
        defenderCount = 0,
        keeperCount = 0,
        gifcounter = 0;
    for (var y in topPlayerList) {
      valueOfPlayer[y['web_name']] = y['points_per_game'];
      playerTeamCode[y['web_name']] = y['team'];
      playerPositionCode[y['web_name']] = y['element_type'];
      goals[y['web_name']] = y['goals_scored'];
      assists[y['web_name']] = y['assists'];
      price[y['web_name']] = (y['now_cost']);
      rank[y['web_name']] = y['ict_index_rank'];
      totalPoints[y['web_name']] = y['total_points'];
    }
    var mapSort = Map.fromEntries(valueOfPlayer.entries.toList()
      ..sort((e2, e1) => e1.value.compareTo(e2.value)));
    mapSort.forEach((key, value) {
      if (widget.x == '1') {
        if (playerPositionCode[key] == 1) {
          KeeperData data = KeeperData(
               key,
              value,
              playerPositionCode[key],
              playerTeamCode[key],
              goals[key],
              assists[key],
              rank[key],
              price[key],
              positionName[playerPositionCode[key]],
              totalPoints[key]);
          kData.add(data);
        }
      }
      if (widget.x == '2') {
        if (playerPositionCode[key] == 2) {
          KeeperData data = KeeperData(
              key,
              value,
              playerPositionCode[key],
              playerTeamCode[key],
              goals[key],
              assists[key],
              rank[key],
              price[key],
              positionName[playerPositionCode[key]],
              totalPoints[key]);
          kData.add(data);
        }
      }
      if (widget.x == '3') {
        if (playerPositionCode[key] == 3) {
          KeeperData data = KeeperData(
              key,
              value,
              playerPositionCode[key],
              playerTeamCode[key],
              goals[key],
              assists[key],
              rank[key],
              price[key],
              positionName[playerPositionCode[key]],
              totalPoints[key]);
          kData.add(data);
        }
      }
      if (widget.x == '4') {
        if (playerPositionCode[key] == 4) {
          KeeperData data = KeeperData(
              key,
              value,
              playerPositionCode[key],
              playerTeamCode[key],
              goals[key],
              assists[key],
              rank[key],
              price[key],
              positionName[playerPositionCode[key]],
              totalPoints[key]);
          kData.add(data);
        }
      }
    });
    print(kData.length);
    return kData;
  }
  String searchString="";
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
        appBar: AppBar(
          title: Text(
            'FPL Helper',
            style: GoogleFonts.adamina(
                fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          backgroundColor: Colors.indigo,
        ),
        backgroundColor: Colors.indigo[800],
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.zero,
                    bottomLeft: Radius.zero,
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24)),
                color: Colors.indigo[500]),
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
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value){
                              setState(() {
                                searchString=value;
                              });
                            },
                            controller: controller,
                            decoration: (InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search),
                              hintText: "Search...",
                            )),
                            autofocus: true,

                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 130,
                              ),
                              Text("Total Points",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return snapshot.data[index].points.contains(searchString)?SafeArea(
                                  child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                            backgroundColor: Colors.indigo[500],
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/${snapshot.data[index].teamImage}.png'),
                                              fit: BoxFit.fill,
                                            )),
                                        title: Text(
                                          snapshot.data[index].points,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        trailing: Text(
                                            '${snapshot.data[index].totalPoint.toString()}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.white)),
                                      )),
                                ):Container();
                              },
                            ),
                          ),
                        ],
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
  int goals, assists, price, rank;
  String positionName;
  int totalPoint;
  KeeperData(this.points, this.name, this.position, this.teamImage, this.goals,
      this.assists, this.rank, this.price, this.positionName, this.totalPoint);
}

