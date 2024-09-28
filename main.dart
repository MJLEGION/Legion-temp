import 'package:flutter/material.dart';

void main() {
  runApp(TempConverterApp());
}

class TempConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TempConverterHomePage(),
    );
  }
}

class TempConverterHomePage extends StatefulWidget {
  @override
  _TempConverterHomePageState createState() => _TempConverterHomePageState();
}

class _TempConverterHomePageState extends State<TempConverterHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _conversionType = 'FtoC';
  String _result = '';
  List<String> _history = [];

  void _convert() {
    double input = double.tryParse(_controller.text) ?? 0;
    double output;

    if (_conversionType == 'FtoC') {
      output = (input - 32) * 5 / 9;
      _history.add('F to C: ${input.toStringAsFixed(1)} => ${output.toStringAsFixed(2)}');
    } else {
      output = (input * 9 / 5) + 32;
      _history.add('C to F: ${input.toStringAsFixed(1)} => ${output.toStringAsFixed(2)}');
    }

    setState(() {
      _result = output.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Legion-TempConverter'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter temperature',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.thermostat),
                suffixIcon: Text(
                  _conversionType == 'FtoC' ? '°F' : '°C',
                  style: TextStyle(fontSize: 18),
              ))  , 
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Select conversion type',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'FtoC',
                  groupValue: _conversionType,
                  fillColor: WidgetStateProperty.all<Color>(Colors.red),
                  onChanged: (value) {
                    setState(() {
                      _conversionType = value!;
                    });
                  },
                ),
                Text('Fahrenheit to Celsius'),
                Radio<String>(
                  value: 'CtoF',
                  groupValue: _conversionType,
                  fillColor: WidgetStateProperty.all<Color>(Colors.red),
                  onChanged: (value) {
                    setState(() {
                      _conversionType = value!;
                    });
                  },
                ),
                Text('Celsius to Fahrenheit'),
              ],
            ),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1149638855.
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, 
                backgroundColor: Colors.black,
            )
            ),
            Text(
              'Converted Temperature: $_result',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Conversion History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
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
    );
  }
}
