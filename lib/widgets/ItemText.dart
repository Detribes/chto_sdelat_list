import 'package:flutter/material.dart';

class ItemText extends StatelessWidget {
  final bool check;
  final String text;
  final String? description;
  final TimeOfDay? dueTime;

  const ItemText(
      this.check,
      this.text,
      this.description,
      this.dueTime,
      );

  Widget _buildText(BuildContext context) {
    if (check) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 22,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough),
          ),
          _buildCommentsTexts(context),
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        _buildCommentsTexts(context),
      ],
    );
  }

  Widget _buildTimeText(BuildContext context) {
    return Text(
      dueTime!.format(context),
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 14,
        color: check ? Colors.grey : Theme.of(context).primaryColorDark,
      ),
    );
  }
Widget _buildComment(BuildContext context){
  return Text(
    description ?? "",
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: 14,
      color: check ? Colors.grey : Theme.of(context).primaryColorDark,
    ),
  );
}
  Widget _buildCommentsTexts(BuildContext context) {
    if (description != null && dueTime == null) {
      return _buildComment(context);
    } else if (description != null && dueTime != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
      _buildComment(context),
          SizedBox(
            width: 10,
          ),
          _buildTimeText(context),
        ],
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return _buildText(context);
  }
}