import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _data = [];
  String _search = '';
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    try {
      final response = await http.get(
          Uri.parse('https://stranger-things-api.fly.dev/api/v1/characters'));
      if (response.statusCode == 200) {
        setState(() {
          _data = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load data';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List filteredData = _data
        .where((item) => (item['portrayedBy']?.toLowerCase() ?? '')
            .contains(_search.toLowerCase()))
        .toList();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Center(
            child: Image.asset(
              'assets/image/images.png',
              width: 200,
              height: 150,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Search by name', border: OutlineInputBorder()),
              onChanged: (value) => setState(() => _search = value),
            ),
          ),
          if (_isLoading)
            Expanded(child: Center(child: CircularProgressIndicator()))
          else if (_error.isNotEmpty)
            Expanded(
                child: Center(
                    child: Text(_error, style: TextStyle(color: Colors.red))))
          else
            Expanded(
              child: ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        filteredData[index]['photo'] ??
                            'https://via.placeholder.com/150',
                      ),
                    ),
                    title: Text(
                        filteredData[index]['portrayedBy'] ?? 'Unknown Actor'),
                    subtitle:
                        Text(filteredData[index]['name'] ?? 'Unknown Name'),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(user: filteredData[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
