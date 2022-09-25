import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/presentation/all_search/all_search/show_searches/search_list_tile_widget.dart';

import '../../../../controller/search_controller.dart';

class SearchResult extends StatefulWidget{
  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  SearchController? searchController;
  @override
  void initState() {
    searchController =
        Provider.of<SearchController>(context, listen: false);



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: const [
            Text(
              "Search Results",
            )
          ],
        ),
        actions: const [
          Icon(Icons.notifications_active),
          SizedBox(
            width: 20,
          ),
          Icon(Icons.settings),
          SizedBox(
            width: 20,
          )
        ],
      ),
      floatingActionButton:
      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          child: const Icon(Icons.chat),
          onPressed: () {
            //...
          },
          heroTag: null,
        ),
        const SizedBox(
          height: 20,
        ),
        FloatingActionButton(
          backgroundColor: Colors.pinkAccent,
          child: const Icon(Icons.search),
          onPressed: () => null,
          heroTag: null,
        )
      ]),
      body:  Container(
        child: Consumer<SearchController>(
        builder: (context, controller, child) {
      return controller.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount:
            (controller.searchedProfiles?.user ??
                [])
                .length,
            itemBuilder: (BuildContext context, int index) {
              return
                controller.searchedProfiles!.user![index].gender==null?
                SizedBox(width: 0,)
                    :
                SearchList(
                    data: controller
                        .searchedProfiles!.user!
                        .elementAt(index));
            }));})));
  }
}