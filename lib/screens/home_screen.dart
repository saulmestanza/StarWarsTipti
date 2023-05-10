import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/provider/people_provider.dart';
import 'package:star_wars/widgets/list_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/niteOwlsBackground.png',
          fit: BoxFit.contain,
          height: 60,
        ),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (context) => PeopleController(),
        child: Consumer<PeopleController>(
          builder:
              (BuildContext context, PeopleController controller, Widget? _) {
            switch (controller.dataState) {
              case DataState.Uninitialized:
                Future(() {
                  controller.fetchData();
                });
                return PeopleViewWidget(controller.dataList, true);
              case DataState.Initial_Fetching:
                return Container();
              case DataState.More_Fetching:
              case DataState.Refreshing:
                return PeopleViewWidget(controller.dataList, true);
              case DataState.Fetched:
              case DataState.Error:
              case DataState.No_More_Data:
                return PeopleViewWidget(controller.dataList, false);
            }
          },
        ),
      ),
    );
  }
}
