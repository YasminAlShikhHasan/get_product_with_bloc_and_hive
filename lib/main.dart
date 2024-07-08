// import 'dart:html';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_with_bloc/bloc/product_bloc.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyProducts(),
    );
  }
}

// class ProductPage extends StatelessWidget {
//   ProductPage({super.key});
//   final _mybox = Hive.box('mybox');
//   TextEditingController product = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProductBloc()..add(GetProducts()),
//       child: Builder(builder: (context) {
//         return Scaffold(
//           appBar: AppBar(
//             title: TextField(
//               controller: product,
//             ),
//           ),
//           body: BlocBuilder<ProductBloc, ProductState>(
//             builder: (context, state) {
//               if (state is SuccessState) {
//                 _mybox.put('product', state.products);
//                 return ListView.builder(
//                     itemCount: state.products.length,

//                     itemBuilder: (context, index) => ListTile(
//                           title: Text(state.products[index].name),
//                           leading: Image.network(state.products[index].image),
//                         ));
//               } else if (state is errorState) {
//                 return ListView.builder(
//                   itemCount: _mybox.get('product').length,
//                   itemBuilder: (context, index) => ListTile(
//                     title: Text(_mybox.get('product')),
//                     // leading: Image.network(_mybox.get('product')),
//                   ),
//                 );
//                 // const Center(child: Text("no interenet"));
//               } else {
//                 return const Center(child: CircularProgressIndicator());
//               }
//             },
//           ),
//         );
//       }),
//     );
//   }
// }
class MyProducts extends StatefulWidget {
  MyProducts({super.key});

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final _currentScroll = _scrollController.offset;
    if (_currentScroll >= (maxScroll * 0.9)) {
      context.read<ProductBloc>().add(GetProducts());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => ProductBloc()..add(GetProducts()),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          switch (state.status) {
            case ProductStatus.loading:
              return const CircularProgressIndicator();
            case ProductStatus.success:
              return ListView.builder(
                  controller: _scrollController,
                  itemCount: state.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.products[index].name.length
                        ? const Center(child: CircularProgressIndicator())
                        : ListTile(
                            title: Text(state.products[index].name),
                          );
                  });
            case ProductStatus.error:
              return Center(
                child: Text(state.errorMessage),
              );
          }
        },
      ),
    ));
  }
}
