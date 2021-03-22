import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

var title = 'Welcome to Razorpay Best Flutter';
bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return ((double.parse(s, (e) => null) != null) &&
      (double.parse(s, (e) => null) > 0));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: MyCustomForm()

          // Center(
          //   child: Text('Hello World'),
          // ),
          ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                debugPrint('entered_id: $value');
                return 'Please enter valid amount';
              // } else if (isNumeric(value) == false) {
              //   return 'Please enter valid amount';
              } else {
                var _razorpay = Razorpay();
                var options = {
                  'key': 'rzp_test_oJPbj9rC1rDGAQ',
                  'amount': value,
                  'name': 'Intelij Bussiness Services.',
                  //'order_id': value,
                  'description': 'Customised IDE ',
                  'prefill': {
                    'contact': '7387920849',
                    'email': 'ayush.vipul@razorpay.com'
                  }
                };

                _razorpay.open(options);
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
