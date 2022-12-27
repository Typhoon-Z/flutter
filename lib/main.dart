import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(



          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
              textAlign: TextAlign.center,
              style: TextStyle(
              color: Colors.purpleAccent,
              fontSize: 20.0,
              height: 1.2,
              fontFamily: "Courier",
              decoration:TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed
          ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            GradientButton(
              colors: const [Colors.orange, Colors.red],
              height: 50.0,
              child: const Text("GradientButton"),
              onPressed: onTap,
            ),
            GradientButton(
              height: 50.0,
              colors: [Colors.lightGreen, Colors.green.shade700],
              child: const Text("GradientButton"),
              onPressed: onTap,
            ),
            GradientButton(
              height: 50.0,
              //borderRadius: const BorderRadius.all(Radius.circular(5)),
              colors: [Colors.lightBlue.shade300, Colors.blueAccent],
              child: const Text("GradientButton"),
              onPressed: onTap,
            ),

            Expanded(child: Stack(
              children: [
                wPage(),
                IgnorePointer(
                  child: WaterMark(
                    painter: TextWaterMarkPainter(
                      text: '20191060072张唯一',
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        color: Colors.black38, //为了水印能更清晰一些，颜色深一点
                      ),
                      rotate: -20, // 旋转 -20 度
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  onTap() {
    print("button click");
  }
  Widget wPage() {
    return Center(
    );
  }
}
class GradientButton extends StatelessWidget {
  const GradientButton({Key? key,
    this.colors,
    this.width,
    this.height,
    this.onPressed,
    this.borderRadius,
    required this.child,
  }) : super(key: key);

  // 渐变色数组
  final List<Color>? colors;

  // 按钮宽高
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  //点击回调
  final GestureTapCallback? onPressed;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    //确保colors数组不空
    List<Color> _colors =
        colors ?? [theme.primaryColor, theme.primaryColorDark];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors),
        borderRadius: borderRadius,
        //border: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



/// A widget that paints watermark.
class WaterMark extends StatefulWidget {
  const WaterMark({
    Key? key,
    this.repeat = ImageRepeat.repeat,
    required this.painter,
  }) : super(key: key);

  /// 单元水印画笔
  final WaterMarkPainter painter;

  /// 单元水印的重复方式
  final ImageRepeat repeat;

  @override
  State<WaterMark> createState() => _WaterMarkState();
}

class _WaterMarkState extends State<WaterMark> {
  late Future<MemoryImage> _memoryImageFuture;

  @override
  void initState() {
    // 缓存的是promise
    _memoryImageFuture = _getWaterMarkImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FutureBuilder(
        future: _memoryImageFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          } else {
            return DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: snapshot.data,
                  repeat: widget.repeat,
                  alignment: Alignment.topLeft,
                  //很重要
                  scale: MediaQuery.of(context).devicePixelRatio,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void didUpdateWidget(WaterMark oldWidget) {
    // 如果画笔发生了变化（类型或者配置）则重新绘制水印
    if (widget.painter.runtimeType != oldWidget.painter.runtimeType ||
        widget.painter.shouldRepaint(oldWidget.painter)) {
      //先释放之前的缓存
      _memoryImageFuture.then((value) => value.evict());
      //重新绘制并缓存
      _memoryImageFuture = _getWaterMarkImage();
    }
    super.didUpdateWidget(oldWidget);
  }

  // 离屏绘制单元水印并将绘制结果保存为图片缓存起来
  Future<MemoryImage> _getWaterMarkImage() async {
    // 创建一个 Canvas 进行离屏绘制，细节和原理请查看本书后面关于Flutter绘制原理相关章节
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    // 绘制单元水印并获取其大小
    final size = widget.painter.paintUnit(
      canvas,
      MediaQueryData.fromWindow(ui.window).devicePixelRatio,
    );
    final picture = recorder.endRecording();
    //将单元水印导为图片并缓存起来
    final img = await picture.toImage(size.width.ceil(), size.height.ceil());
    picture.dispose();
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    img.dispose();
    final pngBytes = byteData!.buffer.asUint8List();
    return MemoryImage(pngBytes);
  }

  @override
  void dispose() {
    //释放图片缓存
    _memoryImageFuture.then((value) => value.evict());
    super.dispose();
  }
}

/// 定义水印画笔
abstract class WaterMarkPainter {
  /// 绘制"单元水印"，完整的水印是由单元水印重复平铺组成,返回值为"单元水印"占用空间的大小。
  /// [devicePixelRatio]: 因为最终要将绘制内容保存为图片，所以在绘制时需要根据屏幕的
  /// DPR来放大，以防止失真
  Size paintUnit(Canvas canvas, double devicePixelRatio);

  /// 是否需要重绘
  bool shouldRepaint(covariant WaterMarkPainter oldPainter) => true;
}

/// 文本水印画笔
class TextWaterMarkPainter extends WaterMarkPainter {
  TextWaterMarkPainter(
      {Key? key,
        double? rotate,
        EdgeInsets? padding,
        TextStyle? textStyle,
        required this.text,
        this.textDirection = TextDirection.ltr})
      : assert(rotate == null || rotate >= -90 && rotate <= 90),
        rotate = rotate ?? 0,
        padding = padding ?? const EdgeInsets.all(10.0),
        textStyle = textStyle ??
            const TextStyle(
              color: Color.fromARGB(30, 0, 0, 0),
              fontSize: 14,
            );

  double rotate; // 文本旋转的度数，是角度不是弧度
  TextStyle textStyle; // 文本样式
  EdgeInsets padding; // 文本的 padding
  String text; // 文本
  TextDirection textDirection;

  // @override
  // Size paintUnit(Canvas canvas, double devicePixelRatio) {
  //
  //   //构建文本段落
  //   final _textStyle = _handleTextStyle(textStyle, devicePixelRatio);
  //   final _padding = padding * devicePixelRatio;
  //
  //   final builder = ui.ParagraphBuilder(_textStyle.getParagraphStyle(
  //     textDirection: textDirection,
  //     textAlign: TextAlign.start,
  //     textScaleFactor: devicePixelRatio,
  //   ));
  //   //添加要绘制的文本及样式
  //   builder
  //     ..pushStyle(_textStyle.getTextStyle())
  //     ..addText(text);
  //
  //   //layout 后我们才能知道文本占用的空间
  //   ui.Paragraph paragraph = builder.build()
  //     ..layout(ui.ParagraphConstraints(width: double.infinity));
  //
  //   //文本占用的真实宽度
  //   final textWidth = paragraph.longestLine.ceilToDouble();
  //   //文本占用的真实高度
  //   final textHeight = paragraph.height;
  //
  //
  //   // 将弧度转化为度数
  //   final radians = math.pi * rotate / 180;
  //
  //   //通过三角函数计算旋转后的位置和size
  //   final orgSin = math.sin(radians);
  //   final sin = orgSin.abs();
  //   final cos = math.cos(radians).abs();
  //
  //   final width = textWidth * cos;
  //   final height = textWidth * sin;
  //   final adjustWidth = textHeight * sin;
  //   final adjustHeight = textHeight * cos;
  //
  //   if (orgSin >= 0) {
  //     canvas.translate(
  //       adjustWidth + _padding.left,
  //       _padding.top,
  //     );
  //   } else {
  //     canvas.translate(
  //       _padding.left,
  //       height + _padding.top,
  //     );
  //   }
  //   canvas.rotate(radians);
  //   // 绘制文本
  //   canvas.drawParagraph(paragraph, Offset.zero);
  //
  //   return Size(
  //     width + adjustWidth + _padding.horizontal,
  //     height + adjustHeight + _padding.vertical,
  //   );
  // }

  @override
  Size paintUnit(Canvas canvas, double devicePixelRatio) {
    //根据屏幕 devicePixelRatio 对文本样式中长度相关的一些值乘以devicePixelRatio
    final _textStyle = _handleTextStyle(devicePixelRatio);
    final _padding = padding * devicePixelRatio;

    //构建文本画笔
    TextPainter painter = TextPainter(
      textDirection: TextDirection.ltr,
      textScaleFactor: devicePixelRatio,
    );
    //添加文本和样式
    painter.text = TextSpan(text: text, style: _textStyle);
    //对文本进行布局
    painter.layout();

    //文本占用的真实宽度
    final textWidth = painter.width;
    //文本占用的真实高度
    final textHeight = painter.height;

    // 将弧度转化为度数
    final radians = math.pi * rotate / 180;

    //通过三角函数计算旋转后的位置和size
    final orgSin = math.sin(radians);
    final sin = orgSin.abs();
    final cos = math.cos(radians).abs();

    final width = textWidth * cos;
    final height = textWidth * sin;
    final adjustWidth = textHeight * sin;
    final adjustHeight = textHeight * cos;

    if (orgSin >= 0) {
      canvas.translate(
        adjustWidth + _padding.left,
        _padding.top,
      );
    } else {
      canvas.translate(
        _padding.left,
        height + _padding.top,
      );
    }
    canvas.rotate(radians);
    // 绘制文本
    painter.paint(canvas, Offset.zero);

    return Size(
      width + adjustWidth + _padding.horizontal,
      height + adjustHeight + _padding.vertical,
    );
  }

  TextStyle _handleTextStyle(double devicePixelRatio) {
    var style = textStyle;
    double _scale(attr) => attr == null ? 1.0 : devicePixelRatio;
    return style.apply(
      decorationThicknessFactor: _scale(style.decorationThickness),
      letterSpacingFactor: _scale(style.letterSpacing),
      wordSpacingFactor: _scale(style.wordSpacing),
      heightFactor: _scale(style.height),
    );
  }

  @override
  bool shouldRepaint(TextWaterMarkPainter oldPainter) {
    return oldPainter.rotate != rotate ||
        oldPainter.text != text ||
        oldPainter.padding != padding ||
        oldPainter.textDirection != textDirection ||
        oldPainter.textStyle != textStyle;
  }
}

/// 交错文本水印画笔，可以在水平或垂直方向上组合两个文本水印，
/// 通过给第二个文本水印指定不同的 padding 来实现交错效果。
class StaggerTextWaterMarkPainter extends WaterMarkPainter {
  StaggerTextWaterMarkPainter({
    required this.text,
    String? text2,
    this.padding1,
    this.padding2 = const EdgeInsets.all(30),
    this.rotate,
    this.textStyle,
    this.staggerAxis = Axis.vertical,
    this.textDirection = TextDirection.ltr,
  }) : text2 = text2 ?? text;

  String text;
  String text2;
  double? rotate;
  TextStyle? textStyle;
  EdgeInsets? padding1;
  EdgeInsets padding2;
  Axis staggerAxis;
  TextDirection textDirection;

  @override
  Size paintUnit(Canvas canvas, double devicePixelRatio) {
    final TextWaterMarkPainter painter = TextWaterMarkPainter(
      text: text,
      padding: padding1,
      rotate: rotate ?? 0,
      textStyle: textStyle,
      textDirection: textDirection,
    );
    // 绘制第一个文本水印前保存画布状态，因为在绘制过程中可能会平移或旋转画布
    canvas.save();
    // 绘制第一个文本水印
    final size1 = painter.paintUnit(canvas, devicePixelRatio);
    // 绘制完毕后恢复画布状态。
    canvas.restore();
    // 确定交错方向
    bool vertical = staggerAxis == Axis.vertical;
    // 将Canvas 平移至第二个文本水印的起始绘制点
    canvas.translate(vertical ? 0 : size1.width, vertical ? size1.height : 0);
    // 设置第二个文本水印的 padding 和 text2
    painter
      ..padding = padding2
      ..text = text2;
    // 绘制第二个文本水印
    final size2 = painter.paintUnit(canvas, devicePixelRatio);
    // 返回两个文本水印所占用的总大小
    return Size(
      vertical ? math.max(size1.width, size2.width) : size1.width + size2.width,
      vertical
          ? size1.height + size2.height
          : math.max(size1.height, size2.height),
    );
  }

  @override
  bool shouldRepaint(StaggerTextWaterMarkPainter oldPainter) {
    return oldPainter.rotate != rotate ||
        oldPainter.text != text ||
        oldPainter.text2 != text2 ||
        oldPainter.staggerAxis != staggerAxis ||
        oldPainter.padding1 != padding1 ||
        oldPainter.padding2 != padding2 ||
        oldPainter.textDirection != textDirection ||
        oldPainter.textStyle != textStyle;
  }
}