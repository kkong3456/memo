import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memomemo/screens/write_page.dart';
import 'package:memomemo/database/data_form.dart';
import 'package:memomemo/database/db_crud.dart';

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
      body: Column(
        children:[
          const Padding(
            padding: EdgeInsets.only(left:20,top:20,bottom:20),
            child: Text('메모메모',style:TextStyle(fontSize:36,color:Colors.blue)),
          ),
          Expanded(child:memoBuilder()),
        ],
      ),
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

Future<List<Memo>> loadMemo() async {
  DBHelper sd = DBHelper();
  return await sd.memos();
}

Widget memoBuilder() {
  return FutureBuilder<dynamic>(
    builder: (context, snap) {
      if (snap.data.isEmpty) {
        return Container(
          padding: const EdgeInsets.all(0),
          alignment: Alignment.center,
          child: const Text('메모를 지금 바로 추가해 보세요!'),
        );
      }

      return ListView.builder(
        itemCount: snap.data.length,
        itemBuilder: (context, index) {
          Memo memo = snap.data[index];
          return Column(
            children: [
              Text(memo.title ?? '', style: TextStyle(fontSize: 20)),
              Text(memo.text ?? '', style: TextStyle(fontSize: 20)),
              Text(memo.editTime ?? ''),
              const Padding(padding: EdgeInsets.only(top: 5.0))
            ],
          );
        },
      );
    },
    future: loadMemo(),
  );
}
