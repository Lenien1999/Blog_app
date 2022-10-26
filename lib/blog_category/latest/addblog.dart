// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:blog_app/blog_category/Backend/latestbackend/blogcontroller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../auth/ui/contant/roundedbutton.dart';
import '../Backend/latestbackend/blogmodel.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  State<AddBlog> createState() => _AddBlogState();
}

final heading = TextEditingController();
final content = TextEditingController();
final title=TextEditingController();

DateTime _selectedDate = DateTime.now();
String _selectedfeature = "none";
List<String> repeatlist = ["Latest", "Popular", "News"];
   File? imageFile;
 
 BlogController blogController=BlogController();
  

class _AddBlogState extends State<AddBlog> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Blog "),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 240, 183, 183),
      
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(children: [
            Myinputfield(
                widget: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 32,
                    elevation: 4,
                    onChanged: (String? newvalue) {
                      setState(() {
                        _selectedfeature = newvalue!;
                      });
                    },
                    underline: Container(height: 0),
                    items: repeatlist
                        .map<DropdownMenuItem<String>>(
                            (String e) => DropdownMenuItem(
                                value: e,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(e),
                                )))
                        .toList()),
                title: "Features",
                hint: "$_selectedfeature   "),
           
           
            Myinputfield(
                controller: title, title: "Title", hint: "Enter the title"),
            Myinputfield(
                controller: heading,
                title: "Headline",
                hint: "Enter the Headline"),
            Myinputfield(
              content:true,
                controller: content,
                title: "Content",
                hint: "Enter the Content"),
                SizedBox(height:70),
                 Container(
            child: imageFile == null
                ? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                          onPressed: () {
                      _getFromGallery();
                    },
                    child: Text("PICK FROM GALLERY"),
                  ),
           ] )): Image.file(
             imageFile!,
             fit: BoxFit.cover,
           ),
                 ),
            Myinputfield(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                    onPressed: () {
                      _getdatefromuser();
                    },
                    icon: const Icon(Icons.calendar_today_outlined))),
          ]),
        ),
       Padding(
         padding: const EdgeInsets.all(28.0),
         child: RoundedButton(text: "Submit", press: (){
          final latest=BlogModel(
            
            content: content.text,
            title:title.text,
            image: imageFile.toString(),
            date: DateFormat.yMd().format(_selectedDate) ,
            feature:_selectedfeature,
            headline: heading.text,

            
          );
          blogController.insertBlog(latest,context);
         }),
       )
      ]),
    );
  }
  _getFromGallery() async {
    // ignore: deprecated_member_use
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 200,
        maxHeight: 150,
    );
    if (pickedFile != null) {
        setState(() {
           imageFile = File(pickedFile.path);
        });
    }
}

  // ignore: non_constant_identifier_names
  Myinputfield(
      {required String title,
      required String hint,
      bool? content,
      TextEditingController? controller,
      Widget? widget}) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: Colors.black, fontSize: 18)),
        Container(
          margin: const EdgeInsets.only(top: 10),
          height: content==true? 100:52,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Color.fromARGB(255, 54, 51, 51),
                width: 0.6,
              )),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                  readOnly: widget == null ? false : true,
                  autofocus: false,
                  controller: controller,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                    color: Color.fromARGB(255, 54, 51, 51),
                  )),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    fillColor: Color.fromARGB(255, 54, 51, 51),
                    hintText: hint,
                    border:InputBorder.none,
                     hintStyle: GoogleFonts.lato(
                        textStyle: const TextStyle(
                      color: Color.fromARGB(255, 54, 51, 51),
                    )),
                  ),
                ),
              ),
              widget == null
                  ? Container()
                  : Container(
                      child: widget,
                    )
            ],
          ),
        )
      ]),
    );
  
  
  }

  _getdatefromuser() async {
     
    DateTime? pickedate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));
        
    if (pickedate != null) {
      
      setState(() {
        _selectedDate = pickedate;
      });
    } else {
      null;
    }
  }
}
