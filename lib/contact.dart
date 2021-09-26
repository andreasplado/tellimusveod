import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Define a custom Form widget.
class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  ContactState createState() {
    return ContactState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class ContactState extends State<Contact> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text('Kontakt'),
            ],
          ),


          backgroundColor: Colors.blue[400],
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
              child: IconButton(
                icon: Icon(
                  Icons.save,
                  size: 32.0,
                ),
                onPressed: () {
                },
              ),
            ),


          ],


        ),
        body: Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 0),child: Column(
      children: <Widget>[
        FormBuilder(
          key: _fbKey,
          child: Column(
            children: <Widget>[
              FormBuilderDateTimePicker(
                inputType: InputType.date,
                format: DateFormat("yyyy-MM-dd"),
                decoration: InputDecoration(labelText: "Appointment Time"),
                name: 'k',
              ),
              FormBuilderSlider(
                min: 0.0,
                max: 10.0,
                initialValue: 1.0,
                divisions: 20,
                decoration: InputDecoration(labelText: "Number of somethings"),
                name: 'h',
              ),
              FormBuilderCheckbox(
                initialValue: false,
                name: 'kjkk',
                title: Text("rf"),
              ),
              FormBuilderDropdown(
                decoration: InputDecoration(labelText: "Gender"),
                // initialValue: 'Male',
                hint: Text('Select Gender'),
                items: ['Male', 'Female', 'Other']
                    .map((gender) =>
                        DropdownMenuItem(value: gender, child: Text("$gender")))
                    .toList(),
                name: 'cddvvd',
              ),
              FormBuilderTextField(
                decoration: InputDecoration(labelText: "Age"),
                name: 'dddd',
              ),
              FormBuilderSegmentedControl(
                decoration: InputDecoration(labelText: "Movie Rating (Archer)"),
                options: List.generate(5, (i) => i + 1)
                    .map((number) => FormBuilderFieldOption(value: number))
                    .toList(),
                name: 'jhju',
              ),
              FormBuilderSwitch(
                initialValue: true,
                name: 'hjhjhhj',
                title: Text("fff"),
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            MaterialButton(
              onPressed: () {},
              child: Text("Submit"),
            ),
            MaterialButton(
              child: Text("Reset"),
              onPressed: () {},
            ),
          ],
        )
      ],
    )));
  }
}
