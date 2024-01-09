import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/wishlist_bloc.dart';
import 'wishlist_tile_widget.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist Items'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade400,
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listener: ((context, state) {}),
        listenWhen: ((previous, current) => current is WishlistActionState),
        buildWhen: ((previous, current) => current is! WishlistActionState),
        builder: ((context, state) {
          switch (state.runtimeType) {
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;

              return ListView.builder(
                itemCount: successState.wishlistitems.length,
                itemBuilder: (context, index) {
                  return WishlistTileWidget(
                    productDataModel: successState.wishlistitems[index],
                    wishlistBloc: wishlistBloc,
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
