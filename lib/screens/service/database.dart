import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  getUserByUsername(String username) async{
    return await FirebaseFirestore.instance.collection("user").where("Name", isEqualTo: username).get();
  }

  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("user").add(userMap).catchError((e){
      print(e.toString());
    });
  }

  createChatRoom(String chatRoomid, chatRoomMap){
    FirebaseFirestore.instance.collection(
      "ChatRoom"
    ).doc(chatRoomid).set(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }

}