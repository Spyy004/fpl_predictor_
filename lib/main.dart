import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpl_predictor/PlayerScreen2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert show utf8;
import 'apiManager.dart';
import 'package:flip_card/flip_card.dart';
import 'package:fpl_predictor/Best11.dart';
import 'PlayerScreen.dart';


APIManage a1 = APIManage();
void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {

      },
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/12.gif"),
                fit: BoxFit.contain,
              )
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('FPL Helper',style: GoogleFonts.fugazOne(fontSize: 40,fontWeight: FontWeight.bold),),
                  SizedBox(height: 340,),
                  PageFinderButton(Display:'The Best 11',
                  onpressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FootyApp()));
                    },
                  ),
                  PageFinderButton(Display:'Player Data',
                    onpressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayerScreen()));
                    },
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class PageFinderButton extends StatelessWidget {
  PageFinderButton({this.Display, this.onpressed});

  final String Display;
  final Function onpressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Colors.white38,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          child: Text(
            Display,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.black),
          ),
          onPressed: onpressed,
        ),
      ),
    );
  }
}