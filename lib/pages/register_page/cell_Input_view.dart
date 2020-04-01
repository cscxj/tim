import 'package:flutter/material.dart';

class CellInputView extends StatefulWidget {
  // 单元格数量
  final int cellCount;
  final double itemSize;
  final Color backgroundColor;
  final Color itemColor;
  final EdgeInsetsGeometry itemPadding;
  final ValueChanged onChange;

  const CellInputView(
      {Key key,
      this.cellCount: 6,
      this.itemSize: 40.0,
      this.backgroundColor: Colors.white,
      this.itemColor: Colors.white,
      this.onChange,
      this.itemPadding})
      : super(key: key);

  @override
  _CellInputViewState createState() => _CellInputViewState();
}

class _CellInputViewState extends State<CellInputView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: widget.backgroundColor,
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 6,
          children: List.generate(widget.cellCount, (index) {
            return Container(
              child: Container(
                padding: widget.itemPadding ?? EdgeInsets.all(5.0),
                child: TextField(
                  maxLength: 1,
                  onTap: (){
                    
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(counterText: ''),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
