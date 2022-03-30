import 'package:flutter/material.dart';

class SelectTags extends StatefulWidget {
  const SelectTags({Key? key}) : super(key: key);

  @override
  _SelectTagsState createState() => new _SelectTagsState();
}

class _SelectTagsState extends State<SelectTags> {
  final List _selecteCategorys = [];

  final Map<String, dynamic> _categories = {
    "responseBody": [
      {"tag_id": "0", "tag_name": "Football"},
      {"tag_id": "1", "tag_name": "Gaming"},
      {"tag_id": "2", "tag_name": "Studying"}
    ]
  };

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.builder(
          itemCount: _categories["responseBody"].length,
          itemBuilder: (BuildContext context, int index) {
            return Column(children: [
              CheckboxListTile(
                value: _selecteCategorys
                    .contains(_categories['responseBody'][index]['tag_name']),
                onChanged: (bool? selected) {
                  _onCategorySelected(selected!,
                      _categories['responseBody'][index]['tag_name']);
                },
                title: Text(_categories['responseBody'][index]['tag_name']),
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.pop(context, _selecteCategorys.toString()),
                child: const Text('Select'),
              ),
            ]);
          }),
    );
  }
}
