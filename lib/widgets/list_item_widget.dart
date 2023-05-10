import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/models/people_model.dart';
import 'package:star_wars/provider/people_provider.dart';

class PeopleViewWidget extends StatelessWidget {
  final List<PeopleModel> _data;
  bool _isLoading;

  PeopleViewWidget(this._data, this._isLoading);

  late DataState _dataState;
  late BuildContext _buildContext;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _dataState =
        Provider.of<PeopleController>(context, listen: false).dataState;
    _buildContext = context;
    return SafeArea(child: _scrollNotificationWidget());
  }

  Widget _scrollNotificationWidget() {
    return Column(
      children: [
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: _scrollNotification,
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                PeopleModel people = _data[index];
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(people.name!),
                        subtitle: Text(people.gender!),
                        leading: Image.asset(
                          'assets/images/niteOwlsBackground.png',
                          fit: BoxFit.contain,
                          height: 60,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        if (_dataState == DataState.More_Fetching)
          const Center(child: CircularProgressIndicator()),
      ],
    );
  }

  bool _scrollNotification(ScrollNotification scrollInfo) {
    if (!_isLoading &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      _isLoading = true;
      Provider.of<PeopleController>(_buildContext, listen: false).fetchData();
    }
    return true;
  }
}
