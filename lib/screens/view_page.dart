import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:memomemo/database/data_form.dart';
import 'package:memomemo/database/db_crud.dart';


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
            icon:const Icon(Icons.save),
            onPressed:(){},
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
            children: [
              Text(memo.title ?? ''),
              Text(memo.createTime ?? ''),
              Text(memo.editTime ?? ''),
              const Padding(padding: EdgeInsets.all(10)),
              Text(memo.text ?? ''),
            ],
          );
        }
      },
    );
  }
}

