import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var jsonList;
  @override
  void initState() {
    //TODO:implement initState
    super.initState();
    getData();
  }

  void getData() async {
    try {
      var response = await Dio()
          .get('https://protocoderspoint.com/jsondata/superheros.json');
      if (response.statusCode == 200) {
        setState(() {
          jsonList = response.data["superheros"] as List;
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dio tutorial'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 4.0,
                    ),
                  ),
                  child: Image.network(
                    jsonList[index]['url'],
                    fit: BoxFit.fill,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  jsonList[index]['name'],
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  jsonList[index]['power'],
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),
            ),
          );
        },
        itemCount: jsonList == null ? 0 : jsonList.length,
      ),
    );
  }
}
