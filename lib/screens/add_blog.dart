import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_api/screens/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddBlog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  File? _image;
  final picker = ImagePicker();

  Future choiceImage() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  Future uploadImage() async {
    final uri = Uri.parse("");
    var request = http.MultipartRequest('POST', uri);
  }

  // TextEditingController _imageController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  Future saveBlog() async {
    final response =
        await http.post(Uri.parse('http://localhost:8000/api/blog'), body: {
      // "image": _imageController.text,
      "image": http.MultipartRequest,
      "title": _titleController.text,
      "content": _contentController.text,
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data Blog'),
      ),
      body: Form(
        key: _formKey,
        child: Column(children: [
          IconButton(
              icon: Icon(Icons.camera),
              onPressed: () {
                choiceImage();
              }),
          Container(
            child: _image == null
                ? Text('No Image Selected')
                : Image.file(_image!),
          ),
          // TextFormField(
          //   controller: _imageController,
          //   decoration: InputDecoration(labelText: "Image"),
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return "Please enter blog Image";
          //     }
          //     return null;
          //   },
          // ),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: "Title"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter blog Title";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _contentController,
            decoration: InputDecoration(labelText: "Content"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter blog Content";
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  saveBlog().then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  });
                }
                uploadImage();
              },
              child: Text('Save'))
        ]),
      ),
    );
  }
}

void setState(Null Function() param0) {}
