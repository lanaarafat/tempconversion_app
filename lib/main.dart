import 'package:flutter/material.dart';

void main() {
  runApp(TempConversionApp());
}

class TempConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Conversion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TempConversionHomePage(),
      debugShowCheckedModeBanner: false,  // Remove the debug banner
    );
  }
}

class TempConversionHomePage extends StatefulWidget {
  @override
  _TempConversionHomePageState createState() => _TempConversionHomePageState();
}

class _TempConversionHomePageState extends State<TempConversionHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _conversionType = 'F to C';
  String _result = '';
  List<String> _history = [];

  void _convert() {
    double input = double.tryParse(_controller.text) ?? 0;
    double output;
    String conversion;

    if (_conversionType == 'F to C') {
      output = (input - 32) * 5 / 9;
      conversion = 'F to C: $input°F => ${output.toStringAsFixed(2)}°C';
    } else {
      output = input * 9 / 5 + 32;
      conversion = 'C to F: $input°C => ${output.toStringAsFixed(2)}°F';
    }

    setState(() {
      _result = output.toStringAsFixed(2);
      _history.insert(0, conversion);  // Insert the new conversion at the beginning of the list
      _controller.clear();  // Clear the text field after conversion
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Conversion'),
        backgroundColor: Colors.blueAccent,  // Set the background color of the AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: const Text('F to C'),
                      leading: Radio<String>(
                        value: 'F to C',
                        groupValue: _conversionType,
                        onChanged: (String? value) {
                          setState(() {
                            _conversionType = value!;
                          });
                        },
                        activeColor: Colors.blueAccent,  // Set the color of the radio button
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('C to F'),
                      leading: Radio<String>(
                        value: 'C to F',
                        groupValue: _conversionType,
                        onChanged: (String? value) {
                          setState(() {
                            _conversionType = value!;
                          });
                        },
                        activeColor: Colors.blueAccent,  // Set the color of the radio button
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Temperature',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.blueAccent),  // Set the color of the label text
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),  // Set the color of the focused border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),  // Set the color of the enabled border
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _convert,
                child: Text('Convert'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,  // Set the background color of the button
                  foregroundColor: Colors.white,  // Set the color of the button text
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Result: $_result',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Container(
                height: 200,  // Set a fixed height for the history container
                child: ListView.builder(
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_history[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
