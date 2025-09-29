CREATE DATABASE MessengerDB;
GO

USE MessengerDB;
GO

-- Таблиця користувачів

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    [Password] NVARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Таблиця груп (чатів)

CREATE TABLE Groups (
    GroupID INT IDENTITY(1,1) PRIMARY KEY,
    GroupName NVARCHAR(100) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);


-- Таблиця повідомлень
CREATE TABLE Messages (
    MessageID INT IDENTITY(1,1) PRIMARY KEY,
    SenderID INT NOT NULL,
    GroupID INT NULL,
    ReceiverID INT NULL, -- для приватних повідомлень
    Content NVARCHAR(MAX) NOT NULL,
    SentAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (SenderID) REFERENCES Users(UserID),
    FOREIGN KEY (GroupID) REFERENCES Groups(GroupID),
    FOREIGN KEY (ReceiverID) REFERENCES Users(UserID)
);

-- Таблиця учасників груп

CREATE TABLE GroupMembers (
    GroupID INT NOT NULL,
    UserID INT NOT NULL,
    JoinedAt DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (GroupID, UserID),
    FOREIGN KEY (GroupID) REFERENCES Groups(GroupID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


-- Таблиця друзів (контакти)

CREATE TABLE Friendships (
    UserID INT NOT NULL,
    FriendID INT NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (UserID, FriendID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (FriendID) REFERENCES Users(UserID)
);

-- Таблиця реакцій на повідомлення
CREATE TABLE MessageReactions (
    ReactionID INT IDENTITY(1,1) PRIMARY KEY,
    MessageID INT NOT NULL,
    UserID INT NOT NULL,
    ReactionType NVARCHAR(20) NOT NULL, -- like, love, smile
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (MessageID) REFERENCES Messages(MessageID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


-- Таблиця вкладень у повідомленнях
CREATE TABLE Attachments (
    AttachmentID INT IDENTITY(1,1) PRIMARY KEY,
    MessageID INT NOT NULL,
    FilePath NVARCHAR(255) NOT NULL,
    FileType NVARCHAR(50) NOT NULL, -- image, video, doc
    UploadedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (MessageID) REFERENCES Messages(MessageID)
);


-- Таблиця дзвінків
CREATE TABLE Calls (
    CallID INT IDENTITY(1,1) PRIMARY KEY,
    CallerID INT NOT NULL,
    ReceiverID INT NOT NULL,
    CallType NVARCHAR(20) NOT NULL, -- audio, video
    CallStart DATETIME NOT NULL,
    CallEnd DATETIME NULL,
    FOREIGN KEY (CallerID) REFERENCES Users(UserID),
    FOREIGN KEY (ReceiverID) REFERENCES Users(UserID)
);

-- Таблиця сповіщень
CREATE TABLE Notifications (
    NotificationID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    Message NVARCHAR(255) NOT NULL,
    IsRead BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Таблиця статусів
CREATE TABLE Statuses (
    StatusID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    StatusText NVARCHAR(100),
    IsOnline BIT DEFAULT 0,
    LastSeen DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Таблиця заблокованих користувачів
CREATE TABLE BlockedUsers (
    BlockID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    BlockedUserID INT NOT NULL,
    BlockedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (BlockedUserID) REFERENCES Users(UserID)
);

-- Таблиця налаштувань користувачів
CREATE TABLE Settings (
    SettingID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    Theme NVARCHAR(20) DEFAULT 'light',
    Language NVARCHAR(10) DEFAULT 'uk',
    PrivacyLevel NVARCHAR(20) DEFAULT 'friends-only',
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
