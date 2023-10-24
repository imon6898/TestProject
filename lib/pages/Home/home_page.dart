import 'package:flutter/material.dart';
import 'package:voting/Api_Service.dart';
import 'package:voting/pages/Home/table_page.dart';
import '../../Custom_widget/custom_text_field.dart';

class HomePage extends StatefulWidget {
  final String token;
  final String userName;

  const HomePage({
    Key? key,
    required this.token,
    required this.userName,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();
  String name = '';
  String address = '';
  String country = '';
  String city = '';
  String zipCode = '';

  @override
  void initState() {
    super.initState();
    // Fetch user account information and update name and address when the page loads
    fetchAccountInformation();
  }

  Future<void> fetchAccountInformation() async {
    try {
      final data = await apiService.getAccountInformation(widget.userName, widget.token);
      if (
      data.name != null &&
          data.address != null &&
          data.city != null &&
          data.country != null &&
          data.zipCode != null
      ) {
        setState(() {
          name = data.name;
          address = data.address;
          city = data.city;
          country = data.country;
          zipCode = data.zipCode;
        });
      }
    } catch (error) {
      print('Failed to fetch account information: $error');
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
        color: Color(0xffcbc1c1),
        child: Column(
          children: [
            SizedBox(height: 20),
            CustomTextFields(
              labelText: name,
              hintText: name, // Display name as hintText
              disableOrEnable: false,
              borderColor: 0xFFBCC2C2,
              filled: true,
            ),
            CustomTextFields(
              labelText: address,
              hintText: address, // Display address as hintText
              disableOrEnable: false,
              borderColor: 0xFFBCC2C2,
              filled: true,
            ),
            CustomTextFields(
              labelText: city,
              hintText: city, // Display address as hintText
              disableOrEnable: false,
              borderColor: 0xFFBCC2C2,
              filled: true,
            ),
            CustomTextFields(
              labelText: country,
              hintText: country, // Display address as hintText
              disableOrEnable: false,
              borderColor: 0xFFBCC2C2,
              filled: true,
            ),
            CustomTextFields(
              labelText: zipCode,
              hintText: zipCode, // Display address as hintText
              disableOrEnable: false,
              borderColor: 0xFFBCC2C2,
              filled: true,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TablePage(
                      token: widget.token,
                      userName: widget.userName,
                    ),
                  ),
                );
              },
              child: Text('Data Table'),
            )
          ],
        ),
      ),
    );
  }
}
