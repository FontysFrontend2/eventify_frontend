import 'dart:developer';

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
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

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
              const Text('Event name:'),
              TextFormField(
                controller: nameController,
                validator: (eventValue) {
                  if (eventValue == null || eventValue.isEmpty) {
                    return 'Please fill text field';
                  }
                  return null;
                },
              ),
              const Text('Event description:'),
              TextFormField(
                controller: descriptionController,
                validator: (descriptionValue) {
                  if (descriptionValue == null || descriptionValue.isEmpty) {
                    return 'Please fill text field';
                  }

                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    SendData(nameController.text, descriptionController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Icon(Icons.text_fields),
              ),
            ],
          ))
    ]);
  }
}

// event location is in select location class under variable location as a string
void SendData(String name, String description) {
  print(name + description);
}
