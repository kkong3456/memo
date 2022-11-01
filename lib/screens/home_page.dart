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
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text('메모메모',
                  style: TextStyle(fontSize: 36, color: Colors.blue)),
            ),
          ),
          Expanded(child: memoBuilder()),
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
          child: const Text(
            '지금 바로 "메모 추가" 버튼을 눌러\n 새 메모를 추가해 보세요!\n\n\n\n',
            style: TextStyle(fontSize: 15, color: Colors.blueAccent),
            textAlign: TextAlign.center,
          ),
        );
      }

      return ListView.builder(
        itemCount: snap.data.length,
        itemBuilder: (context, index) {
          Memo memo = snap.data[index];
          return Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(15),
            alignment: Alignment.center,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(memo.title ?? '',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    Text(
                      memo.text ?? '',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '최종 수정 시간 : ${memo.editTime!.split('.')[0]}',
                      style: const TextStyle(fontSize: 11),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
    future: loadMemo(),
  );
}
