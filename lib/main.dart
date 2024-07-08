import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:utip/widgets/person_counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(context.widget); //出力：MyApp
    return MaterialApp(
      title: 'UTip App',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 4, 255)),
        useMaterial3: true,
      ),
      home: const UTip(),
    );
  }
}

class UTip extends StatefulWidget {
  const UTip({super.key});

  @override
  State<UTip> createState() => _UTipState();
}

class _UTipState extends State<UTip> {
  int _personCount = 1;

  double _tipPercentage = 0.0;

  //Methods
  void increment() {
    setState(() {
      _personCount++;
    });
  }

  void decrement() {
    setState(() {
      if (_personCount > 0) {
        _personCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(context.widget); //出力：UTip
    var theme =
        Theme.of(context); //テーマが添付されている最も近いウィジェットのテーマを取得して、それを変数themeに格納して使用
    final style = theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: const Text('UTip'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  // Theme基準で色使用
                  color: theme.colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: [
                  Text("Total per person",
                      //Theme基準から文字サイズ使用
                      style: style),
                  Text("\$ price 円",
                      style: style.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontSize: theme.textTheme.displaySmall?.fontSize))
                ],
              ),
            ),
          ),
          //Form
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 100,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: theme.colorScheme.primary, width: 2),
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.attach_money),
                        labelText: "Bill Amount"),
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      print("Value: $value");
                    },
                  ),
                  // Split Bill area
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Split",
                        style: theme.textTheme.titleMedium,
                      ),
                      PersonCounter(
                        theme: theme,
                        personCount: _personCount,
                        onDecrement: decrement,
                        onIncrement: increment,
                      ),
                    ],
                  ),
                  // == Tip Section ==
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tip", style: theme.textTheme.titleMedium),
                      Text("\$ tip 円", style: theme.textTheme.titleMedium),
                    ],
                  ),

                  // == Slider Text ==
                  Text("${(_tipPercentage * 100).round()} %"),

                  // == Tip Slider ==
                  TipSlider(
                    tipPercentage: _tipPercentage,
                    onChanged: (double value) {
                      setState(() {
                        _tipPercentage = value;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
