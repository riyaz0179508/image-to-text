import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({Key? key, required this.text}) : super(key: key);
final String text;
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Details"),
        actions: [
          IconButton(
              onPressed: (){
                FlutterClipboard.copy(widget.text).then((value) => _key.currentState?.showSnackBar(new SnackBar(content: Text('Copied'))));
              },
              icon: Icon(Icons.copy))
        ],
      ),

      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        child: SelectableText(widget.text.isEmpty? 'No Text Available':widget.text),
      ),

    );
  }
}
