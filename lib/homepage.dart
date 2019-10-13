import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'userDetails.dart';
import 'productdetail.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserDetails> _searchResult = [];
  List<UserDetails> _userDetails = [];
  TextEditingController controller = new TextEditingController();

  // Get json result and convert it to model. Then add
  Future<Null> getUserDetails() async {
    final response = await http.get(url);
    final responseJson = json.decode(response.body);
//    data = responseJson['data'];
    print(responseJson['data']);
    setState(() {
      for (Map user in responseJson['data']) {
        _userDetails.add(UserDetails.fromJson(user));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getUserDetails();
  }

  Widget _buildUsersList() {
    return new ListView.builder(
      itemCount: _userDetails.length,
      itemBuilder: (context, index) {
        return new Card(
          child: new ListTile(
            leading: new CircleAvatar(
              backgroundImage: new NetworkImage(
                _userDetails[index].profileUrl,
              ),
            ),
            title: new Text(_userDetails[index].name),
            onTap: () {
              print('Card tapped ' + _userDetails[index].name);

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: _userDetails[index])),
              );
            },
          ),
          margin: const EdgeInsets.all(0.0),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return new ListView.builder(
      itemCount: _searchResult.length,
      itemBuilder: (context, i) {
        return new Card(
          child: new ListTile(
            leading: new CircleAvatar(
              backgroundImage: new NetworkImage(
                _searchResult[i].profileUrl,
              ),
            ),
            title: new Text(
                _searchResult[i].name),
            onTap: () {
              print('Card tapped ' + _userDetails[i].name);

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: _userDetails[i])),
              );
            },
          ),
          margin: const EdgeInsets.all(0.0),
        );
      },
    );
  }

  Widget _buildSearchBox() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        child: new ListTile(
          leading: new Icon(Icons.search),
          title: new TextField(
            controller: controller,
            decoration: new InputDecoration(
                hintText: 'Search', border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
            onPressed: () {
              controller.clear();
              onSearchTextChanged('');
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return new Column(
      children: <Widget>[
        new Container(
            color: Theme.of(context).primaryColor, child: _buildSearchBox()),
        new Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? _buildSearchResults()
                : _buildUsersList()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Home'),
        elevation: 0.0,
      ),
      body: _buildBody(),
      resizeToAvoidBottomPadding: true,
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

//    _userDetails.forEach((userDetail) {
//      if (userDetail.firstName.contains(text) ||
//          userDetail.lastName.contains(text)) _searchResult.add(userDetail);
//    });

    _userDetails.forEach((userDetail) { if (userDetail.name.toUpperCase().contains(text.toUpperCase()) || userDetail.price.toUpperCase().contains(text.toUpperCase())) _searchResult.add(userDetail); });

    setState(() {});
  }
}
