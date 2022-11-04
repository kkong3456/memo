import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:memomemo/database/data_form.dart';
import 'package:memomemo/database/db_crud.dart';

import 'edit_page.dart';


class ViewPage extends StatelessWidget {
  const ViewPage({Key? key,this.id}) : super(key: key);
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:[
          IconButton(
            icon:const Icon(Icons.delete),
            onPressed: (){},
          ),
          IconButton(
            icon:const Icon(Icons.edit),
            onPressed:(){
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context)=>EditPage(id:id ?? '')
                )
              );
            },
          ),
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child:loadBuilder(),
      ),
    );
  }

  Future<List<Memo>> loadMemo(String id) async{
    DBHelper sd=DBHelper();
    return await sd.findMemo(id);
  }

  loadBuilder(){
    return FutureBuilder<List<Memo>>(
      future: loadMemo(id ?? ''),
      builder: (BuildContext context,AsyncSnapshot<List<Memo>> snapshot){
        if(snapshot.data==null){
          return Container(
            child:const Text("데이터를 불러 올 수 없습니다."),
          );
        }else{
          Memo memo=snapshot.data![0];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(child: Text(memo.title ?? '',style:const TextStyle(fontSize:30,fontWeight:FontWeight.w500))),
              Text(
                  '메모를 만든 시간 ${memo.createTime?.split('.')[0] ?? ''}',
                style:const TextStyle(fontSize:11),
                textAlign:TextAlign.end,
              ),
              Text(
                '메모 수정시간 ${memo.editTime?.split('.')[0] ?? ''}',
                style:const TextStyle(fontSize:11),
                textAlign:TextAlign.end
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Expanded(child: SingleChildScrollView(child: Text(memo.text ?? ''))),
            ],
          );
        }
      },
    );
  }
}

