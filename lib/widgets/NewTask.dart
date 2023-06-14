import 'package:chto_sdelat_list/Task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewTask extends StatefulWidget {
final String? id;
final bool isEditMode;

NewTask({
  this.id,
  required this.isEditMode,
});

@override
_NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  Task? task;
  TimeOfDay? _selectedTime;
  String _inputTaskName = "";
  String? _inputDescription;
  final _formKey = GlobalKey<FormState>();


  void _pickUserDueTime() {
    showTimePicker(
      context: context,
      initialTime: widget.isEditMode ? _selectedTime! : TimeOfDay.now(),
    ).then((time) {
      if (time == null) {
        return;
      }
      setState(() {
        _selectedTime = time;
      });
    });
  }

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (!widget.isEditMode) {
        Provider.of<TaskProvider>(context, listen: false).createNewTask(
          Task(
            id: DateTime.now().toString(),
            name: _inputTaskName,
            descripton: _inputDescription,
            dueTime: _selectedTime,
          ),
        );
      } else {
        Provider.of<TaskProvider>(context, listen: false).editTask(
          Task(
            id: task!.id,
            name: _inputTaskName,
            descripton: _inputDescription,
            dueTime: _selectedTime,
          ),
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    if (widget.isEditMode) {
      task =
          Provider.of<TaskProvider>(context, listen: false).getById(widget.id!);
      _selectedTime = task?.dueTime ?? TimeOfDay.now();
      _inputTaskName = task!.name;
      _inputDescription = task?.descripton ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Название', style: TextStyle(
              fontWeight: FontWeight.w400
            )),
            TextFormField(
              initialValue:
              _inputTaskName == null ? null : _inputTaskName,
              decoration: InputDecoration(
                hintText: 'Въеби описание',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Въеби что-нибудь';
                }
                return null;
              },
              onSaved: (value) {
                _inputTaskName = value!;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text('Описание', style: TextStyle(
                fontWeight: FontWeight.w400
            )),
            TextFormField(
              initialValue:
              _inputDescription == null ? null : _inputDescription,
              decoration: InputDecoration(
                hintText: 'Въеби описание',
              ),
              onSaved: (value) {
                _inputDescription = value!;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text('Время', style: TextStyle(fontWeight: FontWeight.w400)),
            TextFormField(
              onTap: () {
                _pickUserDueTime();
              },
              readOnly: true,
              decoration: InputDecoration(
                hintText: _selectedTime == null
                    ? 'Въеби время'
                    : _selectedTime!.format(context),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                child: Icon(
                  widget.isEditMode
                      ? Icons.edit
                      : Icons.add
                ),
                onPressed: () {
                  _validateForm();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}