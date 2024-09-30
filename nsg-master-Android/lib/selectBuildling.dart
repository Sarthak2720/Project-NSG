import 'package:flutter/material.dart';
import 'package:nsg/location.dart';
import 'buildingmodel.dart';

class SelectBuilding extends StatelessWidget {
  final List<Building> buildings = [
    Building('Taj Hotel', 'assets/images/tajHotel.jpg'),
    Building('CSMT', 'assets/images/cSMT.jpg'),
    Building('Symbiosis University', 'assets/images/Symbiosis_university.jpg'),
    Building('Leopold Cafe', 'assets/images/LeopoldCafe_gobeirne.jpg'),
    Building('Cama Hospital', 'assets/images/Cama_Hospital.jpg'),
    Building('Nariman House', 'assets/images/Nariman_house.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/nsglogo.png',
                height: 100,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'National Security Guard',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Ministry of Home Affairs,',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Govt of India',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Sarvatra Sarvottam Suraksha',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Container(
            color: Colors.red,
            padding: EdgeInsets.all(12),
            child: Center(
              child: Text(
                'Select Building',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: buildings.length,
              itemBuilder: (context, index) {
                final building = buildings[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BroadcastLocationPage(),),);
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            building.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            building.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
