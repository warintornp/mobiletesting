import 'package:flutter/material.dart';
import 'package:mobiletesting/pages/home_view_model.dart';
import 'package:mobiletesting/pages/news_screen.dart';
import 'package:mobiletesting/pages/profile_screen.dart';
import 'package:mobiletesting/pages/user_profile_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<HomeViewModel>(context, listen: false).onDidLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key("home_screen"),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          // Header
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            //User profile
            Consumer<HomeViewModel>(builder: (context, viewModel, child) {
              return UserProfileView(
                userDetails: viewModel.userDetails,
              );
            }),
            const SizedBox(height: 150),
            //News Section Header
            newsheader(),
            // Image Carousel
            ImageCarousel(),
          ]),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // Handle Home button press
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle Search button press
            },
          ),
          Consumer<HomeViewModel>(builder: (context, viewModel, child) {
            return IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileScreen(userDetails: viewModel.userDetails)),
                );
              },
            );
          }),
        ]),
      ),
    );
  }

// News section header
  Widget newsheader() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'Latest News',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

// Image Carousel
class ImageCarousel extends StatelessWidget {
  // List of news images
  final List<String> newsImages = [
    // 'https://via.placeholder.com/600x400.png?text=News+1',
    // 'https://via.placeholder.com/600x400.png?text=News+2',
    // 'https://via.placeholder.com/600x400.png?text=News+3',
    // 'https://via.placeholder.com/600x400.png?text=News+4',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0, // Set the height of the carousel
      width: 70.0,
      child: PageView.builder(
        itemCount: newsImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to the DetailsPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsScreen(imageURL: newsImages[index]),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0), // Adjust radius here
                child: Image.network(
                  newsImages[index],
                  fit: BoxFit.cover,
                  width: double.infinity, // Stretch image to fill width
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Background gradient container

