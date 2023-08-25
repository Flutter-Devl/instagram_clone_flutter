import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/constants/color.dart';
import 'package:instagram_clone_flutter/models/search_json.dart';
import 'package:instagram_clone_flutter/utils/category_story_items.dart';
import 'package:shimmer/shimmer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Row(
              children: <Widget>[
                const SizedBox(width: 15),
                Container(
                  width: size.width - 30,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: textFieldBackground,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon:
                          Icon(Icons.search, color: white.withOpacity(0.3)),
                    ),
                    style: TextStyle(color: white.withOpacity(0.3)),
                    cursorColor: white.withOpacity(0.3),
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: List.generate(searchCategories.length, (index) {
                  return CategoryStoryItem(name: searchCategories[index]);
                }),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 1,
            runSpacing: 1,
            children: List.generate(searchImages.length, (index) {
              return FutureBuilder(
                future: Future.delayed(
                  const Duration(milliseconds: 2000),
                  () => searchImages[index],
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      period: const Duration(milliseconds: 2000),
                      child: Container(
                        width: (size.width - 3) / 3,
                        height: (size.width - 3) / 3,
                        color: Colors.white,
                      ),
                    );
                  } else {
                    if (snapshot.hasError) {
                      return const Icon(Icons.error);
                    } else {
                      return Container(
                        width: (size.width - 3) / 3,
                        height: (size.width - 3) / 3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(snapshot.data.toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
