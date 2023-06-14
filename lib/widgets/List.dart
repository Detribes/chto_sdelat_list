import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Task.dart';
import 'ListItem.dart';


class List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskList = Provider.of<TaskProvider>(context).itemsList;
    return taskList.length > 0
        ? ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return ListItem(taskList[index]);
      },
    )
        : LayoutBuilder(
      builder: (ctx, constraints) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: constraints.maxHeight * 0.5,
                child: Image.asset('utils/images/waiting.png',
                    fit: BoxFit.cover),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Ещё нет задач.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}