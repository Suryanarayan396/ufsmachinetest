import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ufsmachinetest/controller/bottom_sheet_controller.dart';
import 'package:ufsmachinetest/controller/home_screen_controller.dart';
import 'package:ufsmachinetest/view/productscreen/productscreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<HomeScreenController>().fetchallproducts();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop for you"),
      ),
      body: Consumer<HomeScreenController>(
        builder: (context, homeprov, child) {
          if (homeprov.products.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final product = homeprov.products[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Productscreen(
                            id: homeprov.products[index].id!,
                          ),
                        ));
                  },
                  child: Card(
                    color: Colors.amber.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        NetworkImage(product.image.toString())),
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(20)),
                            height: 100,
                            width: 100,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                overflow: TextOverflow.clip,
                                product.title.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "\$${product.price.toString()}",
                                style: TextStyle(fontSize: 18),
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {}, child: Text("Delete"))
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 20,
              );
            },
            itemCount: homeprov.products.length,
          );
        },
      ),
      floatingActionButton: Consumer<BottomSheetController>(
        builder: (context, bottomprov, child) {
          return FloatingActionButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add",
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Product",
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            backgroundColor: Colors.black,
            onPressed: () {
              context.read<BottomSheetController>();
              bottomprov.producttitlecontroller.clear();
              bottomprov.descriptioncontroller.clear();
              bottomprov.pricecontroller.clear();
              bottomprov.categorycontroller.clear();

              _custombottomsheet(context, bottomprov);
            },
          );
        },
      ),
    );
  }

  Future<dynamic> _custombottomsheet(
      BuildContext context, BottomSheetController bottomprov) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Text(" Add New Product"),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: bottomprov.producttitlecontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Product name"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: bottomprov.descriptioncontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Product Description"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: bottomprov.pricecontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Product price"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: bottomprov.categorycontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Product category"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(onPressed: () {}, child: Text("add"))
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
