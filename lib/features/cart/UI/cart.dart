import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc.dart';
import 'cart_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Items'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade400,
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: ((context, state) {}),
        listenWhen: ((previous, current) => current is CartActionState),
        buildWhen: ((previous, current) => current is! CartActionState),
        builder: ((context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;

              return ListView.builder(
                itemCount: successState.cartitems.length,
                itemBuilder: (context, index) {
                  return CartTileWidget(
                    productDataModel: successState.cartitems[index],
                    cartBloc: cartBloc,
                  );
                },
              );

            default:
          }

          return Container();
        }),
      ),
    );
  }
}
