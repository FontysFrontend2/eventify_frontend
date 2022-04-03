import 'package:eventify_frontend/create_event/select_location.dart';
import 'package:eventify_frontend/create_event/select_tags.dart';
import 'package:flutter/material.dart';

void main() => runApp(const CreateEventView());

class CreateEventView extends StatelessWidget {
  const CreateEventView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NewEventForm();
  }
}

// Define a custom Form widget.
class NewEventForm extends StatefulWidget {
  const NewEventForm({Key? key}) : super(key: key);

  @override
  _NewEventFormState createState() => _NewEventFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _NewEventFormState extends State<NewEventForm> {
  // Create a text controller
  //and use it to retrieve the current value
  // of the TextField.
  bool _useLocation = false;
  String infoTestString = '';
  String _type = '';
  String _posLat = '';
  String _posLong = '';
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

// SCREEN:

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      viewTitle(context),
      Form(
          key: _formKey,
          child: Column(
            children: [
              titleForm(context),
              descriptionForm(context),
              selectTagsForm(context),
              selectLocationForm(context),
              submit(context),
            ],
          ))
    ]);
  }

// WIDGETS:

  Widget viewTitle(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Colors.amber,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        //margin: const EdgeInsets.only(bottom: 20),
        child: const Text(
          'Create new event',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }

  Widget titleForm(BuildContext context) {
    return Column(children: [
      const Text('Event title:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
      TextFormField(
          textAlign: TextAlign.center,
          controller: nameController,
          validator: (eventValue) {
            if (eventValue == null || eventValue.isEmpty) {
              return 'The event needs a title';
            }
            return null;
          }),
    ]);
  }

  Widget descriptionForm(BuildContext context) {
    return Column(children: [
      const Text('Event description:',
          style: TextStyle(fontWeight: FontWeight.bold)),
      TextFormField(
        textAlign: TextAlign.center,
        controller: descriptionController,
        validator: (descriptionValue) {
          if (descriptionValue == null || descriptionValue.isEmpty) {
            return 'The event needs a description';
          }

          return null;
        },
      )
    ]);
  }

  Widget selectTagsForm(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () => _showTagSelection(context),
            child: const Text('Select tags')),
        const Text('Selected tags:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        Text(_type),
      ],
    );
  }

  Widget selectLocationForm(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Use Location'),
            Switch(
                value: _useLocation,
                onChanged: (bool newValue) {
                  setState(() {
                    _useLocation = newValue;
                  });
                }),
          ],
        ),
        (_useLocation)
            ? (Container(
                color: Colors.amber,
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 40, right: 40),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => _showLocationSelection(context),
                      child: const Text('Set Location',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Column(children: [
                      const Text('Location for your event:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Text(_posLat + ' ' + _posLong),
                    ]),
                  ],
                )))
            : (Container())
      ],
    );
  }

// submit button and handling for the information
  Widget submit(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          if (_useLocation && (_posLat == '' || _posLat == 'null')) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'If you are using location You have to set it first!')),
            );
          } else {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            sendData(nameController.text, descriptionController.text, _posLat,
                _posLong);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Processing Data: ' + infoTestString)),
            );
          }
        }
      },
      child: const Text('SUBMIT',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  // sends data to database
  void sendData(
      String name, String description, String posLat, String posLong) {
    if (!_useLocation) {
      infoTestString = '\nname: ' +
          name +
          '\ndescription: ' +
          description +
          '\nLocationBased = false';
    } else {
      infoTestString = '\nname: ' +
          name +
          '\ndescription: ' +
          description +
          '\nLocationBased = true' +
          '\nLat: ' +
          posLat +
          '\nLong: ' +
          posLong;
    }
  }

  // LOCATION SET AND TAGS SET HANDLING:

// gets location from location class
  void _showLocationSelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => const SelectLocation()),
    );

    var _latLong = '$result'.split(", ");

    setState(() {
      _posLat = _latLong[0];
      _posLong = _latLong[1];
    });
  }

// gets tags from tag class
  void _showTagSelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => const SelectTags()),
    );
    print('result:' + '$result');
    setState(() {
      _type = '$result';
    });
  }
}
