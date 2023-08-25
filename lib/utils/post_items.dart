import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shimmer/shimmer.dart';

class PostItem extends StatefulWidget {
  final String profileImg;
  final String name;
  final String postImg;
  final String caption;
  final bool isLoved;
  final String likedBy;
  final String viewCount;
  final String dayAgo;

  const PostItem({
    Key? key,
    required this.profileImg,
    required this.name,
    required this.postImg,
    required this.caption,
    required this.isLoved,
    required this.likedBy,
    required this.viewCount,
    required this.dayAgo,
  }) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildUserInfo(),
          _buildPostImage(),
          _buildIconRow(),
          _buildLikes(),
          _buildCaption(),
          _buildViewComments(),
          _buildCommentInput(),
          _buildTimestamp(),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(widget.profileImg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          const Icon(LineIcons.horizontalEllipsis, color: Colors.white)
        ],
      ),
    );
  }

  Widget _buildPostImage() {
    return FutureBuilder(
      future: Future.delayed(
          const Duration(milliseconds: 1500), () => widget.postImg),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            period: const Duration(milliseconds: 1500),
            child: Container(
                height: 400, width: double.infinity, color: Colors.white),
          );
        } else {
          if (snapshot.hasError) {
            return const Icon(Icons.error);
          } else {
            return Image.network(
              snapshot.data.toString(),
              height: 400,
              width: double.infinity,
              fit: BoxFit.cover,
            );
          }
        }
      },
    );
  }

  Widget _buildIconRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              widget.isLoved
                  ? SvgPicture.asset(
                      "assets/images/loved_icon.svg",
                      width: 27,
                    )
                  : SvgPicture.asset(
                      "assets/images/love_icon.svg",
                      width: 27,
                    ),
              const SizedBox(width: 20),
              SvgPicture.asset(
                "assets/images/comment_icon.svg",
                width: 27,
              ),
              const SizedBox(width: 20),
              SvgPicture.asset(
                "assets/images/message_icon.svg",
                width: 27,
              ),
            ],
          ),
          SvgPicture.asset(
            "assets/images/save_icon.svg",
            width: 27,
          ),
        ],
      ),
    );
  }

  Widget _buildLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: "Liked by ",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: "${widget.likedBy} ",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const TextSpan(
              text: "and ",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const TextSpan(
              text: "Other",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaption() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "${widget.name} ",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: widget.caption,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewComments() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Text(
        "View ${widget.viewCount} comments",
        style: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCommentInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(widget.profileImg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Text(
                "Add a comment...",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              const Text(
                "😂",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 10),
              const Text(
                "😍",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.add_circle,
                color: Colors.white.withOpacity(0.5),
                size: 18,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTimestamp() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Text(
        widget.dayAgo,
        style: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
