// Replication
// - master-slave (one sync)
// - replication factor 2
//
// Partition
// - posts by range, field created_at

Table users {
  id Int [pk, increment]
  full_name String [not null]
  photo_id Int
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
Ref: users.photo_id - uploads.id

Ref: users.id < posts.user_id
Ref: posts.id < post_upload.post_id
Ref: post_upload.upload_id - uploads.id
//----------------------------------------------//
