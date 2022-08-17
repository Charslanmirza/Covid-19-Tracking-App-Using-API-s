import 'package:covid19_tracker_app_using_apis/View/world_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  DetailScreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Card(
                    child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .06,
                    ),
                    ReuseableRow(
                      data: 'Cases',
                      value: widget.totalCases.toString(),
                    ),
                    ReuseableRow(
                      data: 'Recovered',
                      value: widget.totalRecovered.toString(),
                    ),
                    ReuseableRow(
                      data: 'Death',
                      value: widget.totalDeaths.toString(),
                    ),
                    ReuseableRow(
                      data: 'Critical',
                      value: widget.critical.toString(),
                    ),
                    ReuseableRow(
                      data: 'Today Recovered',
                      value: widget.totalRecovered.toString(),
                    ),
                  ],
                )),
              ),
              Positioned(
                  child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  widget.image,
                ),
              )),
            ],
          )
        ],
      )),
    );
  }
}
