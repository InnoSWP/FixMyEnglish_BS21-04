import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Rectangle5Widget - COMPONENT
    return Container(
        width: 720,
        height: 275,
        color: const Color.fromRGBO(242, 238, 225, 1),
        child: const Align(
          alignment: Alignment.center,
          child: Text(
            'iExtract',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromRGBO(122, 55, 11, 1),
                fontFamily: 'Eczar',
                fontSize: 128,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ));
  }
}
