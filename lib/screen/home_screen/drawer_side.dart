import 'package:flutter/material.dart';

class DrawerSide extends StatelessWidget {
  const DrawerSide({key});
  Widget listTile({IconData icon, String title}) {
    return ListTile(
      leading: Icon(icon, size: 32),
      title: Text(
        title,
        style: TextStyle(color: Colors.black45),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Color(0xffd1ad17),
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white54,
                  radius: 43,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Welcome Guest"),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      height: 30,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text("Login"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(width: 2)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          listTile(icon: Icons.home_outlined, title: "Home"),
          listTile(icon: Icons.shop_outlined, title: "Review Cart"),
          listTile(icon: Icons.person_outline, title: "My Profile"),
          listTile(icon: Icons.notifications_outlined, title: "Notifications"),
          listTile(icon: Icons.star_outline, title: "Rating & Review"),
          listTile(icon: Icons.favorite_outline, title: "Wishlist"),
          listTile(icon: Icons.copy_outlined, title: "Raise a Complaint"),
          listTile(icon: Icons.format_quote_outlined, title: "FAQs"),
          Container(
            height: 350,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Contact Support"),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text("Call us:"),
                    SizedBox(
                      width: 10,
                    ),
                    Text("+123456789"),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text("Mail us:"),
                      SizedBox(
                        width: 10,
                      ),
                      Text("hello@retry.com"),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
