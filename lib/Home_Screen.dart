import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'weather_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String location = "Baghdad, Iraq";
  String weatherDescription = "Loading...";
  double temperature = 0.0;
  double windSpeed = 0.0;
  int humidity = 0;

  final List<String> imgList = [
    'https://via.placeholder.com/600x400/8f8e94/FFFFFF?text=Image+1',
    'https://via.placeholder.com/600x400/8e8e94/FFFFFF?text=Image+2',
    'https://via.placeholder.com/600x400/8d8e94/FFFFFF?text=Image+3',
  ];

  final List<String> iraqCities = [
    'Baghdad',
    'Basra',
    'Erbil',
    'Najaf',
    'Karbala',
    // Add more cities as needed
  ];

  @override
  void initState() {
    super.initState();
    fetchWeatherData('Baghdad');
  }

  Future<void> fetchWeatherData(String city) async {
    try {
      var weatherData = await WeatherService().fetchWeather(city);
      setState(() {
        location = city;
        weatherDescription = weatherData['weather'][0]['description'];
        temperature = weatherData['main']['temp'];
        windSpeed = weatherData['wind']['speed'];
        humidity = weatherData['main']['humidity'];
      });
    } catch (e) {
      print(e);
      setState(() {
        weatherDescription = "Failed to load weather data";
      });
    }
  }

  void showCitySelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select a City'),
          content: Container(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: iraqCities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(iraqCities[index]),
                  onTap: () {
                    Navigator.of(context).pop();
                    fetchWeatherData(iraqCities[index]);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Weather App')),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: showCitySelectionDialog,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Color.fromARGB(255, 0, 0, 0)),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: const Color.fromARGB(255, 0, 0, 0)),
              title: Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlueAccent, Colors.blueAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Location
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),

                // Carousel Slider
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayOnTouch: true,
                  ),
                  items: imgList.map((item) => Container(
                    child: Center(
                      child: Image.network(item, fit: BoxFit.cover, width: 1000)
                    ),
                  )).toList(),
                ),
                SizedBox(height: 16.0),

                // Weather Icon
                Icon(
                  Icons.wb_sunny,
                  size: 100.0,
                  color: Colors.yellow,
                ),
                SizedBox(height: 16.0),

                // Temperature
                Text(
                  '${temperature.toStringAsFixed(1)}°C',
                  style: TextStyle(
                    fontSize: 56.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),

                // Weather Description
                Text(
                  weatherDescription,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),

                // Additional Weather Information
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.air, color: Colors.white),
                        SizedBox(height: 8.0),
                        Text(
                          '${windSpeed.toStringAsFixed(1)} km/h',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        SizedBox(height: 8.0),
                        Text('Wind', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.water_drop, color: Colors.white),
                        SizedBox(height: 8.0),
                        Text(
                          '$humidity%',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        SizedBox(height: 8.0),
                        Text('Humidity', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),

                // Weather Forecast Button
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to forecast screen (not implemented)
                  },
                  child: Text('View 7-day Forecast'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
