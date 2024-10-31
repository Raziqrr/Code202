/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-31 14:27:04
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 21:04:54
/// @FilePath: lib/pages/emissions_tracker/emissions_tracker.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:flutter/material.dart';

class AddActivityPage extends StatefulWidget {
  final Function(String, String, double) onActivityAdded;

  const AddActivityPage({Key? key, required this.onActivityAdded})
      : super(key: key);

  @override
  _AddActivityPageState createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  String selectedActivity = 'Transport';
  String selectedFood = 'Nasi Lemak';
  String selectedStuff = 'Smartphone';
  final TextEditingController mileageController = TextEditingController();
  final TextEditingController foodQuantityController = TextEditingController();
  final TextEditingController stuffQuantityController = TextEditingController();

  final List<String> activityOptions = [
    'Transport',
    'Home',
    'Food',
    'Stuff', // New Stuff option
  ];

  final List<String> foodOptions = [
    'Nasi Lemak',
    'Roti Canai',
    'Satay',
    'Laksa',
    'Char Kway Teow',
    'Mee Goreng',
    'Rendang',
    'Hainanese Chicken Rice',
    'Ramen',
    'Nasi Kandar',
    'Teh Tarik',
    'Apam Balik',
    'Cendol',
    'Roti John',
    'Nasi Campur',
    'Samosa',
    'Kueh Lapis',
    'Kuih Kapit',
    'Ayam Penyet',
    'Prawn Mee',
    'Biryani',
    'Nasi Goreng',
    'Soto',
    'Curry Laksa',
    'Nasi Lemak Ayam',
    'Banana Leaf Rice',
    'Pineapple Fried Rice',
    'Chicken Satay with Peanut Sauce',
    'Gado-Gado',
    'Asam Pedas',
    'Char Siew Rice',
    'Popiah',
  ];

  final Map<String, double> foodCarbonFootprints = {
    'Nasi Lemak': 1.5,
    'Roti Canai': 0.7,
    'Satay': 1.3,
    'Laksa': 1.2,
    'Char Kway Teow': 1.4,
    'Mee Goreng': 1.0,
    'Rendang': 2.0,
    'Hainanese Chicken Rice': 1.6,
    'Ramen': 1.1,
    'Nasi Kandar': 1.8,
    'Teh Tarik': 0.4,
    'Apam Balik': 0.5,
    'Cendol': 0.6,
    'Roti John': 1.0,
    'Nasi Campur': 1.5,
    'Samosa': 0.9,
    'Kueh Lapis': 0.3,
    'Kuih Kapit': 0.4,
    'Ayam Penyet': 1.6,
    'Prawn Mee': 1.7,
    'Biryani': 2.2,
    'Nasi Goreng': 1.0,
    'Soto': 1.4,
    'Curry Laksa': 1.5,
    'Nasi Lemak Ayam': 1.8,
    'Banana Leaf Rice': 2.0,
    'Pineapple Fried Rice': 1.2,
    'Chicken Satay with Peanut Sauce': 1.4,
    'Gado-Gado': 1.0,
    'Asam Pedas': 1.9,
    'Char Siew Rice': 1.5,
    'Popiah': 0.5,
  };

  final List<String> stuffOptions = [
    'Smartphone',
    'Laptop',
    'Pair of Jeans',
    'T-Shirt',
    'Sneakers',
    'Bottle of Water',
    'Coffee Cup',
    'Grocery Bag',
    'Book',
    'Light Bulb',
    'Toothbrush',
    'Shampoo Bottle',
    'Deodorant Stick',
    'Cotton Tote Bag',
    'Battery Pack',
    'Toilet Paper Roll',
    'Plastic Bottle',
    'Glass Jar',
    'Metal Can',
    'Paper Notebook',
    'Pizza Box',
  ];

  final Map<String, double> stuffCarbonFootprints = {
    'Smartphone': 70.0,
    'Laptop': 300.0,
    'Pair of Jeans': 33.4,
    'T-Shirt': 6.75,
    'Sneakers': 14.0,
    'Bottle of Water': 0.5,
    'Coffee Cup': 0.25,
    'Grocery Bag': 0.2,
    'Book': 2.5,
    'Light Bulb': 0.2,
    'Toothbrush': 0.1,
    'Shampoo Bottle': 0.5,
    'Deodorant Stick': 0.2,
    'Cotton Tote Bag': 0.8,
    'Battery Pack': 1.2,
    'Toilet Paper Roll': 0.6,
    'Plastic Bottle': 0.3,
    'Glass Jar': 0.4,
    'Metal Can': 0.2,
    'Paper Notebook': 0.7,
    'Pizza Box': 0.1,
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> getInputFields() {
      switch (selectedActivity) {
        case 'Transport':
          return [
            TextField(
              controller: mileageController,
              decoration: InputDecoration(
                  labelText: 'Total Distance Traveled Today (in km)',
                  hintText: "e.g. 15.5"),
              keyboardType: TextInputType.number,
            ),
          ];
        case 'Home':
          return [
            TextField(
              controller: mileageController,
              decoration: InputDecoration(
                  labelText: 'Monthly Energy Consumption (in kWh)',
                  hintText: "e.g. 250"),
              keyboardType: TextInputType.number,
            ),
          ];
        case 'Food':
          return [
            DropdownButton<String>(
              value: selectedFood,
              items: foodOptions
                  .map((food) => DropdownMenuItem(
                        value: food,
                        child: Text(food),
                      ))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedFood = newValue!;
                });
              },
            ),
            TextField(
              controller: foodQuantityController,
              decoration: InputDecoration(
                  labelText: 'Quantity of food', hintText: "Quantity"),
              keyboardType: TextInputType.number,
            ),
          ];
        case 'Stuff':
          return [
            DropdownButton<String>(
              value: selectedStuff,
              items: stuffOptions
                  .map((stuff) => DropdownMenuItem(
                        value: stuff,
                        child: Text(stuff),
                      ))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedStuff = newValue!;
                });
              },
            ),
            TextField(
              controller: stuffQuantityController,
              decoration: InputDecoration(labelText: 'Quantity Bought'),
              keyboardType: TextInputType.number,
            ),
          ];
        default:
          return [];
      }
    }

    void submitActivity() {
      String details = '';
      double carbonProduced = 0;

      switch (selectedActivity) {
        case 'Transport':
          double distanceInKm = double.tryParse(mileageController.text) ?? 0.0;
          double carbonSavedForCar = distanceInKm * 0.021; // Example factor
          details =
              'Activity: $selectedActivity, Distance: ${mileageController.text} km, Carbon Saved: ${carbonSavedForCar.toStringAsFixed(2)} kg CO₂';
          carbonProduced = carbonSavedForCar;
          break;
        case 'Home':
          double energyConsumption =
              double.tryParse(mileageController.text) ?? 0.0;
          double carbonSavedForHouse =
              energyConsumption * 0.54; // CO₂ factor for Malaysia
          details =
              'Activity: $selectedActivity, Energy Consumption: ${energyConsumption} kWh, Carbon Saved: ${carbonSavedForHouse.toStringAsFixed(2)} kg CO₂';
          carbonProduced = carbonSavedForHouse;
          break;
        case 'Food':
          double foodQuantity = double.tryParse(foodQuantityController.text) ??
              0.0; // Quantity in grams
          double foodCarbonFootprintPer100g =
              foodCarbonFootprints[selectedFood] ?? 0.0;
          double totalFoodCarbon = (foodCarbonFootprintPer100g / 100) *
              foodQuantity; // Convert to per gram
          details =
              'Activity: $selectedActivity, Food: $selectedFood, Quantity: ${foodQuantity} g, Carbon Footprint: ${totalFoodCarbon.toStringAsFixed(2)} kg CO₂';
          carbonProduced = totalFoodCarbon;
          break;
        case 'Stuff':
          double stuffQuantity =
              double.tryParse(stuffQuantityController.text) ?? 0.0; // Quantity
          double stuffCarbonFootprintPerItem =
              stuffCarbonFootprints[selectedStuff] ?? 0.0;
          double totalStuffCarbon = stuffCarbonFootprintPerItem *
              stuffQuantity; // Multiply by quantity
          details =
              'Activity: $selectedActivity, Item: $selectedStuff, Quantity: ${stuffQuantity}, Carbon Footprint: ${totalStuffCarbon.toStringAsFixed(2)} kg CO₂';
          carbonProduced = stuffCarbonFootprintPerItem;
          break;
      }

      widget.onActivityAdded(details, selectedActivity, carbonProduced);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Activity added successfully!')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Activity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedActivity,
              items: activityOptions
                  .map((activity) => DropdownMenuItem(
                        value: activity,
                        child: Text(activity),
                      ))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedActivity = newValue!;
                  selectedFood = 'Nasi Lemak'; // Reset food selection
                  selectedStuff = 'Smartphone'; // Reset stuff selection
                  mileageController.clear(); // Clear mileage input
                  foodQuantityController.clear(); // Clear food quantity input
                  stuffQuantityController.clear(); // Clear stuff quantity input
                });
              },
            ),
            ...getInputFields(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitActivity,
              child: const Text('Add Activity'),
            ),
          ],
        ),
      ),
    );
  }
}
