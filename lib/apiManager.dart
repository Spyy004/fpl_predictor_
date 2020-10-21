import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class APIManage{
  var url1 = 'https://fantasy.premierleague.com/api/bootstrap-static/';
  var responseTeam,responsePlayers;
  var jsonResponseTeam,jsonResponsePlayer;
  var teamList,playerList;
  Future<Map<dynamic,dynamic>> getTeamData()async
  {
    try {
      responseTeam = await http.get(url1, headers: {'Accept': 'application/json'});
      jsonResponseTeam = convert.jsonDecode(responseTeam.body);
       teamList= jsonResponseTeam['teams'];
    }
    catch (e) {
      print(e.toString());
    }
    return teamList;
  }
  Future<List<dynamic>> getPlayerData()async
  {
    responsePlayers= await http.get(url1, headers: {'Accept': 'application/json'});
    jsonResponsePlayer= jsonResponseTeam = convert.jsonDecode(responsePlayers.body);
    playerList=jsonResponsePlayer['elements'];
    return playerList;
  }
}
