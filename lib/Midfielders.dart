import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'apiManager.dart';
class Midfielders {
  List<String>midfieldersList= new List();
  APIManage api1 = APIManage();
  Future <List<String>> getMidfielders() async {
      var teamList =await api1.getPlayerData();
      for(int i=0;i<573;i++)
      {
        if(teamList[i]['element_type']==3)
        {
          midfieldersList.add(teamList[i]['web_name']);
        }
      }


    return midfieldersList;
  }
}