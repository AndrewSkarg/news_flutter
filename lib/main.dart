import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'repositories/news/repository.dart' as rep;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

Future<void> main() async {
  runApp(const ForestVPNTestApp());
  // rep.MockNewsRepository newsRepository = rep.MockNewsRepository();

  // List<rep.Article> latestArticles = await newsRepository.getLatestArticles();
  // List<rep.Article> featuredArticles =
  //     await newsRepository.getFeaturedArticles();
}

class ForestVPNTestApp extends StatelessWidget {
  const ForestVPNTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ForestVPN test',
      home: MainWidget(),
    );
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 253, 254, 255),
        leading: GestureDetector(
          onTap: () {
            print('hello');
          },
          child: Transform.scale(
            scale: 0.7,
            child: Image.asset(
              'assets/images/arrow.png', // Шлях до вашого зображення
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Notifications',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                // child: Text(
                //   'Mark all read',
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 16.0,
                //   ),
                // ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.white, // Background color of the button
                    foregroundColor: const Color.fromARGB(
                        255, 255, 255, 255), // Transparent text color
                  ),
                  child: const Text(
                    'Mark all read',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    print("Clicked!!!");
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return null;
                    //     },
                    //   ),
                    // );
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
        ],
      ),
      body: const MainContent(),
    );
  }
}

class SingleItemPage extends StatefulWidget {
  final String imagePath;
  final String title;
  final String content;
  final String description;
  const SingleItemPage(
      {super.key,
      required this.description,
      required this.imagePath,
      required this.title,
      required this.content});

  @override
  _SingleItemPageState createState() => _SingleItemPageState(
        description: description,
        imagePath: imagePath,
        title: title,
        content: content,
      );
}

class _SingleItemPageState extends State<SingleItemPage> {
  ScrollController controller = ScrollController();
  final String imagePath;
  final String title;
  final String content;
  final String description;

  _SingleItemPageState({
    required this.description,
    required this.imagePath,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return DefaultTextStyle(
      style: const TextStyle(color: Colors.black, fontSize: 16),
      child: Container(
        color: Colors.white,
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          controller: controller,
          slivers: [
            SliverAppBar(
              toolbarHeight: 200,
              expandedHeight: 455.0,
              floating: true,
              pinned: true,
              snap: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: IconButton(
                  icon: const Icon(
                    CupertinoIcons.back,
                    size: 50,
                  ),
                  onPressed: () {
                    print("Clicked!!!");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const MainWidget();
                        },
                      ),
                    );
                  },
                ),
              ),
              flexibleSpace: _MyAppSpace(
                imagePath: imagePath.toString(),
                title: title,
              ),
            ),
            SliverToBoxAdapter(
                child: Container(
                    margin: const EdgeInsets.all(
                        16.0), // Adjust the value as needed
                    height:
                        screenHeight, // Встановлює висоту контейнера на максимально доступну частину екрану
                    color: Colors.white,
                    child: Text(description)))
          ],
        ),
      ),
    );
  }
}

class _MyAppSpace extends StatelessWidget {
  final String imagePath;
  final String title;
  const _MyAppSpace({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(imagePath);
    return LayoutBuilder(
      builder: (context, c) {
        return Column(
          children: [
            Flexible(
              child: Container(
                height: 495,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      imagePath,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      bottom: 40, // Adjust position as needed
                      left: 10, // Adjust position as needed
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class MainContent extends StatefulWidget {
  const MainContent({
    Key? key,
  }) : super(key: key);

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textStyle = theme.textTheme.displayMedium!.copyWith(
      fontSize: 25,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
    String getTimeDifference(DateTime publicationDate) {
      // Calculate the time difference from now
      Duration difference = DateTime.now().difference(publicationDate);
      if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
      } else {
        return 'just now';
      }
    }

    return Container(
      padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Featured', style: textStyle),
          const SizedBox(height: 20.0),
          const Carousel(),
          Text('Latest news', style: textStyle),
          const SizedBox(height: 20.0),
          Expanded(
            child: FutureBuilder<List<rep.Article>>(
              future: rep.MockNewsRepository().getLatestArticles(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Display a loading indicator
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Data has been fetched successfully, build the ListView with articles
                  return ListView(
                    children: [
                      for (var article
                          in snapshot.data!) // Iterate over the articles
                        Column(
                          children: [
                            const SizedBox(height: 5.0),
                            buildNewsCard(
                              article.id,
                              article.imageUrl,
                              article.title,
                              'Published ${getTimeDifference(article.publicationDate)}',
                              article.description.toString(),
                            ),
                          ],
                        ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  buildNewsCard(
      String id, imagePath, title, String content, String description) {
    var shape = RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(15.0), // Set rounded corner radius here
    );
    return GestureDetector(
      onTap: () {
        // Handle the tap or click event here
        print("Card " + title);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleItemPage(
              imagePath: imagePath,
              title: title,
              content: content,
              description: description,
            ),
          ),
        );
      },
      child: Card(
        shape: shape,
        elevation: 15,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: CachedNetworkImage(
                  // Заміна Image.network на CachedNetworkImage
                  imageUrl: imagePath,
                  width: 90.0,
                  height: 60,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  verticalDirection: VerticalDirection.down,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      content,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Carousel extends StatefulWidget {
  const Carousel({
    Key? key,
  }) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  _CarouselState({
    Key? key,
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: FutureBuilder<List<rep.Article>>(
        future: rep.MockNewsRepository().getFeaturedArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.black,
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var articles = snapshot.data!;
            final Map<DismissDirection, double> dismissThresholds = {
              DismissDirection.down:
                  1, // 40% екрану для видалення зправа наліво
            };
            return CarouselSlider.builder(
              itemCount: articles.length,
              itemBuilder: (context, index, realIndex) {
                var article = articles[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleItemPage(
                          imagePath: article.imageUrl,
                          title: article.title,
                          content: article.publicationDate.toString(),
                          description: article.description.toString(),
                        ),
                      ),
                    );
                  },
                  child: Dismissible(
                    
                    direction: DismissDirection.down,
                    background: Container(
                      color: Colors.white,
                    ),
                    key: ValueKey<int>(index),
                    onDismissed: (DismissDirection direction) {
                      setState(() {
                        articles.removeAt(index);
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: article.imageUrl,
                        height: 200,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                initialPage: 2,
              ),
            );
          }
        },
      ),
    );
  }
}
