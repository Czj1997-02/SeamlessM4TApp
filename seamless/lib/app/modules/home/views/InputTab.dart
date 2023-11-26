import 'package:flutter/material.dart';

class InputTab extends StatefulWidget {
  // 传入参数
  const InputTab({
    Key? key,
    this.height = 50.0, // 搜索栏高度
    this.hintText = '', // 搜索栏初始提示
    this.backgroundColor = Colors.white,// 背景色
    this.fontSize = 18,// 文字大小
    this.fontColor = Colors.black,// 文字颜色
    this.iconColor = Colors.blueAccent,// 文字颜色
    required this.onChange,
    required this.onCheck,// 右侧图标按钮回调函数
    this.rightIcon = Icons.swipe_up,// 右侧图标
  }) : super(key: key,);
  final double height;
  final String hintText;
  final Color backgroundColor;
  final double fontSize;
  final Color fontColor;
  final Color iconColor;
  final ValueChanged<String> onChange;
  final ValueChanged<String> onCheck;
  final IconData rightIcon;
  @override
  State<StatefulWidget> createState() => InputTabState();
}


// 构建
class InputTabState extends State<InputTab> {
  TextEditingController value = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,// 宽度全屏
        height: widget.height,// 传入高度
        child: Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
              color: widget.backgroundColor,// 传入背景色
              border: const Border(top:BorderSide(width: 1,color: Color(0xffe5e5e5)) ),
              // borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
            child:
            Row(
              children: [
                // 中间搜索框
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white60,
                          border: Border.all(
                              color: Colors.black38, width: 1),
                          borderRadius: BorderRadius.circular((10.0))),
                      height: widget.height,
                      width: MediaQuery.of(context).size.width - 60,
                      child: TextField(
                        maxLines: null,
                        controller: value,
                        style: TextStyle(color: widget.fontColor,fontSize: widget.fontSize),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {value.clear();widget.onChange('');},//
                              icon: Icon(Icons.cancel, color: widget.fontColor,size: 18,)
                          ),
                          contentPadding: const EdgeInsets.all(8.5),
                          hintText: widget.hintText,
                          border: InputBorder.none,
                        ),
                        autofocus: false,
                        onChanged: (value){widget.onChange(value);},
                      )
                  ),
                ),
                // 右侧自定义图标按钮
                SizedBox(
                  height: 30,
                  width: 30,
                  child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 53, 53, 53)),
                        minimumSize: MaterialStateProperty.all(const Size(10, 5)),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      onPressed: (){widget.onCheck(value.text);value.clear();},
                      child: Row(
                        children: [
                          Icon(widget.rightIcon,color: widget.iconColor,size: 30,),
                        ],
                      )
                  ),
                )
              ],
            )
        )
    );
  }
}