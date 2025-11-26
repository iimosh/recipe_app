import 'package:flutter/material.dart';
import 'package:recipe_app/models/food.dart';
import 'package:recipe_app/models/receipt.dart';
import 'package:recipe_app/widgets/detail_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/api_service.dart';

class MealDetail extends StatefulWidget {
  const MealDetail({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MealDetailState();
  }
}

class _MealDetailState extends State<MealDetail> {
  final ApiService _apiService = ApiService();
  late final Food food;
  late Receipt receipt;
  bool _isLoaded = false;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isLoaded) {
      food = ModalRoute.of(context)!.settings.arguments as Food;
      _loadMeal(food.id);
      _isLoaded = true;
    }
  }

  Future<void> _loadMeal(String id) async {
    final rec = await _apiService.loadReceipt(id);

    setState(() {
      receipt = rec;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, left: 16.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DetailImage(image: receipt.img),
                  const SizedBox(height: 20),
                  Text(receipt.name,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),),
                  const SizedBox(height: 15),


                  if (receipt.youtube.isNotEmpty)
                    ElevatedButton.icon(
                      onPressed: () async {
                        final url = Uri.parse(receipt.youtube);

                         try {await launchUrl(url, mode: LaunchMode.externalApplication);
                        } catch (e){
                           if(mounted){
                             ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content: Text('Cannot open the link.'))
                             );
                           }
                         }
                      },
                      icon: const Icon(Icons.play_circle_fill),
                      label: const Text("Watch on YouTube"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                    ),

                  Text("Ingredients:",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300,),),
                  Padding(padding: const EdgeInsets.all(15),
                    child: Text(receipt.ingredients.join(','), textAlign: TextAlign.center,),),
                  Text("Instructions:",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300,),),
                  Padding(padding: const EdgeInsets.all(15),
                      child: Text(receipt.instructions),),
                ],
              ),
            ),
    );
  }
}
