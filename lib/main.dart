import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app1/pages/homePage.dart';

void main(){
  //En üstte siyah çizginin kaybolması için aşağıdaki kod bloğunu kullanıldı.
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Yapılacaklar",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
