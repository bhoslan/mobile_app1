import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task_model.dart';

class TaskItem extends StatefulWidget {
  Task task;
  TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  TextEditingController _taskNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _taskNameController.text = widget.task.name;
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurRadius: 10,
            )
          ]),
      child: ListTile(
        leading: GestureDetector(
          onTap: () {
            widget.task.isCompleted = !widget.task.isCompleted;
            setState(() {});
          },
          child: Container(
            child: Icon(
              (Icons.check),
              color: Colors.white,
            ),
            decoration: BoxDecoration(
              color: widget.task.isCompleted ? Colors.green : Colors.white,
              border: Border.all(color: Colors.grey, width: 0.8),
              shape: BoxShape.circle,
            ),
          ),
        ),
        title: widget.task.isCompleted
            ? Text(
                widget.task.name,
                style: TextStyle(
                    decoration: TextDecoration.lineThrough, color: Colors.grey),
              )
            : TextField(
                controller: _taskNameController,
                minLines: 1,
                maxLines: null, //görev güncellerken birçok satır görebilmek için kullanıldı
                textInputAction: TextInputAction.done, //klavyede çoklu satırda giriş işareti yerine tik kullanır
                decoration: InputDecoration(border: InputBorder.none),
                onSubmitted: (yeniDeger) {
                  widget.task.name = yeniDeger;
                },
              ),
        trailing: Text(
          DateFormat("hh:mm: a").format(widget.task.createdAt),
          style: TextStyle(
              fontSize: 14,
              color:
                  Colors.grey), //tarih formatlamak için intl paketi kullanıldı
        ),
      ),
    );
  }
}
