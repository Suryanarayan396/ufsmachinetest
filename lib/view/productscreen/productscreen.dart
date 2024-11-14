import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ufsmachinetest/controller/productscreen_controller.dart';

class Productscreen extends StatefulWidget {
  final int id;
  const Productscreen({super.key, required this.id});

  @override
  State<Productscreen> createState() => _ProductscreenState();
}

class _ProductscreenState extends State<Productscreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context
            .read<ProductscreenController>()
            .fetchproduct(id: widget.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("See Your Product"),),
      body: Consumer<ProductscreenController>(
        builder: (context, prodprov, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: prodprov.productobj!.image.toString(),
                  height: 500,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(prodprov.productobj!.title.toString()),
                SizedBox(
                  height: 20,
                ),
                Text(prodprov.productobj!.description.toString()),
                SizedBox(
                  height: 20,
                ),
                Text("${prodprov.productobj!.price.toString()}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
