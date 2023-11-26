import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

class ChoicesOne extends StatefulWidget {
  // 传入参数
  const ChoicesOne({
    Key? key,
    this.title = '选择',
    required this.choices,
    required this.onChoices,
    required this.onValues,
    this.label = 'label',
    this.value = 'value',

  }) : super(key: key,);
  final String title;
  final List choices;
  // final ValueChanged<String> inChoices;
  final ValueChanged<dynamic> onChoices;
  final String onValues;
  final String label;
  final String value;


  @override
  State<StatefulWidget> createState() => ChoicesOneState();

}

class ChoicesOneState extends State<ChoicesOne> {
  List<DropdownMenuItem> items = [];
  // List<int> values = [];
  String selectedValueSingleDialog = '';
  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> theValue = {};
    for (var item in widget.choices) {
      theValue.addAll({item[widget.label]:item[widget.value]});
      items.add(
          DropdownMenuItem(
            child: Text(item[widget.label]),
            value: item[widget.value],
          )
      );
    }
    if (widget.onValues != '' ){
      selectedValueSingleDialog = widget.onValues;
    }
    return
      SearchChoices.single(
        items: items,
        value: selectedValueSingleDialog,
        label: Text(widget.title),
        hint: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text(widget.title),
        ),
        searchHint: widget.title,
        closeButton: '关闭',
        onChanged: (value) {
          selectedValueSingleDialog = value;
          widget.onChoices(value);
          // 传出值
          // dynamic? id = 0;
          // id = theValue[value];
          // print(id!);
          // widget.onChoices(id!);
          // widget.inChoices(value);
        },
        isExpanded: true,
        dialogBox: true,
        // menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
      );
  }

}
