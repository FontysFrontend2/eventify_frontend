import 'package:eventify_frontend/apis/controllers/interest_controller.dart';
import 'package:eventify_frontend/apis/models/interest_model.dart';
import 'package:flutter/material.dart';

class SelectTags extends StatefulWidget {
  const SelectTags({Key? key}) : super(key: key);

  @override
  _SelectTagsState createState() => new _SelectTagsState();
}

class _SelectTagsState extends State<SelectTags> {
  final List _selecteCategorys = [];
  late List interestListFromApi = []; // Interest List from database

  late Future<List<InterestData>> futureAllInterestsData;

  void _onCategorySelected(bool selected, categoryId) {
    if (selected == true) {
      setState(() {
        _selecteCategorys.add(categoryId);
      });
    } else {
      setState(() {
        _selecteCategorys.remove(categoryId);
      });
    }
  }

  loadInterests() async {
    interestListFromApi = await fetchAllInterestData();
    setState(() {
      List<InterestData> interests = [];
      print(interestListFromApi[0].name);
    });
  }

  @override
  void initState() {
    loadInterests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(children: [
          (interestListFromApi.length > 0)
              ? (Column(children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: interestListFromApi.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CheckboxListTile(
                          value: _selecteCategorys
                              .contains(interestListFromApi[index].id),
                          onChanged: (bool? selected) {
                            _onCategorySelected(
                                selected!, interestListFromApi[index].id);
                          },
                          title: Text(interestListFromApi[index].name),
                        );
                      }),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, _selecteCategorys),
                    child: const Text('Select'),
                  ),
                ]))
              : (Container())
        ]));
  }
}
