import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'apiManager.dart';
class Defenders {
  List<String>defendersList= new List();
  APIManage api1= APIManage();
  Future <List<String>> getDefenders() async {

      var teamList = await api1.getPlayerData();
      for(int i=0;i<573;i++)
      {
        if(teamList[i]['element_type']==2)
        {
          defendersList.add(teamList[i]['web_name']);
        }
      }
    return defendersList;
  }
}