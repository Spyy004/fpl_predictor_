import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'apiManager.dart';
class Goalkeepers {
  var gkList;
  APIManage api1 = APIManage();
  Future <List<String>> getGK() async {
      var goalieList;
      goalieList=await api1.getPlayerData();
      for(int i=0;i<573;i++)
      {
        if(goalieList[i]['element_type']==1)
        {
          gkList.add(goalieList[i]['web_name']);
        }
      }
    return gkList;
  }
}