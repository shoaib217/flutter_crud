import 'package:flutter/material.dart';

class MyRoute{
  MyRoute(this.context , this.t);
   dynamic t;
   BuildContext context;

  void navigate(){
         Navigator.of(context).push(_createRoute());
  }

  Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => t,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
}