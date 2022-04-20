import 'package:flutter/material.dart';
import 'package:flutter_api/screens/add_blog.dart';
import 'package:flutter_api/screens/homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'dart:html';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  final String url = 'http://localhost:8000/api/blog';
  // gunakan http://localhost:8000 atau http://127.0.0.1:8000

  Future getBlog() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddBlog()));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Aryand CRUD'),
        ),
        body: FutureBuilder(
          future: getBlog(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: (snapshot.data as dynamic)['data'].length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      height: 180,
                      child: Card(
                        elevation: 5,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0)),
                              padding: EdgeInsets.all(15.0),
                              height: 150,
                              width: 200,
                              child:
                                  // Image.network('assets/images/instagram.png'),
                                  Image.network(
                                      'http://localhost:8000/storage/blogs/' +
                                          (snapshot.data as dynamic)['data']
                                              [index]['image']),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      (snapshot.data as dynamic)['data'][index]
                                          ['title'],
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text((snapshot.data
                                        as dynamic)['data'][index]['content']!),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Text('data error');
            }
          },
        ));
  }
}


//             [index]['image']))
                              // Image(
                              // image: NetworkImage(
                              //     'http://localhost:8000/storage/blogs/' +
                              //         (snapshot.data as dynamic)['data']
                              //             [index]['image'])),