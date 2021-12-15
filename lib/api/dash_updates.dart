class DashUpdates {
  final List _dashUpdates = [
    {
      "id": 0,
      "author": "Dash the Flutter Mascot",
      "image": "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
      "content":
          "Hey y'all, this is Dash here! I'm finally back from vacation and ready to get Fluttering again!",
      "authorImage": "https://docs.flutter.dev/assets/images/dash/Dash.png",
      "comments": [
        {
          "author": "Khanh Nguyen",
          "comment": "Welcome back Dash!!",
        },
        {
          "author": "Dash the Flutter Mascot",
          "comment": "Thanks Khanh!!",
        },
      ],
    },
    {
      "id": 1,
      "author": "Khanh Nguyen",
      "image":
          "https://docs.flutter.dev/assets/images/dash/dash-conference-swag.jpg",
      "content":
          "Y'all, I've found the Dash plushie warehouse. No one tell Shams that I'm here... ",
      "authorImage":
          "https://yt3.ggpht.com/ytc/AKedOLSepRT0gjLvp3HSmlNpdM7GHfwmBj8Cegc1s0mWKQ=s176-c-k-c0x00ffffff-no-rj",
      "comments": [
        {
          "author": "Shams Zakhour",
          "comment": "...I can see this post you know...",
        },
        {
          "author": "Khanh Nguyen",
          "comment": "...Ooopsies 😳 ",
        }
      ],
    },
    {
      "id": 2,
      "author": "Craig Labenz",
      "image": "",
      "content":
          "I would give anything to know how elevators influence my dog's understanding of the world",
      "authorImage":
          "https://pbs.twimg.com/profile_images/1290813376377974784/bdzo7QcN_400x400.jpg",
      "comments": [
        {
          "author": "Craig's Dog",
          "comment": "WOOF!",
        }
      ],
    },
    {
      "id": 3,
      "author": "Shams Zakhour",
      "image":
          "https://docs.flutter.dev/assets/images/dash/ShamsDashJacket.png",
      "content": "Check out my new Dash-inspired jean jacket! – Shams",
      "authorImage":
          "https://docs.flutter.dev/assets/images/dash/dash-prototypes.jpg",
      "comments": [
        {
          "author": "Nilay Yener",
          "comment": "I love it!",
        },
        {
          "author": "Khanh Nguyen",
          "comment":
              "This is my very really super long comment that is going to need to wrap around my name and then keep going on the next row. They’re two separate text fields because I want to style them differently."
        }
      ],
    },
  ];

  List addComment(int postId, String comment, String author) {
    _dashUpdates[postId]["comments"]
        .add({"author": author, "comment": comment});

    return _dashUpdates;
  }

  Map updateContent(Map content) {
    // Add some content validation here

    _dashUpdates.add(content);

    return content;
  }

  List getUpdates() {
    return _dashUpdates;
  }
}
