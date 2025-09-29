USE MessengerDB; 
GO

/* ===== Users ===== */
INSERT INTO Users (Username, Email, [Password]) VALUES
('alice','alice@example.com','hash1'),
('bob','bob@example.com','hash2'),
('carol','carol@example.com','hash3'),
('dave','dave@example.com','hash4'),
('eva','eva@example.com','hash5');

/* ===== Groups ===== */
INSERT INTO Groups (GroupName) VALUES
('Developers Chat'),
('Travel Buddies'),
('Music Lovers');

/* ===== GroupMembers ===== */
INSERT INTO GroupMembers (GroupID, UserID) VALUES
(1,1),(1,2),(1,3),
(2,2),(2,4),(2,5),
(3,1),(3,5);

/* ===== Friendships (двосторонні) ===== */
INSERT INTO Friendships (UserID, FriendID) VALUES
(1,2),(2,1),
(1,3),(3,1),
(2,4),(4,2),
(3,5),(5,3),
(4,5),(5,4);

/* ===== Messages ===== */
INSERT INTO Messages (SenderID, GroupID, ReceiverID, Content) VALUES
(1,1,NULL,'Hi everyone, welcome to Developers Chat!'),
(2,1,NULL,'Thanks Alice, excited to be here.'),
(3,1,NULL,'Hello devs!'),
(2,NULL,4,'Hey Dave, are you joining the trip?'),
(4,NULL,2,'Yes Bob, count me in.'),
(5,2,NULL,'Who wants to plan the route?'),
(1,3,NULL,'Any new album recommendations?'),
(5,3,NULL,'Try the latest synthwave mix!');

/* ===== MessageReactions ===== */
INSERT INTO MessageReactions (MessageID, UserID, ReactionType) VALUES
(1,2,'like'),
(1,3,'love'),
(2,1,'smile'),
(5,2,'like'),
(7,5,'love'),
(8,1,'like');

/* ===== Attachments ===== */
INSERT INTO Attachments (MessageID, FilePath, FileType) VALUES
(1,'/uploads/welcome.png','image'),
(4,'/uploads/trip_plan.pdf','doc'),
(7,'/uploads/songlist.jpg','image');

/* ===== Calls ===== */
INSERT INTO Calls (CallerID, ReceiverID, CallType, CallStart, CallEnd) VALUES
(1,2,'video','2025-09-28 10:00','2025-09-28 10:30'),
(2,4,'audio','2025-09-28 15:00','2025-09-28 15:20'),
(3,5,'video','2025-09-29 09:00','2025-09-29 09:45');

/* ===== Notifications ===== */
INSERT INTO Notifications (UserID, Message) VALUES
(1,'You have a new friend request'),
(2,'New message from Alice'),
(3,'Carol mentioned you in Developers Chat'),
(4,'Bob started a call with you'),
(5,'New group invite: Music Lovers');

/* ===== Statuses ===== */
INSERT INTO Statuses (UserID, StatusText, IsOnline) VALUES
(1,'Working on project',1),
(2,'Traveling',0),
(3,'On vacation',0),
(4,'Available',1),
(5,'Listening to music',1);

/* ===== BlockedUsers ===== */
INSERT INTO BlockedUsers (UserID, BlockedUserID) VALUES
(3,4),
(5,2);

/* ===== Settings ===== */
INSERT INTO Settings (UserID, Theme, Language, PrivacyLevel) VALUES
(1,'dark','en','friends-only'),
(2,'light','uk','public'),
(3,'dark','uk','private'),
(4,'light','en','friends-only'),
(5,'dark','en','friends-only');
