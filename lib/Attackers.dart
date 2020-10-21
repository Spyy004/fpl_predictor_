import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'apiManager.dart';
class Attackers {
  List<String>attackersList= new List();
  APIManage api1= APIManage();
  Future <List<String>> getAttackers() async {
      var teamList = await api1.getPlayerData();
      for(int i=0;i<573;i++)
      {
        if(teamList[i]['element_type']==4)
        {
          attackersList.add(teamList[i]['web_name']);
        }
      }

    return attackersList;
  }
}