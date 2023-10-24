import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TablePage extends StatefulWidget {
  final String token;
  final String userName;

  TablePage({Key? key, required this.token, required this.userName}) : super(key: key);

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  List<dynamic> openTrades = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse('https://peanut.ifxdb.com/api/ClientCabinetBasic/GetOpenTrades');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer 2b7cbd694a834d3a54732206925530cc05d98d8e8b9658f8605bc32682e6c4d9',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({'login': 2088888, 'token': '38d00e5afc7fefe652571268d17ad57e59350805cc3d732fb0cf773122ce0338'});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        openTrades = data;
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test App', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffcbc1c1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Symbol')),
            DataColumn(label: Text('Profit')),
          ],
          rows: openTrades.map((trade) {
            return DataRow(
              cells: [
                DataCell(
                  Container(
                    child: Text(trade['symbol'] ?? ''),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black), // Add a black border
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    child: Text(trade['profit'].toString() ?? ''),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black), // Add a black border
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),

      ),
    );
  }
}
