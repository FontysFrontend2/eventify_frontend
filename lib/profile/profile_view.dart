import 'package:flutter/material.dart';
import 'package:eventify_frontend/profile/user.dart';
import 'package:eventify_frontend/profile/interests.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile.dart';
import 'package:eventify_frontend/profile/themes.dart';
import 'package:eventify_frontend/profile/notifications.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfilePage> {
  late SharedPreferences prefs;
  bool isPlatformDark = false;

  changeTheme() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString("darkMode") == "true") {
        prefs.setString("darkMode", "false");
        isPlatformDark = false;
      } else {
        prefs.setString("darkMode", "true");
        isPlatformDark = true;
      }
    });
  }

  retrieveTheme() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString("darkMode") == "true") {
        isPlatformDark = true;
      } else {
        isPlatformDark = false;
      }
    });
  }

  @override
  void initState() {
    retrieveTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = UserInformation.myUser;

    return MaterialApp(
        theme: isPlatformDark ? Themes.dark : Themes.light,
        home: Scaffold(
            body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            TextButton(onPressed: changeTheme, child: Text('Theme')),
            Profile(
                path: user.path,
                onClicked: () {
                  Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              EditProfile()) //edit through a button
                      );
                }),
            const SizedBox(height: 25),
            name(user),
            const SizedBox(height: 24),
            Ranking(),
            const SizedBox(height: 50),
            description(user),
            const SizedBox(height: 24),
            password(user),
            const SizedBox(height: 25),
            interests(user),
            const SizedBox(height: 25),
            eventChatNot(),
            const SizedBox(height: 25),
            interestChatNot(),
            const SizedBox(height: 25),
            feedNot(),
            const SizedBox(height: 25),
            ElevatedButton(
              child: Text('Edit Profile'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            EditProfile()) //edit through a button
                    );
              },
            ),
          ],
        )));
    /*),
      ),
    );*/
  }

  //name and email boxes
  Widget name(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  //password box
  Widget password(User user) => Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 4),
          Text(
            changePassword(user),
            style: TextStyle(fontSize: 16, height: 1.4),
          ),
        ],
      ));

  //biography box
  Widget description(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Description',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Text(
              user.description,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  //interests
  Widget interests(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'My interests',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            SwitchScreen(),
          ],
        ),
      );

  Widget eventChatNot() => Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  'Event chat notifications',
                  style: TextStyle(fontSize: 15),
                ),
                SwitchEventNot(),
              ],
            )
          ],
        ),
      );

  Widget interestChatNot() => Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  'Interest chat notifications',
                  style: TextStyle(fontSize: 15),
                ),
                SwitchInterestNot(),
              ],
            )
          ],
        ),
      );

  Widget feedNot() => Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  'Feed notifications',
                  style: TextStyle(fontSize: 15),
                ),
                SwitchFeedNot(),
              ],
            )
          ],
        ),
      );
}

class Profile extends StatelessWidget {
  final String path;
  final bool edit;
  final VoidCallback onClicked;

  const Profile({
    Key? key,
    required this.path,
    this.edit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  //profile picture
  Widget buildImage() {
    final image = NetworkImage(path);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  //edit profile through the picture
  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            edit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

class Ranking extends StatelessWidget {
  int rank = 0;
  int friends = 0;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          numberButton(context, rank, 'Ranking'),
          divider(),
          numberButton(context, friends, 'Friends'),
        ],
      );

  Widget divider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget numberButton(BuildContext context, int value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              value.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          onPrimary: Colors.red,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: Text(text),
        onPressed: onClicked,
      );
}

/*AppBar appBar(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final icon = CupertinoIcons.moon_stars;

  return AppBar(
    leading: BackButton(),
    backgroundColor: Colors.lightBlueAccent,
    elevation: 0,
    actions: [
      ThemeSwitcher(
        builder: (context) => IconButton(
          icon: Icon(icon),
          onPressed: () {
            final theme = isDarkMode ? Themes.light : Themes.dark;

            final switcher = ThemeSwitcher.of(context);
            switcher.changeTheme(theme: theme);
          },
        ),
      ),
    ],
  );
}*/
