import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kauto/core/theme/apptheme.dart';
import 'package:kauto/presentation/products/providers/add_provider.dart';
import 'package:kauto/presentation/products/providers/cart_provider.dart';

class ShippingAdd extends ConsumerStatefulWidget {
  const ShippingAdd({super.key});
  @override
  ConsumerState<ShippingAdd> createState() => _ShippingAddState();
}

class _ShippingAddState extends ConsumerState<ShippingAdd> {
  int selectedIndex = 0;
  TextEditingController name = TextEditingController();
  TextEditingController no = TextEditingController();
  TextEditingController add1 = TextEditingController();
  TextEditingController add2 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController pincode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final address = ref.watch(addProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shipping Address',
          style: TextStyle(
            color: AppTheme.outlinedText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Saved Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(height: 20),
              address.when(
                data: (address) {
                  if (address.isEmpty) return SizedBox.shrink();
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: address.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow:
                                Theme.of(context).brightness == Brightness.dark
                                ? [] // 👈 no shadow in dark mode
                                : [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      index == selectedIndex
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_unchecked,
                                      color: index == selectedIndex
                                          ? AppTheme.primary
                                          : Colors.grey,
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          address[index].name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          ('${address[index].add1},'),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                        Text(
                                          ('${address[index].add2},'),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                        Text(
                                          '+91 ${address[index].phone}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
                error: (e, st) => Text('Erorr $e'),
                loading: () => Center(child: CircularProgressIndicator()),
              ),
              SizedBox(height: 20),
              Text(
                'Add New Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(height: 20),
              TextField(
                controller: name,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Colors.grey),
                  hintText: 'Full Name',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                  fillColor: Theme.of(context).cardColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: no,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone, color: Colors.grey),
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                  fillColor: Theme.of(context).cardColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: add1,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                  ),
                  hintText: 'Address Line 1',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                  fillColor: Theme.of(context).cardColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: add2,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.add_location_alt_outlined,
                    color: Colors.grey,
                  ),
                  hintText: 'Address Line 2 (Optional)',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                  fillColor: Theme.of(context).cardColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: city,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Colors.grey,
                        ),
                        hintText: 'city',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: state,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.map_outlined,
                          color: Colors.grey,
                        ),
                        hintText: 'State',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: pincode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.pin_outlined, color: Colors.grey),
                  hintText: 'Pincode / Zip Code',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                  fillColor: Theme.of(context).cardColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(15),
            backgroundColor: AppTheme.primary,
            fixedSize: Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
          onPressed: () {
            ref
                .read(addRepositoryProvider)
                .saveAdd(
                  userId: ref.read(userProvider),
                  name: name.text.trim(),
                  phone: no.text.trim(),
                  address1: add1.text.trim(),
                  address2: add2.text.trim(),
                  city: city.text.trim(),
                  pincode: pincode.text.trim(),
                  state: state.text.trim(),
                );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.save, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Save Address',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
