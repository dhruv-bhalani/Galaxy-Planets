import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pr_6_space_app/controller/data_provider.dart';
import 'package:pr_6_space_app/controller/homeProvider.dart';
import 'package:pr_6_space_app/model/data_model.dart';
import 'package:pr_6_space_app/screens/detail/detail_screen.dart';
import 'package:pr_6_space_app/screens/favourite/like_screen.dart';
import 'package:pr_6_space_app/utils/global_var.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late HomeProvider homeProviderR;
  late HomeProvider homeProviderW;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    homeProviderW = context.watch<HomeProvider>();
    homeProviderR = context.read<HomeProvider>();
    PlanetProvider planetProviderT = Provider.of<PlanetProvider>(context);
    PlanetProvider planetProviderF =
        Provider.of<PlanetProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Solar System',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<String>(
        future: rootBundle.loadString('assets/json/json_data.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading data'),
            );
          } else if (snapshot.hasData) {
            List<dynamic> data = jsonDecode(snapshot.data ?? '');
            planetProviderF.setData(data);
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
                Swiper(
                  itemCount: planetProviderT.jsonData.length,
                  itemWidth: 450.0,
                  itemHeight: 750.0,
                  layout: SwiperLayout.TINDER,
                  pagination: const SwiperPagination(
                    margin: EdgeInsets.only(bottom: 15),
                    builder: DotSwiperPaginationBuilder(
                      space: 3,
                      activeColor: Colors.white,
                      color: Colors.grey,
                      size: 6.0,
                      activeSize: 8.0,
                    ),
                  ),
                  //2
                  // pagination: const SwiperControl(
                  //   color: Colors.white,
                  //   size: 20,
                  //   padding: EdgeInsets.all(10),
                  //   iconNext: Icons.arrow_forward_outlined,
                  // ),

                  itemBuilder: (context, index) {
                    Planets planet = planetProviderT.jsonData[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              changePage(
                                DetailScreen(
                                  planet: planet,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 500,
                                margin: const EdgeInsets.only(top: 140),
                                decoration: BoxDecoration(
                                  color: homeProviderW.isDarkTheme
                                      ? Colors.black
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 130,
                                      ),
                                      Text(
                                        planet.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 58,
                                            color: homeProviderW.isDarkTheme
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      Text(
                                        planet.description,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 8,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: homeProviderW.isDarkTheme
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: homeProviderW.isDarkTheme
                                                ? Colors.white
                                                : Colors.black),
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              changePage(DetailScreen(
                                                planet: planet,
                                              )),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: homeProviderW.isDarkTheme
                                                ? Colors.black
                                                : Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 340,
                                child: RotationTransition(
                                  turns: _controller,
                                  child: Hero(
                                    tag: planet.hero,
                                    child: Container(
                                      height: 300,
                                      width: 340,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(planet.image),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 65,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xff29272A),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.home, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  homeProviderW.changeTheme(
                    !homeProviderW.isDarkTheme,
                  );
                },
                icon: Icon(
                    homeProviderW.isDarkTheme
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    changePage(
                      const LikeScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.favorite, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
