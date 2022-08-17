// ignore_for_file: sort_child_properties_last

import 'package:covid19_tracker_app_using_apis/services/utilities/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'details_screen.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  _CountriesListScreenState createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices newsListViewModel = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: 'Search with country name',
                  suffixIcon: searchController.text.isEmpty
                      ? const Icon(Icons.search)
                      : GestureDetector(
                          onTap: () {
                            searchController.text = "";
                            setState(() {});
                          },
                          child: Icon(Icons.clear)),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: newsListViewModel.countriesRecordsApi(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return Shimmer.fromColors(
                            child: ListView.builder(
                                itemCount: 4,
                                itemBuilder: ((context, index) {
                                  return ListTile(
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.white,
                                      ),
                                      subtitle: Container(
                                        height: 10,
                                        width: 80,
                                        color: Colors.white,
                                      ),
                                      title: Container(
                                        color: Colors.white,
                                        height: 10,
                                        width: 80,
                                      ));
                                })),
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100);
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name = snapshot.data![index]['country'];
                              if (searchController.text.isEmpty ||
                                  name.toLowerCase().contains(
                                      searchController.text.toLowerCase())) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                      image: snapshot
                                                                  .data![index]
                                                              ['countryInfo']
                                                          ['flag'],
                                                      name:
                                                          snapshot.data![index]
                                                              ['country'],
                                                      totalCases:
                                                          snapshot.data![index]
                                                              ['cases'],
                                                      totalRecovered:
                                                          snapshot.data![index]
                                                              ['recovered'],
                                                      totalDeaths:
                                                          snapshot.data![index]
                                                              ['deaths'],
                                                      active:
                                                          snapshot.data![index]
                                                              ['active'],
                                                      test:
                                                          snapshot.data![index]
                                                              ['tests'],
                                                      todayRecovered: snapshot
                                                              .data![index]
                                                          ['todayRecovered'],
                                                      critical:
                                                          snapshot.data![index]
                                                              ['critical'],
                                                    )));
                                      },
                                      child: ListTile(
                                        leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag']),
                                        ),
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text("Effected: " +
                                            snapshot.data![index]['cases']
                                                .toString()),
                                      ),
                                    ),
                                    Divider()
                                  ],
                                );
                                // } else if (name.toLowerCase().contains(
                                //     searchController.text.toLowerCase())) {
                                //   return Column(
                                //     children: [
                                //       ListTile(
                                //         leading: Image(
                                //           height: 50,
                                //           width: 50,
                                //           image: NetworkImage(
                                //               snapshot.data![index]['countryInfo']
                                //                   ['flag']),
                                //         ),
                                //         title: Text(
                                //             snapshot.data![index]['country']),
                                //         subtitle: Text("Effected: " +
                                //             snapshot.data![index]['cases']
                                //                 .toString()),
                                //       ),
                                //       Divider()
                                //     ],
                                //   );
                              } else {
                                return Container();
                              }
                            });
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
