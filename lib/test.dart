
import 'brain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'constant.dart';
import 'drawing.dart';




class RecognizerScreen extends StatefulWidget {
  @override
  _RecognizerScreenState createState() => _RecognizerScreenState();
}

class _RecognizerScreenState extends State<RecognizerScreen> {
  List<Offset> points = List();
  AppBrain brain = AppBrain();
  String hasil= 'hasil' ;
  @override
  void initState() {
    super.initState();
    brain.loadModel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('text'),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: Text(hasil,style: TextStyle(fontSize: 20),),



                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    border: Border.all()
                ),
                child: Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          RenderBox renderBox = context.findRenderObject();
                          points.add(
                              renderBox.globalToLocal(details.globalPosition));
                        });
                      },
                      onPanStart: (details) {
                        setState(() {
                          RenderBox renderBox = context.findRenderObject();
                          points.add(
                              renderBox.globalToLocal(details.globalPosition));
                        });
                      },
                      onPanEnd: (details) async {
                        points.add(null);
                        List predictions = await brain.processCanvasPoints(points);
                        print(predictions);
                        setState((){
                          hasil = '$predictions';
                        });
                      },
                      child: ClipRect(
                        child: CustomPaint(
                          size: Size(kCanvasSize, kCanvasSize),
                          painter: DrawingPainter(
                            offsetPoints: points,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: IconButton(icon:Icon (Icons.clear), onPressed: ()=> points.clear()),

                ),
              ),
            ],
          ),
        )
    );;
  }
}
