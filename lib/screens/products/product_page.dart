import 'package:flutter/material.dart';
import 'package:statefull_widget/base_url.dart';
import 'package:statefull_widget/models/products_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductsModel> productList = [];
  String url = "${BaseUrl.BASE_URL}/models/products/products_list.php";

  Future<List<ProductsModel>> getProductsList() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print(response.body);
        List<ProductsModel> products = parseJSON(response.body);
        return products;
      } else {
        throw Exception("Error while getting products list: " + response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<ProductsModel> parseJSON(String body) {
    final parsedJson = convert.json.decode(body).cast<Map<String, dynamic>>();
    return parsedJson
        .map<ProductsModel>((json) => ProductsModel.fromJSON(json))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    getProductsList().then((objectProducts) {
      setState(() {
        // productList diisi
        productList = objectProducts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(4),
                itemCount: productList.length,
                itemBuilder: (BuildContext context, int position) {
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(productList[position].product_name.toString()),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
