import 'main.dart';
import 'package:flutter/material.dart';
import 'PlayerScreen2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fpl_predictor/constraints.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:fpl_predictor/PlayerScreen2.dart';

class PlayerScreen extends StatefulWidget {
  String title;
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  var TeamList;
  int a=1,b=2,c=3,d=4;
 // bool x = true;
  int title = 0;
  var topPlayerList;
  Future getPlay;
  Future<List<KeeperData>> getKeeperData() async {
    topPlayerList = await a1.getPlayerData();
    // topTeamsList= await a1.getTeamData();
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
    }
    var mapSort = Map.fromEntries(valueOfPlayer.entries.toList()
      ..sort((e2, e1) => e1.value.compareTo(e2.value)));
    mapSort.forEach((key, value) {
      KeeperData data = KeeperData(
          key,
          value,
          playerPositionCode[key],
          playerTeamCode[key],
          goals[key],
          assists[key],
          rank[key],
          price[key],
          positionName[playerPositionCode[key]]);
      kData.add(data);
    });
    print(kData.length);
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
        appBar: AppBar(
          title: Text(
            'FPL Helper',
            style: GoogleFonts.adamina(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Colors.black),
          ),
          backgroundColor: Colors.teal,
        ),
        backgroundColor: Colors.teal,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.zero,
                        bottomLeft: Radius.zero,
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24)),
                    color: Colors.greenAccent),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ListTile(
                        title: Text(
                          'Goalkeepers',
                          style: GoogleFonts.rajdhani(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        autofocus: true,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayerScreen2(x:'1')));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ListTile(
                        title: Text(
                          'Defenders',
                          style: GoogleFonts.rajdhani(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        autofocus: true,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayerScreen2(x:'2')));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ListTile(
                        title: Text(
                          'Midfielders',
                          style: GoogleFonts.rajdhani(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        autofocus: true,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayerScreen2(x:'3')));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ListTile(
                        title: Text(
                          'Attackers',
                          style: GoogleFonts.rajdhani(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        autofocus: true,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayerScreen2(x:'4')));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
  KeeperData(this.points, this.name, this.position, this.teamImage, this.goals,
      this.assists, this.rank, this.price, this.positionName);
}
