import 'package:FixMyEnglish/Widgets/mistake_item.dart';
import 'package:FixMyEnglish/mistakes_demo_data.dart';
import 'package:flutter/material.dart';

import 'file.dart';
import 'mistake.dart';

class MistakePage extends StatefulWidget {
  final List<Future<MistakeFile>> files;

  const MistakePage({Key? key, required this.files}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MistakePageState();
}

class _MistakePageState extends State<MistakePage> {
  int _currentFile = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mistakes Page'),
      ),
      body: Row(
        children: [
          Container(
            color: Color.fromRGBO(247, 250, 235, 1),
            width: 700,
            padding: EdgeInsets.only(top:25),
            child: FutureBuilder(
              future: widget.files[_currentFile],
              builder: (context, snapshot){
                if(snapshot.data == null){
                  return  LinearProgressIndicator(
                    backgroundColor: Colors.cyanAccent,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                  );
              }
                List<Mistake> data = ((snapshot.data as MistakeFile).mistakes).toList();
              if(data.isNotEmpty){
                //To Use Dummy Data in case there is a server error
                //TODO: Remove
                if(data[0].sentence == "Server Error"){
                  data = mistakes.toList();
                }
                  return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (BuildContext context, int index){
                        Mistake currentItem = data[index];
                        return MistakeItem(currentItem.sentence, currentItem.match, currentItem.description);
                    },
                    itemCount: data.length,
                );
              } else {
                return Center(
                  child: Text('No Mistakes Found'),
                );
              }
              },
            ),
          ),

          Container(
            width: 300,
            child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: widget.files.length,
                itemBuilder:(context, index) {
                  return FutureBuilder(
                      future: widget.files[index],
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          //TODO
                        }
                        String fileName = (snapshot.data as MistakeFile).name;
                        return TextButton(
                          onPressed: () {
                            print(index);
                            setState(() {
                              _currentFile = index;
                            });
                          },
                          child: Text('File 1'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(233, 241, 232, 1)),
                          ),
                        );
                      });
                },
          ),
          )],
      ),
    );
  }
}
