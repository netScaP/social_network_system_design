// Replication
// - master-slave (one sync)
// - replication factor 2
//
// Partition
// - users by hash, field city_id

Table cities {
  id Int [pk, increment]
  name String [not null]
}

Table users {
  id Int [pk, increment]
  full_name String [not null]
  description String [not null]
  city_id Int [not null]
  photo_id Int

  Indexes {
    city_id [type: hash] // to find a users from the same city
  }
}

Table user_interests {
  user_id Int [not null]
  title String [not null]

  Indexes {
    title [type: hash] // to find a users with the same interests
    user_id [type: hash] // to find a user's interests
  }
}

Table user_friends {
  user_id Int [not null]
  friend_user_id Int [not null]

  Indexes {
    user_id [type: hash] // to find a users friends
    friend_user_id [type: hash] // to find a users who subscribed to you
  }
}

Table uploads {
  id Int [pk, increment]
  path String [not null]
}

// Creating references
Ref: cities.id > users.id
Ref: users.photo_id - uploads.id
Ref: users.id < user_interests.user_id
Ref: users.id < user_friends.user_id
Ref: users.id < user_friends.friend_user_id
//----------------------------------------------//
