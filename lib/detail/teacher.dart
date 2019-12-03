
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(this.userId, this.id, this.title, this.body);

  factory Post.fromMap(Map<String, dynamic> json) {
    return Post(
      json['userId'],
      json['id'],
      json['title'],
      json['body'],
    );
  }
}
class Teacher extends StatefulWidget {

  @override
  TeacherState createState() => TeacherState();

}

class TeacherState extends State<Teacher> {

  @override
  void initState() {
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('선생님'),
      ),
      body: Center(
        child: _ApiGet(posts:fetchPosts()),
      ),
    );
  }

}

List<Post> parsePosts(String responseBody) { 
   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
   return parsed.map<Post>((json) => Post.fromMap(json)).toList(); 
}
Future<List<Post>> fetchPosts() async { 
   final http.Response response = await http.get( 
    Uri.encodeFull('http://jsonplaceholder.typicode.com/posts'), 
    headers: {"Accept": "application/json"}); 
   if (response.statusCode == 200) { 
      return parsePosts(response.body); 
   } else { 
      throw Exception('Unable to fetch products from the REST API');
   } 
}
class _ApiGet extends StatelessWidget {
   const _ApiGet({
    @required this.posts,
    Key key,
  })  : assert(posts != null),
        super(key: key);

  final Future<List<Post>> posts;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Post>>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Post item = snapshot.data[index]; 
                return ListTile(
                  title: Text(item.id.toString()),
                  subtitle: Text(item.body)
                );
              },
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return CircularProgressIndicator();
        },
        future: posts,
      ),
    );
  }
}


