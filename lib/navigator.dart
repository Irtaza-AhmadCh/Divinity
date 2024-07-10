import 'package:flutter/material.dart';

class NavigatorTo{

static   void navigator (context ,screen){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> screen ));
  }
}

class NavigatorMove{

static   void navigator (context ,screen){
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> screen ));
}
}

class Navigatorpop{

static   void navigator (context ,screen){
Navigator.pop;
}
}