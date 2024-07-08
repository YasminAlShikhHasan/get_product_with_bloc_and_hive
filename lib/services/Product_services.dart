import 'package:api_with_bloc/model/prodect_model.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';

abstract class Services {
  Dio dio = Dio();
  late Response response;
}

abstract class productService extends Services {
  Future<List<Products>> getData(int start, int limit);
}

class productServiceImp extends productService {
  // final _mybox = Hive.box('mybox');

  @override
  Future<List<Products>> getData(int start, int limit) async {
    String url =
        'https://freetestapi.com/api/v1/products?_start:$start,_limit:$limit';
    try {
      response = await dio.get('https://freetestapi.com/api/v1/products');
      List<Products> product = List.generate(response.data.length,
          (index) => Products.fromMap(response.data[index]));
      // _mybox.put('products', product);

      return product;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
