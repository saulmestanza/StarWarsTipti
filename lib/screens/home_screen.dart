import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/models/gender_values.dart';
import 'package:star_wars/provider/people_provider.dart';
import 'package:star_wars/widgets/list_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State with SingleTickerProviderStateMixin {
  String gender = "";
  late BuildContext providerCtx;
  int _selectedIndex = -1;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );
  final List<IconData> _icons = [
    Icons.male,
    Icons.female,
    Icons.star,
  ];

  Widget _buildIcon(BuildContext blocContext, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedIndex == index) {
            gender = "";
            _selectedIndex = -1;
          } else {
            _selectedIndex = index;
          }
          switch (index) {
            case 0:
              gender = Gender.male.name;
              break;
            case 1:
              gender = Gender.female.name;
              break;
            case 2:
              gender = Gender.na.name;
              break;
            default:
              gender = "";
              break;
          }
          _updateList(true, gender);
        });
      },
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
            color: _selectedIndex == index
                ? Theme.of(context).primaryColor
                : const Color(0xFFE7EBEE),
            borderRadius: BorderRadius.circular(30.0)),
        child: Icon(
          _icons[index],
          size: 25.0,
          color:
              _selectedIndex == index ? Colors.white : const Color(0xFFB4C1C4),
        ),
      ),
    );
  }

  _loadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  _buildListWidget(PeopleController controller, bool isLoading) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _icons
                .asMap()
                .entries
                .map((MapEntry map) => _buildIcon(context, map.key))
                .toList(),
          ),
          controller.dataState == PeopleState.Refreshing
              ? _loadingWidget()
              : PeopleViewWidget(controller.dataList, gender, isLoading),
          if (controller.dataState == PeopleState.More_Fetching)
            _loadingWidget(),
        ],
      ),
    );
  }

  _updateList(bool isRefresh, String gender) {
    Provider.of<PeopleController>(providerCtx, listen: false)
        .fetchData(isRefresh: isRefresh, gender: gender);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            return Transform.rotate(
              angle: _controller.value * atan2(1, 2) - pi,
              child: child,
            );
          },
          child: Image.asset(
            'assets/images/niteOwlsBackground.png',
            fit: BoxFit.contain,
            height: 60,
          ),
        ),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (context) => PeopleController(),
        child: Consumer<PeopleController>(
          builder:
              (BuildContext context, PeopleController controller, Widget? _) {
            providerCtx = context;
            switch (controller.dataState) {
              case PeopleState.Uninitialized:
                Future(() {
                  controller.fetchData();
                });
                return _buildListWidget(controller, true);
              case PeopleState.Initial_Fetching:
                return Container();
              case PeopleState.More_Fetching:
              case PeopleState.Refreshing:
                return _buildListWidget(controller, true);
              case PeopleState.Fetched:
              case PeopleState.Error:
              case PeopleState.No_More_Data:
                return _buildListWidget(controller, false);
            }
          },
        ),
      ),
    );
  }
}
