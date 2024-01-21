# Tiny URL - System Design

Example of the homework for [course by System Design](https://balun.courses/courses/system_design).
TinyURL is a URL shortening web service, which provides short aliases for redirection
of long URLs.

### Functional requirements:

- signup, set profile info with photo
- find other users
- add friends
- manage user's posts
- recommendation user's feed
- private and public chats
- show messages seen time

### Non-functional requirements:

- 50 000 000 DAU
- availability 99,95%
- all information (users, messages, posts) stored forever
- service available CIS
- upload size limit - 500 MB
- message and post size limit - 1000 characters
- chat participant limit - 1000 users
- avg messages read per day - 20
- avg messages sent per day - 5
- avg posts read per day - 30
- avg posts sent per day - 3
- avg upload size - 10 MB
- response time for message sending - 1 sec
- response time for message receiving - 5 sec

## Basic calculations

RPS (read) = 50 000 000 \* (20 + 30) / 86 400 = 29 000
RPS (write) = 50 000 000 \* (5 + 3) / 86 400 = 4 600

Traffic per second (write) = 4 600 \* 2000 = 9 200 000 = 9 mb/s
Traffic per day (write) = 9 \* 86400 = 777 gb/d
Traffic per year (write) = 777 \* 365 = 283 tb/y

Initial storage capacity = 400 TB
Initial storage with replication and backups = 900 TB

HDD disk capacity = 6 TB
Number of HDD disks with replication = 150
Number of shards = 10 with 2 factor replication
