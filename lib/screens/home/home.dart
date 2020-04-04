import 'package:flutter/material.dart';
import 'package:note_app/services/auth.dart';

final List<Map<String, String>> entries = <Map<String, String>>[
  {
    'title': 'Lorem ipsum',
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
  },
  {
    'title': 'Lorem ipsum',
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
  },
  {
    'title': 'Lorem ipsum',
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
  },
  {
    'title': 'Lorem ipsum',
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
  }
];
final List<String> colorCodes = <String>[
  '#EFEA5A',
  '#6DC1A2',
  '#BFC0C0',
  '#F0B67F',
  '#D6CFCB',
  '#C7EFCF'
];

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

class Home extends StatelessWidget {
  final AuthenticationService _auth = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100), // here the desired height
          child: AppBar(
            backgroundColor: Theme.of(context).accentColor,
            title: Text(
              "Notes",
              style: TextStyle(color: "#16DB93".toColor(), fontSize: 24),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                onPressed: () async {
                  await _auth.logout();
                },
              )
            ],
          ),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(50),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: const EdgeInsets.fromLTRB(30, 30, 20, 10),
                height: 150,
                color: colorCodes[index].toString().toColor(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${entries[index]["title"]}',
                        style:
                            TextStyle(color: "#172A3A".toColor(), fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 10,),
                      Text(
                        '${entries[index]["description"]}',
                        style:
                            TextStyle(
                              color: "#172A3A".toColor(), 
                              fontSize: 17,
                            ),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      )
                    ]));
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          child: Icon(Icons.add),
          backgroundColor: "#A4036F".toColor(),
        ),
        );
  }
}
