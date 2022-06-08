import 'package:flutter/material.dart';
import 'dart:math' as math;

class Rectangle5Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Rectangle5Widget - COMPONENT
    return Container(
        width: 720,
        height: 275,
        color: Color.fromRGBO(250, 10, 12, 1),
        child: Stack(
            children: <Widget>[
              Positioned(
                  top: 0,
                  left: -1,
                  child: Text('iExtract', textAlign: TextAlign.center, style: TextStyle(
                      color: Color.fromRGBO(122, 55, 11, 1),
                      fontFamily: 'Eczar',
                      fontSize: 128,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                  ),)
              ),Positioned(
                  top: 200,
                  left: 125.82524108886719,
                  child: Transform.rotate(
                    angle: 1.4052910638162584e-14 * (math.pi / 180),
                    child: Divider(
                        color: Color.fromRGBO(77, 102, 88, 1),
                        thickness: 10
                    )
                    ,
                  )
              ),
            ]
        )
    );
  }
}
        