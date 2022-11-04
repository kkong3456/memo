import 'package:flutter/material.dart';
import 'package:memomemo/database/data_form.dart';
import 'package:memomemo/database/db_crud.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class WritePage extends StatelessWidget {
  WritePage({Key? key}) : super(key: key);

  String title='';
  String text='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('write_page.dart'), actions: [
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {},
        ),
        IconButton(onPressed:saveDB, icon: const Icon(Icons.save)),
      ]),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
              TextField(
              onChanged: (String title)=> this.title=title,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              keyboardType: TextInputType.multiline,
              maxLines:null,
              decoration: const InputDecoration(
                hintText: '메모 제목을 적어 주세요',
                hintStyle:TextStyle(color:Colors.black26)
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
            ),
            TextField(
              onChanged:(String text){this.text=text;},
              keyboardType: TextInputType.multiline,
              maxLines:null,
              decoration: const InputDecoration(hintText: '메모 내용을 적어 주세요'),
            ),
          ],
        ),
      ),

    );
  }

  Future<void> saveDB() async{
    DBHelper sd=DBHelper();
    var fido=Memo(
      id:Str2Sha512(DateTime.now().toString()),
      title:this.title,
      text:this.text,
      createTime: DateTime.now().toString(),
      editTime: DateTime.now().toString(),
    );
    print('zzzz');
    await sd.insertMemo(fido);
    print('THE ANSWER IS ${await sd.memos()}');
  }
  
  String Str2Sha512(String text){
    var bytes=utf8.encode(text);
    var digest=sha512.convert(bytes);
    return digest.toString();
  }
}
