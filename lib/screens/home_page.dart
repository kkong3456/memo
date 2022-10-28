import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memomemo/screens/write_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(physics: BouncingScrollPhysics(), children: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
              child: Text('메모메모-home_page',
                  style: TextStyle(fontSize: 36, color: Colors.blue)),
            ),
          ],
        ),
        ...LoadMemo()
      ]),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context, CupertinoPageRoute(builder: (context) => WritePage()));
          },
          tooltip: 'Increment',
          icon: const Icon(Icons.add),
          label: const Text(
              "메모 추가")), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

List<Widget> LoadMemo(){
  List<Widget> memoList=[];
  memoList.add(Container(color:Colors.purpleAccent,height:100,));
  return memoList;
}
