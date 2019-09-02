import 'package:chat/utils/not_null_map.dart';

class Message{
  String data;
  bool sent = false;
  String sender;
  String messageId;
  String receiver;
  MessageType messageType;
  Message({this.data,this.messageId,this.receiver,this.sender,this.sent,this.messageType});

  factory Message.sent({String data,String messageId,String receiver}){
    return Message(data: data,messageId: messageId,messageType: MessageType.SENT,receiver: receiver);
  }

  factory Message.received({String data, String sender}){
    return Message(sender: sender,data: data,messageType: MessageType.RECEIVED);
  }

  Map toJson(){
    return NotNullMapBuilder.fromMap({
      "message":data,
      "message_id":messageId,
      "receiver":receiver
    }).build();
  }
}
enum MessageType{
  SENT,
  RECEIVED,
  FILE_SENT,
  FILE_RECEIVED,
}