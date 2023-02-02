import 'package:flutter/material.dart';

class ListViewVert extends StatefulWidget {
  ListViewVert({Key? key}) : super(key: key);

  @override
  State<ListViewVert> createState() => _ListViewVertState();
}

class _ListViewVertState extends State<ListViewVert> {
  bool waifu = false;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            key: Key('counter-${index}'),
            title: Text("Hayuki Nohara"),
            subtitle: Text("Aries, December 26th 2005"),
            leading: CircleAvatar(
                backgroundImage:
                    Image.network("https://cdn.waifu.im/7121.png").image),
            trailing: Padding(
              padding: EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    waifu = !waifu;
                  });
                },
                icon: Icon(
                  (waifu == false) ? Icons.favorite_border : Icons.favorite,
                ),
                color: Colors.pink,
              ),
            ),
          );
        });
  }
}
