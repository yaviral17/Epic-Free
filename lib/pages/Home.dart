import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UpcommingCard> upcommingFreeGames = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: UpcommingCard(),
                );
              },
              itemCount: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class UpcommingCard extends StatelessWidget {
  const UpcommingCard({super.key});

  @override
  Widget build(BuildContext context) {
    var display = MediaQuery.of(context).size;
    return Container(
      height: 250,
      width: 200,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 194, 72, 63),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/1422000.jpg'),
                ),
                SizedBox(width: 12,),
                Text(
                  "Grant Theft Auto V",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
