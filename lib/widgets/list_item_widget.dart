import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/models/people_model.dart';
import 'package:star_wars/provider/people_provider.dart';
import 'package:star_wars/widgets/text_field.dart';

class PeopleViewWidget extends StatelessWidget {
  final List<PeopleModel> _data;
  final String gender;
  bool _isLoading;

  PeopleViewWidget(this._data, this.gender, this._isLoading);

  late BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return _scrollNotificationWidget();
  }

  Widget _scrollNotificationWidget() {
    return Expanded(
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
                    title: Text(
                      people.name!,
                      maxLines: 1,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldWidget("Gënero: ", people.gender!),
                        const Text(
                          "Peliculas:",
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        people.filmsModel != null
                            ? Row(
                                children: people.filmsModel!
                                    .map(
                                      (film) => Text(
                                        film.title!,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                    .toList())
                            : Container()
                      ],
                    ),
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
    );
  }

  bool _scrollNotification(ScrollNotification scrollInfo) {
    if (!_isLoading &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      _isLoading = true;
      Provider.of<PeopleController>(_buildContext, listen: false)
          .fetchData(gender: gender);
    }
    return true;
  }
}
