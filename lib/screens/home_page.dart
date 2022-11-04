import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memomemo/screens/write_page.dart';
import 'package:memomemo/database/data_form.dart';
import 'package:memomemo/database/db_crud.dart';
import 'package:memomemo/screens/view_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String deleteId = '';

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
          Expanded(child: memoBuilder(context)),
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

  Widget memoBuilder(BuildContext parentContext) {
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
            return InkWell(
              onTap: () {
                Navigator.push(
                    parentContext,
                    CupertinoPageRoute(
                        builder: (parentContext) => ViewPage(id: memo.id)));
              },
              onDoubleTap: () {
                setState(() {
                  deleteId = memo.id ?? "1";
                  showAlertDialog(parentContext);
                });
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 1),
                  boxShadow: const [
                    BoxShadow(color: Colors.blue, blurRadius: 3)
                  ],
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
                        Text(
                          memo.title ?? '',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          memo.text ?? '',
                          style: const TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
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
              ),
            );
          },
        );
      },
      future: loadMemo(),
    );
  }

  void showAlertDialog(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('삭제 경고'),
            content: const Text('정말 삭제하시겠습니까?\n 삭제된 메모는 복구되지 않습니다.'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, '삭제');
                    setState(() {
                      deleteMemo(deleteId);
                    });
                  },
                  child: const Text('삭제')),
              ElevatedButton(
                  onPressed: () {
                    deleteId = '';
                    Navigator.pop(context, '취소');
                  },
                  child: const Text('취소'))
            ],
          );
        });
  }
}

Future<List<Memo>> loadMemo() async {
  DBHelper sd = DBHelper();
  return await sd.memos();
}

Future<void> deleteMemo(String id) async {
  print('xxx');
  DBHelper sd = DBHelper();
  sd.deleteMemo(id);
}
