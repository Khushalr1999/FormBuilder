import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder/model_form.dart';

final _formKey = GlobalKey<FormBuilderState>();
formModel form = new formModel();

class BuildForm extends StatefulWidget {
  @override
  State<BuildForm> createState() => _BuildFormState();
}

class _BuildFormState extends State<BuildForm> {
  @override
  void initState() {
    super.initState();
    form.ansOption = List<String>.empty(growable: true);
    form.ansOption!.add("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Form Builder')),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Title of Form",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            FormBuilderTextField(
              name: 'title',
              validator: (onValidateVal) {
                if (onValidateVal!.isEmpty) {
                  return "title cant be empty";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: "Title",
                labelStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(
                color: Colors.black,
              ),
              initialValue: form.title ?? 'Untitled',
              onChanged: (value) {
                form.title = value;
              },
            ),
            SizedBox(
              height: 28,
            ),
            _ansOption(),
            ElevatedButton(
              onPressed: () {
                print(form.toJson());
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ansOption() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Question",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        FormBuilderTextField(
          name: 'question',
          onChanged: (values) {
            form.question = values;
          },
          decoration: InputDecoration(
            labelText: "Question",
            labelStyle: TextStyle(color: Colors.grey),
          ),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 28,
        ),
        Center(
          child: FormBuilderDropdown(
            name: "Options",
            decoration: InputDecoration(
              labelText: "Options",
              labelStyle: TextStyle(color: Colors.grey),
            ),
            hint: Text(
              "Select Ans Type",
              style: TextStyle(color: Colors.black),
            ),
            items: ['Dropdown', 'Checkbox']
                .map(
                  (option) => DropdownMenuItem(
                    child: Text(
                      "$option",
                      style: TextStyle(color: Colors.black),
                    ),
                    value: option,
                  ),
                )
                .toList(),
            onChanged: (value) {
              form.options = value as String;
            },
          ),
        ),
        Text(
          "Ans",
          style: TextStyle(fontSize: 24),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ansOption(index),
                  ],
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: form.ansOption!.length,
            ),
          ],
        ),
      ],
    );
  }

  Widget ansOption(index) {
    void addFormControl() {
      setState(() {
        form.ansOption!.add("");
      });
    }

    void removeFormControl(index) {
      setState(() {
        if (form.ansOption!.length > 1) {
          form.ansOption!.removeAt(index);
        }
      });
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Flexible(
            child: FormBuilderTextField(
              name: 'ansOption_$index',
              validator: (onValidateVal) {
                if (onValidateVal!.isEmpty) {
                  return "ansOption${index + 1} cant be empty";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: "$index",
                labelStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) {
                form.ansOption![index] = value as String;
              },
            ),
          ),
          Visibility(
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
                onPressed: () {
                  addFormControl();
                },
              ),
            ),
            visible: index == form.ansOption!.length - 1,
          ),
          Visibility(
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  removeFormControl(index);
                },
              ),
            ),
            visible: index > 0,
          ),
        ],
      ),
    );
  }
}

bool validateAndSave() {
  final forms = _formKey.currentState;
  if (forms!.validate()) {
    forms.save();
    return true;
  } else {
    return false;
  }
}
