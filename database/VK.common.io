// Replication
// - master-slave (one sync)
// - replication factor 2
//
// Partition
// - posts by range, field created_at

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

Table posts {
  id Int [pk, increment]
  user_id Int [not null]
  content String [not null]
  created_at Date [not null]

  Indexes {
    user_id [type: hash] // to find a users posts
    created_at [type: btree] // to filter posts by date range
  }
}

Table uploads {
  id Int [pk, increment]
  path String [not null]
}

Table post_upload {
  post_id Int [not null]
  upload_id Int [not null]

  Indexes {
    post_id [type: hash] // to find a posts uploads
  }
}

// Creating references
Ref: cities.id > users.id
Ref: users.photo_id - uploads.id
Ref: users.id < user_interests.user_id
Ref: users.id < user_friends.user_id
Ref: users.id < user_friends.friend_user_id

Ref: users.id < posts.user_id
Ref: posts.id < post_upload.post_id
Ref: post_upload.upload_id - uploads.id
//----------------------------------------------//
