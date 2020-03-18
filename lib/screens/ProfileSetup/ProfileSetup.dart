import 'package:bluetoothScanner/models/modelHelpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../providers/providers.dart';
import '../../helpers/helpers.dart';

class ClickableTextField extends StatelessWidget {
  final Function onTap;
  final String label, hint;
  final TextInputType type;
  final TextInputAction action;
  final Function validator, onSaved, onSubmit;
  final FocusNode focusNode;
  final bool isPassword;
  final TextEditingController controller;

  ClickableTextField({
    @required this.hint,
    @required this.label,
    @required this.action,
    this.onSaved,
    @required this.type,
    @required this.validator,
    this.onSubmit,
    this.focusNode,
    this.isPassword,
    this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            focusNode: focusNode,
            textInputAction: action,
            onFieldSubmitted: onSubmit,
            obscureText: isPassword == null ? false : isPassword,
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            keyboardType: type,
            onSaved: onSaved,
            validator: validator,
            controller: controller,
          ),
        ),
      ),
    );
  }
}

class GenericTextField extends StatelessWidget {
  final String label, hint;
  final TextInputType type;
  final TextInputAction action;
  final Function validator, onSaved, onSubmit;
  final FocusNode focusNode;
  final bool isPassword;
  final TextEditingController controller;
  final List<TextInputFormatter> formatter;

  GenericTextField(
      {@required this.hint,
      @required this.label,
      @required this.action,
      this.onSaved,
      @required this.type,
      @required this.validator,
      this.onSubmit,
      this.focusNode,
      this.isPassword,
      this.controller,
      this.formatter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        focusNode: focusNode,
        textInputAction: action,
        inputFormatters: null == formatter ? [] : formatter,
        onFieldSubmitted: (String value) {
          debugPrint("onSubmit Called on label $label");
          if (null != onSubmit) onSubmit(value);
        },
        obscureText: isPassword == null ? false : isPassword,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        keyboardType: type,
        onSaved: (String value) {
          debugPrint("onSaved Called on label $label");
          if (null != onSaved) onSaved(value);
        },
        validator: validator,
        controller: controller,
      ),
    );
  }
}

class ProfileSetupPage1 extends StatefulWidget {
  static final route = "/profileSetup/1";

  @override
  _ProfileSetupPage1State createState() => _ProfileSetupPage1State();
}

class _ProfileSetupPage1State extends State<ProfileSetupPage1> {
  final FocusNode dobFocusNode = FocusNode();
  final FocusNode genderFocusNode = FocusNode();
  final FocusNode weightFocusNode = FocusNode();
  final FocusNode heightFocusNode = FocusNode();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  final _profileSetupFormKey = GlobalKey<FormState>();

  void _genderPopUp(UserExtendedProfileProvider data) async {
    showDialog(
      context: context,
      child: SimpleDialog(
        title: const Text('Select Gender'),
        children: GenderOption.values.map((f) {
          if (null != f.value)
            return SimpleDialogOption(
              child: Text(f.value),
              onPressed: () {
                data.gender = f;
                genderController.text = f.value;
                Navigator.pop(context);
              },
            );
          return SizedBox.shrink();
        }).toList(),
      ),
    );
  }

  void goToNextStep() {
    if (_profileSetupFormKey.currentState.validate()) {
      Navigator.pushNamed(context, "/profileSetup/2");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Setup'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Form(
            key: _profileSetupFormKey,
            child: Consumer<UserExtendedProfileProvider>(
              builder: (ctx, data, wgt) {
                return ListView(
                  padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  children: <Widget>[
                    ClickableTextField(
                      onTap: () async {
                        DateTime date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                          builder: (BuildContext context, Widget child) {
                            return Theme(
                              data: ThemeData.light(),
                              child: child,
                            );
                          },
                        );
                        data.setDateOfBirth(date);
                        dobController.text = DateFormat.yMd().format(date);
                      },
                      onSaved: (value) {},
                      onSubmit: (_) {},
                      controller: dobController,
                      action: TextInputAction.next,
                      hint: "09/02/2005",
                      type: TextInputType.datetime,
                      label: "Date of Birth",
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select your date of birth';
                        }
                        return null;
                      },
                    ),
                    ClickableTextField(
                      onTap: () {
                        _genderPopUp(data);
                      },
                      onSubmit: (_) {},
                      focusNode: genderFocusNode,
                      controller: genderController,
                      action: TextInputAction.next,
                      hint: "Male",
                      type: TextInputType.text,
                      label: "Gender",
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please select your gender';
                        }
                        return null;
                      },
                    ),
                    GenericTextField(
                      onSubmit: (value) {
                        data.weight = double.parse(value);
                        FocusScope.of(context).requestFocus(heightFocusNode);
                      },
                      focusNode: weightFocusNode,
                      action: TextInputAction.next,
                      hint: "80",
                      type: TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      label: "Weight (Kgs)",
                      formatter: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your weight';
                        }
                        if (double.parse(value) < 1) {
                          return "Weight should be a mimium of 1 Kg";
                        }
                        return null;
                      },
                    ),
                    GenericTextField(
                        onSaved: (value) {
                          data.height = value;
                        },
                        onSubmit: (value) {
                          data.height = double.parse(value);
                          goToNextStep();
                        },
                        focusNode: heightFocusNode,
                        action: TextInputAction.done,
                        hint: "160",
                        type: TextInputType.numberWithOptions(
                            decimal: true, signed: false),
                        label: "Height (cms)",
                        formatter: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your height';
                          }
                          if (double.parse(value) < 1) {
                            return "Height should be a mimium of 1 cm";
                          }
                          return null;
                        }),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class ProfileSetupPage2 extends StatefulWidget {
  static final route = "/profileSetup/2";

  @override
  _ProfileSetupPage2State createState() => _ProfileSetupPage2State();
}

class _ProfileSetupPage2State extends State<ProfileSetupPage2> {
  final FocusNode _educationFocusNode = FocusNode();
  final FocusNode _jobStatusFocusNode = FocusNode();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController jobStatusController = TextEditingController();

  final _profileSetupFormKey = GlobalKey<FormState>();

  void _educationPopUp(UserExtendedProfileProvider data) async {
    debugPrint("clicked");
    showDialog(
      context: context,
      child: SimpleDialog(
        title: const Text('Select your current education Level'),
        children: EducationLevel.values.map((f) {
          if (null != f.value)
            return SimpleDialogOption(
              child: Text(f.value),
              onPressed: () {
                data.educationLevel = f;
                educationController.text = f.value;
                Navigator.pop(context);
              },
            );
          return SizedBox.shrink();
        }).toList(),
      ),
    );
  }

  void _jobStatusPopUp(UserExtendedProfileProvider data) async {
    showDialog(
      context: context,
      child: SimpleDialog(
        title: const Text('Select your current job status'),
        children: JobStatus.values.map((f) {
          if (null != f.value)
            return SimpleDialogOption(
              child: Text(f.value),
              onPressed: () {
                data.jobStatus = f;
                jobStatusController.text = f.value;
                Navigator.pop(context);
              },
            );
          return SizedBox.shrink();
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Setup'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Form(
            key: _profileSetupFormKey,
            child: Consumer<UserExtendedProfileProvider>(
              builder: (ctx, data, wgt) {
                return ListView(
                  padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  children: <Widget>[
                    ClickableTextField(
                      onTap: () {
                        _educationPopUp(data);
                      },
                      onSaved: (value) {},
                      controller: educationController,
                      onSubmit: (_) {},
                      focusNode: _educationFocusNode,
                      action: TextInputAction.next,
                      hint: "Bachelor",
                      type: TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      label: "Current Education Level",
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter your current education level";
                        }
                        return null;
                      },
                    ),
                    ClickableTextField(
                      onTap: () {
                        _jobStatusPopUp(data);
                      },
                      onSaved: (value) {},
                      controller: jobStatusController,
                      onSubmit: (_) {},
                      focusNode: _jobStatusFocusNode,
                      action: TextInputAction.done,
                      hint: "Bachelor",
                      type: TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      label: "Highest Education",
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your height';
                        }
                        return null;
                      },
                    ),
                    RaisedButton(
                      onPressed: () async {
                        DIOResponseBody response = await API()
                            .createExtenderProfile(data.getAllDetails());
                        if (response.success) {
                          print(response.data);
                          Navigator.popUntil(
                              context, ModalRoute.withName('/home'));
                        }
                      },
                      child: Text('Save'),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
