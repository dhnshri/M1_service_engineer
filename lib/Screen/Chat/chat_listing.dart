import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_engineer/Repository/UserRepository.dart';
import 'package:service_engineer/Screen/Chat/chat_screen.dart';
import 'package:service_engineer/Screen/Chat/database.dart';

class chatListing extends StatefulWidget {
  @override
  _chatListingState createState() => _chatListingState();
}

class _chatListingState extends State<chatListing> {
  bool isSearching = false;
  String? myName, myProfilePic, myUserName, myEmail;
  Stream? usersStream, chatRoomsStream;

  TextEditingController searchUsernameEditingController =
  TextEditingController();

  getMyInfoFromSharedPreference() async {
    myName = 'Pratik';
    myProfilePic = '';
    myUserName = 'pratik';
    myEmail = 'pratik';
    setState(() {});
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  onSearchBtnClick() async {
    isSearching = true;
    setState(() {});
    usersStream = await DatabaseMethods()
        .getUserByUserName(searchUsernameEditingController.text);

    setState(() {});
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              return ChatRoomListTile(ds.id, myUserName!);
            })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget searchListUserTile({String? profileUrl, name, username, email}) {
    return GestureDetector(
      onTap: () {
        var chatRoomId = getChatRoomIdByUsernames(myUserName!, username);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [myUserName, username]
        };
        DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(username, username)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(40),
            //   child: Image.network(
            //     profileUrl!,
            //     height: 40,
            //     width: 40,
            //   ),
            // ),
            SizedBox(width: 12),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(username), Text(email)])
          ],
        ),
      ),
    );
  }

  Widget searchUsersList() {
    return StreamBuilder(
      stream: usersStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return searchListUserTile(
                // profileUrl: ds["photoUrl"],
                username: ds["nickname"],
                email: ds["id"],
                );
          },
        )
            : Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  getChatRooms() async {
    chatRoomsStream = await DatabaseMethods().getChatRooms(myUserName!);
    setState(() {});
  }

  onScreenLoaded() async {
    await getMyInfoFromSharedPreference();
    myUserName =
    UserRepository().getRole() == 'Machine Maintenance' ? 'pratik' : 'test';
    getChatRooms();
  }

  @override
  void initState() {
    onScreenLoaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messenger Clone"),
        actions: [
          InkWell(
            onTap: () {
              // AuthMethods().signOut().then((s) {
              //   Navigator.pushReplacement(
              //       context, MaterialPageRoute(builder: (context) => SignIn()));
              // });
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                isSearching
                    ? GestureDetector(
                  onTap: () {
                    isSearching = false;
                    searchUsernameEditingController.text = "";
                    setState(() {});
                  },
                  child: Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(Icons.arrow_back)),
                )
                    : Container(),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                              controller: searchUsernameEditingController,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: "username"),
                            )),
                        GestureDetector(
                            onTap: () {
                              if (searchUsernameEditingController.text != "") {
                                onSearchBtnClick();
                              }
                            },
                            child: Icon(Icons.search))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            isSearching ? Expanded(child: searchUsersList()) : chatRoomsList()
          ],
        ),
      ),
    );
  }
}

class ChatRoomListTile extends StatefulWidget {
  final String  chatRoomId, myUsername;
  ChatRoomListTile( this.chatRoomId, this.myUsername);

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String profilePicUrl = "", name = "", username = "";

  getThisUserInfo() async {
    username =
        widget.chatRoomId.replaceAll(widget.myUsername, "").replaceAll("_", "");
    QuerySnapshot querySnapshot = await DatabaseMethods().getUserInfo(username);
    print(
        "something bla bla ${querySnapshot.docs[0].id} ${querySnapshot.docs[0]["nickname"]}  ${querySnapshot.docs[0]["photoUrl"]}");
    name = "${querySnapshot.docs[0]["nickname"]}";
    profilePicUrl = "${querySnapshot.docs[0]["photoUrl"]}";
    print(username);
    print(name);
    setState(() {});
  }

  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(username, name)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(30),
            //   child: Image.network(
            //     profilePicUrl,
            //     height: 40,
            //     width: 40,
            //   ),
            // ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 3),
                // Text(widget.lastMessage)
              ],
            )
          ],
        ),
      ),
    );
  }
}
