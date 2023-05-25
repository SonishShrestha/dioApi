import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dio_project/model/products.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Products> products = [];
  Future<dynamic> getRequest(
      String url, Map<String, dynamic>? queryparameter) async {
    Dio dio = Dio();
    final response = await dio.get(url, queryParameters: queryparameter);
    return response;
  }

  Future<dynamic> postReq(String url, Map<String, dynamic> data) async {
    Dio dio = Dio();
    final datas = await dio.post(url, data: data);
    return datas;
  }

  Future getApi() async {
    final apiData = await getRequest("https://dummyjson.com/products", null);
    final datas = ListProducts.getData(apiData.data);
    products = datas.products;
  }

  @override
  void initState() {
    super.initState();
    getApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dio'),
        ),
        body: Container(
          height: 300,
          child: Card(
            elevation: 10,
            shadowColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.all(20),
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    products[1].images[2],
                    width: 150,
                    height: 150,
                  ),
                  Text(
                    products[0].brand,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    products[0].title,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    products[0].category,
                    style: TextStyle(fontSize: 15),
                  ),
                  Text('${products[0].price}')
                ],
              ),
            ),
          ),
        ));
  }
}
