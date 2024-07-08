import 'package:api_with_bloc/model/prodect_model.dart';
import 'package:api_with_bloc/services/Product_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductState()) {
    on<ProductEvent>((event, emit) async {
      if (event is GetProducts) {
        if (state.hasReachedMax) return;
        try {
          if (state.status == ProductStatus.loading) {
            final products = await productServiceImp().getData(0, 5);
            return products.isEmpty
                ? emit(state.copyWith(hasReachedMax: true))
                : emit(state.copyWith(
                    status: ProductStatus.success,
                    products: products,
                    hasReachedMax: false));
          } else {
            final products =
                await productServiceImp().getData(state.products.length, 5);
            products.isEmpty
                ? emit(state.copyWith(hasReachedMax: true))
                : emit(state.copyWith(
                    status: ProductStatus.success,
                    products: List.of(state.products)..addAll(products),
                    hasReachedMax: false));
          }
        } catch (e) {
          emit(state.copyWith(
              status: ProductStatus.error,
              errorMessage: 'failed to fetch products'));
        }
      }
    }, transformer: droppable());
  }
}
