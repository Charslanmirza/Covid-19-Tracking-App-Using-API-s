// ignore_for_file: sort_child_properties_last

import 'package:covid19_tracker_app_using_apis/View/countries_stats.dart';
import 'package:covid19_tracker_app_using_apis/constants/constant.dart';
import 'package:covid19_tracker_app_using_apis/models/example.dart';
import 'package:covid19_tracker_app_using_apis/services/utilities/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldState extends StatefulWidget {
  const WorldState({Key? key}) : super(key: key);

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    StatesServices statesServices = StatesServices();

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: height * 0.04,
            ),
            FutureBuilder(
                future: statesServices.worldStatesRecords(),
                builder: ((context, AsyncSnapshot<AutoGenerate> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      child: SpinKitFadingCircle(
                        controller: _controller,
                        color: Colors.white,
                        size: 50,
                      ),
                      flex: 1,
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                            chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                            dataMap: {
                              "Total":
                                  double.parse(snapshot.data!.cases.toString()),
                              "Recovered": double.parse(
                                  snapshot.data!.recovered.toString()),
                              "Death": double.parse(
                                  snapshot.data!.deaths.toString()),
                            },
                            animationDuration: Duration(seconds: 3),
                            colorList: colorList,
                            chartType: ChartType.ring,
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.1),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.03),
                          child: Card(
                            child: Column(
                              children: [
                                ReuseableRow(
                                    data: "Total Cases",
                                    value: snapshot.data!.cases.toString()),
                                ReuseableRow(
                                    data: "Recovered",
                                    value: snapshot.data!.recovered.toString()),
                                ReuseableRow(
                                    data: "Total Deaths",
                                    value: snapshot.data!.deaths.toString()),
                                ReuseableRow(
                                    data: "Active",
                                    value: snapshot.data!.active.toString()),
                                ReuseableRow(
                                    data: "Today Recovered",
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                                ReuseableRow(
                                    data: "Critical",
                                    value: snapshot.data!.critical.toString()),
                                ReuseableRow(
                                    data: "Affected Countries",
                                    value: snapshot.data!.affectedCountries
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CountriesListScreen()));
                          },
                          child: Container(
                            height: 50,
                            width: width,
                            child: Center(child: Text("Track Countries")),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: green),
                          ),
                        )
                      ],
                    );
                  }
                })),
          ],
        ),
      )),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  ReuseableRow({Key? key, required this.data, required this.value})
      : super(key: key);
  String data, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data),
              Text(value),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider()
        ],
      ),
    );
  }
}
