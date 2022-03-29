import 'package:eventify_frontend/create_event/select_location.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text(
        'Create new event, select information',
        style: TextStyle(fontSize: 20),
      ),
      Form(
          key: _formKey,
          child: Column(
            children: [
              const Text('Event name:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              Padding(padding: EdgeInsets.only(top: 10)),
              TextFormField(
                controller: nameController,
                validator: (eventValue) {
                  if (eventValue == null || eventValue.isEmpty) {
                    return 'Please fill text field';
                  }
                  return null;
                },
              ),
              const Text('Event description:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                controller: descriptionController,
                validator: (descriptionValue) {
                  if (descriptionValue == null || descriptionValue.isEmpty) {
                    return 'Please fill text field';
                  }

                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Use Location '),
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
                  ? (Column(
                      children: [
                        TextButton(
                          onPressed: () =>
                              _navigateAndDisplaySelection(context),
                          child: const Text('Select Location',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Column(children: [
                          const Text('Location for your event:'),
                          Text(_posLat + ' ' + _posLong),
                        ])
                      ],
                    ))
                  : (Container()),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    sendData(nameController.text, descriptionController.text,
                        _posLat, _posLong);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Processing Data: ' + infoTestString)),
                    );
                  }
                },
                child: const Icon(Icons.switch_access_shortcut_rounded),
              ),
            ],
          ))
    ]);
  }

// event location is in select location class under variable location as a string
  void sendData(
      String name, String description, String posLat, String posLong) {
    infoTestString = '\nname: ' +
        name +
        '\ndescription: ' +
        description +
        '\nLat: ' +
        posLat +
        '\nLong: ' +
        posLong;
  }

// event location is in select location class under variable location as a string
  void _navigateAndDisplaySelection(BuildContext context) async {
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
}
