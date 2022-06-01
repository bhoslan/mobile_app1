import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../models/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> _allTasks ;

  @override
  void initState(){
    super.initState();
    _allTasks = <Task>[];
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors
          .white, //AppBar ile scaffold arasında beyaz rengin ton farkı giderildi.
      appBar: AppBar(
        title: GestureDetector(
          onTap: (){_showAddTaskBottomSheet(context);},//Yazının üzerine gelinip tıklandığında da görev eklenebilir.
          child: const Text(
            "Bugün neler yapacaksın?",
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
          IconButton(onPressed: (){_showAddTaskBottomSheet(context);}, icon: const Icon(Icons.add)),
        ],
      ),
      body: _allTasks.isNotEmpty ? ListView.builder(itemBuilder: (context, index){
        var _oAnkiListeElemani = _allTasks[index];
        return Dismissible( //sürüklediğimizde görevi sileceğiz.
          background: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(Icons.delete, color: Colors.grey,),
              SizedBox(width: 10,),
              Text("Bu görev silinecek"),
            ],
          ),
          key: Key(_oAnkiListeElemani.id),
          onDismissed: (direction){_allTasks.removeAt(index); setState((){});},
          child: ListTile(
            title: Text(_oAnkiListeElemani.name),
            subtitle: Text(_oAnkiListeElemani.createdAt.toString()),
          ),
        );
      }, itemCount: _allTasks.length,) : const Center(child: Text("Yapacaklarını ekle !"),)
    );
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom), //Ekleme tuşuna basıldığında görev nedir bölümünün klavye üzerinde açılmasını sağlar.
        width: MediaQuery.of(context).viewInsets.bottom,
        child:  ListTile(
          title:  TextField(
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              hintText: "Görev nedir?", border:InputBorder.none,
            ),
            onSubmitted: (value){
              Navigator.of(context).pop();
              DatePicker.showTimePicker(context,showSecondsColumn: false,onConfirm: (date){
                var yeniEklenecekGorev = Task.create(name: value, createdAt: date);
                _allTasks.add(yeniEklenecekGorev);
                setState((){});
              }); //Görev eklendikten sonra zaman bilgisi için date_time_picker paketi kullanıldı
            },//Görev girilmesinden sonra ekranı kapat
          ),
        ),
      );
    });
  }
}
