// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

// @immutable
// sealed class ProductState {}

// final class ProductInitial extends ProductState {}

// class LoadingState extends ProductState {}

// class SuccessState extends ProductState {
//   List<Products> products;
//   SuccessState({
//     required this.products,
//   });
// }

// class errorState extends ProductState {}
enum ProductStatus { loading, success, error }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<Products> products;
  final bool hasReachedMax;
  final String errorMessage;
  const ProductState(
      {this.status = ProductStatus.loading,
      this.hasReachedMax = false,
      this.products = const [],
      this.errorMessage = ''});
  ProductState copyWith({
    ProductStatus? status,
    List<Products>? products,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return ProductState(
        status: status ?? this.status,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        products: products ?? this.products,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [status, products, hasReachedMax, errorMessage];
}
