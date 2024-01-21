// Replication
// - master-slave (one sync)
// - replication factor 2
//
// Sharding
// - key based by chat id

Table users {
  id Int [pk, increment]
  full_name String [not null]
  photo_id Int
}

Table uploads {
  id Int [pk, increment]
  path String [not null]
}

Enum ChatType {
  private
  public
}

Table chats {
  id Int [pk, increment]
  type ChatType [not null]
  created_at Date [not null]
}

Table chat_user {
  chat_id Int [not null]
  user_id Int [not null]

  Indexes {
    user_id [type: hash] // to find a user's chats
  }
}

Table messages {
  id Int [pk, increment]
  chat_id Int [not null]
  user_id Int [not null]
  content String [not null]
  created_at Date [not null]

  Indexes {
    (chat_id, user_id) [type: hash] // to find a user's messages in chat
  }
}

Table chat_last_readed {
  chat_id Int [not null]
  user_id Int [not null]
  message_id Int [not null]

  Indexes {
    (chat_id, user_id) [type: hash] // to find a last time user seen chat
  }
}

// Creating references
Ref: users.photo_id - uploads.id

Ref: chats.id < chat_user.chat_id
Ref: users.id <> chat_user.user_id
Ref: chats.id < messages.chat_id
Ref: messages.user_id - chat_user.user_id

Ref: chat_last_readed.(chat_id, user_id) - chat_user.(chat_id, user_id)
Ref: chat_last_readed.message_id > messages.id
//----------------------------------------------//
