import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map user;

  DetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          user['portrayedBy'] ?? 'Unknown Name',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  user['photo'] ?? 'https://via.placeholder.com/150',
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 40),
            Text('Name : ${user['portrayedBy'] ?? 'Unknown Name'}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            Text(
                'Nickname in Stranger Things: ${user['name'] ?? 'Unknown Nickname'}'),
            SizedBox(height: 5),
            Text('Aliases: ${user['aliases'] ?? 'Unknown Alias'}'),
            SizedBox(height: 5),
            Text('Status: ${user['status'] ?? 'Unknown Status'}'),
            SizedBox(height: 5),
            Text('Born: ${user['born'] ?? 'Unknown '}'),
            SizedBox(height: 5),
            Text('Gender: ${user['gender'] ?? 'Unknown '}'),
            SizedBox(height: 5),
            Text(
                'Appears In Episodes: ${user['appearsInEpisodes'] ?? 'Unknown '}'),
          ],
        ),
      ),
    );
  }
}
