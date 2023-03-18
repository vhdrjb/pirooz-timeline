import 'package:flutter/material.dart';
import 'package:pirooz_timeline/pirooz_timeline.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        home: Scaffold(
          body: Center(
              child: PiroozTimeline(
            flex: 5,
            indicatorAlignment: IndicatorAlignment.top,
            indicatorBuilder: (model, index) {
              if (model is A) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Colors.redAccent, shape: BoxShape.circle),
                  child: Text(index.toString()),
                );
              } else if (model is C) {
                return Container();
              } else {
                return Container(
                  height: 10,
                  decoration: const BoxDecoration(
                      color: Colors.redAccent, shape: BoxShape.circle),
                );
              }
            },
            connectorStyle: const ConnectorStyle(
              color: Colors.amber,
              dashSpace: 4,
              dashHeight: 5,
            ),
            models: const [],
            widgetBuilder: (PiroozModel model, int index) {
              if (model is A) {
                return _Indicator(time: model.value,icon: "",);
              } else if (model is C) {
                return const Divider(
                  thickness: 2,
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text((model as B).valaue),
                );
              }
            },
          )),
        ));
  }
}

class _Indicator extends StatelessWidget {
  final String icon;
  final String time;

  const _Indicator({Key? key, required this.icon, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 55,
      child: Stack(
        children: [
          Positioned(
            right: 10,
            left: 20,
            top: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(10))),
                child: Text(
                  time,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.ac_unit),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  color: Colors.green,
                  shape: BoxShape.circle),
            ),
          )
        ],
      ),
    );
  }
}

class A extends PiroozModel {
  final String value;

  const A({required this.value});
}

class B extends PiroozModel {
  final String valaue;

  const B({required this.valaue});
}

class C extends PiroozModel {
  const C();
}
