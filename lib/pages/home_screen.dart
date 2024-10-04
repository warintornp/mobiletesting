import 'package:flutter/material.dart';
import 'package:mobiletesting/pages/news_screen.dart';
import 'package:mobiletesting/pages/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic> userDetails;

  HomeScreen({required this.userDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          // Header
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //User profile
                  UserProfileWidget(
                    userDetails: userDetails,
                  ),
                  const SizedBox(height: 150),
                  //News Section Header
                  newsheader(),
                  // Image Carousel
                  ImageCarousel(),
                ]),
          ),
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
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProfileScreen(userDetails: userDetails)),
              );
            },
          ),
        ]),
      ),
    );
  }

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
class UserProfileWidget extends StatelessWidget {
  final Map<String, dynamic> userDetails;
  const UserProfileWidget({super.key, required this.userDetails});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100,
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: Column(
            children: [
              // User Name
              Text(
                userDetails['name'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // User Email
              Text(
                userDetails['email'],
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
