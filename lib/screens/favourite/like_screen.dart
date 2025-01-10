import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controller/data_provider.dart';
import '../../controller/homeProvider.dart';
import '../../model/data_model.dart';
import '../detail/detail_screen.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  @override
  Widget build(BuildContext context) {
    List<Planets> allPlanets = Provider.of<PlanetProvider>(context).jsonData;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Favourite',
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, likeProvider, child) {
          List<Planets> likedPlanets = allPlanets
              .where(
                  (planet) => likeProvider.likedPlanets.contains(planet.name))
              .toList();

          return Stack(
            children: [
              Opacity(
                opacity: 0.4,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/img/bg.jpg'),
                    ),
                  ),
                ),
              ),
              likedPlanets.isEmpty
                  ? const Center(
                      child: Text('No Favourites...',
                          style: TextStyle(color: Colors.white)),
                    )
                  : ListView.builder(
                      itemCount: likedPlanets.length,
                      itemBuilder: (context, index) {
                        Planets planet = likedPlanets[index];
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(planet: planet)),
                            );
                          },
                          leading: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset(planet.image),
                          ),
                          title: Text(
                            planet.name,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                          subtitle: Text(planet.planetType,
                              style: GoogleFonts.poppins(color: Colors.grey)),
                          trailing: IconButton(
                            onPressed: () {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .removeLikedPlanet(planet.name);
                            },
                            icon: const Icon(CupertinoIcons.delete_solid,
                                color: Colors.white),
                          ),
                        );
                      },
                    )
            ],
          );
        },
      ),
    );
  }
}
