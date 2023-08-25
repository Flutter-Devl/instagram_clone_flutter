import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/constants/color.dart';
import 'package:instagram_clone_flutter/models/profile_json.dart';
import 'package:shimmer/shimmer.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(size),
    );
  }

  PreferredSizeWidget getAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(55),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.lock, size: 18),
                  SizedBox(width: 10),
                  Text(
                    username,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                    splashRadius: 15,
                    icon: const Icon(Icons.add),
                    onPressed: () {},
                  ),
                  IconButton(
                    splashRadius: 15,
                    icon: const Icon(Icons.menu),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBody(size) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildProfileInfo(size),
              const SizedBox(height: 15),
              const Text(instagramName),
              const Text(instagramBio),
              const SizedBox(height: 15),
              buildEditProfileButton(size),
              const SizedBox(height: 15),
              buildStoryHighlights(),
            ],
          ),
        ),
        const SizedBox(height: 15),
        buildTabButtons(),
        const SizedBox(height: 3),
        IndexedStack(
          index: selectedIndex,
          children: [
            buildImagesWithShimmer(size, images),
            buildImagesWithShimmer(size, imageWithTags),
          ],
        ),
      ],
    );
  }

  Widget buildProfileInfo(size) {
    return Row(
      children: [
        SizedBox(
          width: (size.width - 20) * 0.3,
          child: buildProfileImageWithAddButton(),
        ),
        SizedBox(
          width: (size.width - 20) * 0.7,
          child: buildPostFollowerFollowingCounts(),
        ),
      ],
    );
  }

  Widget buildProfileImageWithAddButton() {
    return Stack(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1, color: bgGrey),
            image: const DecorationImage(
              image: NetworkImage(profile),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 25,
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primary,
              border: Border.all(width: 1, color: bgWhite),
            ),
            child: const Center(
              child: Icon(Icons.add, color: bgWhite),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPostFollowerFollowingCounts() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildCount("61", "Posts"),
        buildCount("117", "Followers"),
        buildCount("173", "Following"),
      ],
    );
  }

  Widget buildCount(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, height: 1.5),
        ),
      ],
    );
  }

  Widget buildEditProfileButton(size) {
    return Container(
      height: 35,
      width: (size.width - 20),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: bgGrey),
        borderRadius: BorderRadius.circular(5),
        color: bgLightGrey,
      ),
      child: const Center(
        child: Text("Edit Profile"),
      ),
    );
  }

  Widget buildStoryHighlights() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Story Highlights", style: TextStyle(fontWeight: FontWeight.bold)),
        Icon(Icons.arrow_downward, size: 20),
      ],
    );
  }

  Widget buildTabButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          buildTabButton(Icons.apps_rounded, 0),
          buildTabButton(Icons.account_box_outlined, 1),
        ],
      ),
    );
  }

  Widget buildTabButton(IconData icon, int index) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 0.5),
      child: IconButton(
        splashRadius: 20,
        icon: Icon(
          icon,
          color:
              selectedIndex == index ? textBlack : textBlack.withOpacity(0.5),
        ),
        onPressed: () {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget buildImagesWithShimmer(size, imageList) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 3,
      runSpacing: 3,
      children: List.generate(imageList.length, (index) {
        return buildImageWithShimmer(size, imageList[index]);
      }),
    );
  }

  Widget buildImageWithShimmer(size, imageUrl) {
    return FutureBuilder(
      future: Future.delayed(
        const Duration(milliseconds: 2000),
        () => imageUrl,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            period: const Duration(milliseconds: 2000),
            child: Container(
              width: (size.width - 6) / 3,
              height: 150,
              color: Colors.white,
            ),
          );
        } else {
          if (snapshot.hasError) {
            return const Icon(Icons.error);
          } else {
            return Container(
              width: (size.width - 6) / 3,
              height: 150,
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
  }
}
