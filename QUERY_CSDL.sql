use DB_WEB_ENGLISH
go

CREATE TABLE User1 (
    IDUser INT PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
	PassWord NVARCHAR(10) NOT NULL,
    SEX NVARCHAR(10) NOT NULL,
    Achievement INT NOT NULL,
    TotalScore INT NOT NULL
);
go
CREATE TABLE AUDIO (
	IDAudio INT PRIMARY KEY,
	LinkAudio TEXT NOT NULL
);
go

CREATE TABLE PICTURE (
	IDPicture INT PRIMARY KEY,
	LinkPicture TEXT NOT NULL
);
go
CREATE TABLE QUESTION (
	IDQUESTION INT PRIMARY KEY,
	LinkQUESTION TEXT NOT NULL,
	A TEXT NOT NULL,
	B TEXT NOT NULL,
	C TEXT NOT NULL,
	D TEXT NOT NULL,
	ANSWER TEXT NOT NULL
);
go
CREATE TABLE EXAM (
    IDEXAM INT PRIMARY KEY
);
go
CREATE TABLE QL_EXAM (
    IDUser INT,
    IDEXAM INT,
	PointExam INT,
    FOREIGN KEY (IDUser) REFERENCES User1(IDUser),
    FOREIGN KEY (IDEXAM) REFERENCES EXAM(IDEXAM)
);
go

CREATE TABLE Part1 (
	IDPart1 int,
	PointPart1 int ,
	IDAudio INT,
	IDPicture INT,
	IDQUESTION INT,
	IDEXAM INT,
	FOREIGN KEY (IDEXAM) REFERENCES EXAM(IDEXAM),
	FOREIGN KEY (IDAudio) REFERENCES AUDIO(IDAudio),
	FOREIGN KEY (IDQUESTION) REFERENCES QUESTION(IDQUESTION),
	FOREIGN KEY (IDPicture) REFERENCES PICTURE(IDPicture)

);
go

CREATE TABLE Part2 (
	IDPart2 int,
	PointPart2 int,
	IDAudio INT,
	IDPicture INT,
	IDQUESTION INT,
		IDEXAM INT,
	FOREIGN KEY (IDEXAM) REFERENCES EXAM(IDEXAM),
	FOREIGN KEY (IDAudio) REFERENCES AUDIO(IDAudio),
	FOREIGN KEY (IDQUESTION) REFERENCES QUESTION(IDQUESTION),
	FOREIGN KEY (IDPicture) REFERENCES PICTURE(IDPicture)
);
go

CREATE TABLE Part3 (
	IDPart3 int ,
	PointPart3 int,
	IDAudio INT,
	IDPicture INT,
	IDQUESTION INT,
		IDEXAM INT,
	FOREIGN KEY (IDEXAM) REFERENCES EXAM(IDEXAM),
	FOREIGN KEY (IDAudio) REFERENCES AUDIO(IDAudio),
	FOREIGN KEY (IDQUESTION) REFERENCES QUESTION(IDQUESTION),
	FOREIGN KEY (IDPicture) REFERENCES PICTURE(IDPicture)
);
go

CREATE TABLE Part4 (
	IDPart4 int ,
	PointPart4 int,
	IDAudio INT,
	IDPicture INT,
	IDQUESTION INT,
		IDEXAM INT,
	FOREIGN KEY (IDEXAM) REFERENCES EXAM(IDEXAM),
	FOREIGN KEY (IDAudio) REFERENCES AUDIO(IDAudio),
	FOREIGN KEY (IDQUESTION) REFERENCES QUESTION(IDQUESTION),
	FOREIGN KEY (IDPicture) REFERENCES PICTURE(IDPicture)
);
go

CREATE TABLE Part5 (
	IDPart5 int ,
	PointPart5 int,
	IDAudio INT,
	IDPicture INT,
	IDQUESTION INT,
		IDEXAM INT,
	FOREIGN KEY (IDEXAM) REFERENCES EXAM(IDEXAM),
	FOREIGN KEY (IDAudio) REFERENCES AUDIO(IDAudio),
	FOREIGN KEY (IDQUESTION) REFERENCES QUESTION(IDQUESTION),
	FOREIGN KEY (IDPicture) REFERENCES PICTURE(IDPicture)
);
go

CREATE TABLE Part6 (
	IDPart6 int ,
	PointPart6 int,
	IDAudio INT,
	IDPicture INT,
	IDQUESTION INT,
		IDEXAM INT,
	FOREIGN KEY (IDEXAM) REFERENCES EXAM(IDEXAM),
	FOREIGN KEY (IDAudio) REFERENCES AUDIO(IDAudio),
	FOREIGN KEY (IDQUESTION) REFERENCES QUESTION(IDQUESTION),
	FOREIGN KEY (IDPicture) REFERENCES PICTURE(IDPicture)
);
go

CREATE TABLE Part7 (
	IDPart7 int,
	PointPart7 int,
	IDAudio INT,
	IDPicture INT,
	IDQUESTION INT,
		IDEXAM INT,
	FOREIGN KEY (IDEXAM) REFERENCES EXAM(IDEXAM),
	FOREIGN KEY (IDAudio) REFERENCES AUDIO(IDAudio),
	FOREIGN KEY (IDQUESTION) REFERENCES QUESTION(IDQUESTION),
	FOREIGN KEY (IDPicture) REFERENCES PICTURE(IDPicture)
);
go

-- Xem điểm từng để của từng ngưởi
SELECT 
    User1.IDUser,
    User1.Name,
    QL_EXAM.IDEXAM,
    QL_EXAM.PointExam
FROM 
    User1
JOIN 
    QL_EXAM ON User1.IDUser = QL_EXAM.IDUser;
-- Truy vẫn xem điểm của người dùng ở Part X
-- Truy vấn điểm cho IDPart = 1, IDEXAM = 1, và IDUser = 1
SELECT 
    User1.IDUser,
    User1.Name,
    QL_EXAM.IDEXAM,
    Part1.IDPart1,
    Part1.PointPart1
FROM 
    User1
JOIN 
    QL_EXAM ON User1.IDUser = QL_EXAM.IDUser
JOIN
    Part1 ON QL_EXAM.IDEXAM = Part1.IDEXAM AND User1.IDUser = QL_EXAM.IDUser
WHERE 
    Part1.IDPart1 = 1
    AND QL_EXAM.IDEXAM = 1
    AND User1.IDUser = 1;
--Xem câu hỏi, ảnh và audio của part 1 của EXAM 1
-- Truy vấn câu hỏi, ảnh và audio của từng đề (ví dụ: IDEXAM = 1)
SELECT 
    Part1.IDPart1,
    QUESTION.LinkQUESTION,
    QUESTION.A AS OptionA,
    QUESTION.B AS OptionB,
    QUESTION.C AS OptionC,
    QUESTION.D AS OptionD,
    QUESTION.ANSWER,
    PICTURE.LinkPicture,
    AUDIO.LinkAudio
FROM 
    Part1
JOIN 
    QUESTION ON Part1.IDQUESTION = QUESTION.IDQUESTION
JOIN 
    PICTURE ON Part1.IDPicture = PICTURE.IDPicture
JOIN 
    AUDIO ON Part1.IDAudio = AUDIO.IDAudio
WHERE 
    Part1.IDEXAM = 1 AND QUESTION.IDQUESTION BETWEEN 1001 AND 1006;

	-- Truy vấn thông tin từng Part2 của một đề (ví dụ: IDEXAM = 1)
SELECT 
    Part2.IDPart2,
    Part2.PointPart2,
	QUESTION.IDQuestion,
    QUESTION.LinkQUESTION AS Question_Link,
    QUESTION.A AS Option_A,
    QUESTION.B AS Option_B,
    QUESTION.C AS Option_C,
    QUESTION.D AS Option_D,
    QUESTION.ANSWER AS Correct_Answer,
    AUDIO.LinkAudio AS Audio_Link
FROM 
    Part2
JOIN 
    QUESTION ON Part2.IDQUESTION = QUESTION.IDQUESTION
JOIN 
    AUDIO ON Part2.IDAudio = AUDIO.IDAudio
WHERE 
    Part2.IDEXAM = 1
ORDER BY IDPart2;
-- Truy vấn thông tin từng Part3 của một đề (ví dụ: IDEXAM = 1)
SELECT 
    Part3.IDPart3,
    Part3.PointPart3,
    QUESTION.IDQuestion,
    QUESTION.LinkQUESTION AS Question_Link,
    QUESTION.A AS Option_A,
    QUESTION.B AS Option_B,
    QUESTION.C AS Option_C,
    QUESTION.D AS Option_D,
    QUESTION.ANSWER AS Correct_Answer,
    PICTURE.LinkPicture AS Picture_Link,
    AUDIO.LinkAudio AS Audio_Link
FROM 
    Part3
JOIN 
    QUESTION ON Part3.IDQUESTION = QUESTION.IDQUESTION
LEFT JOIN 
    PICTURE ON Part3.IDPicture = PICTURE.IDPicture
JOIN 
    AUDIO ON Part3.IDAudio = AUDIO.IDAudio
WHERE 
    Part3.IDEXAM = 1 OR Part3.IDPicture IS NULL  -- Include rows where Part3.IDPicture is NULL
ORDER BY 
    Part3.IDPart3;
--Part4
SELECT 
    Part4.IDPart4,
    Part4.PointPart4,
    QUESTION.IDQuestion,
    QUESTION.LinkQUESTION AS Question_Link,
    QUESTION.A AS Option_A,
    QUESTION.B AS Option_B,
    QUESTION.C AS Option_C,
    QUESTION.D AS Option_D,
    QUESTION.ANSWER AS Correct_Answer,
    PICTURE.LinkPicture AS Picture_Link,
    AUDIO.LinkAudio AS Audio_Link
FROM 
    Part4
JOIN 
    QUESTION ON Part4.IDQUESTION = QUESTION.IDQUESTION
LEFT JOIN 
    PICTURE ON Part4.IDPicture = PICTURE.IDPicture
JOIN 
    AUDIO ON Part4.IDAudio = AUDIO.IDAudio
WHERE 
    Part4.IDEXAM = 1 OR Part4.IDPicture IS NULL  -- Include rows where Part3.IDPicture is NULL
ORDER BY 
    Part4.IDPart4;
-- Truy vấn thông tin từng Part5 của một đề (ví dụ: IDEXAM = 1)
SELECT 
    Part5.IDPart5,
    Part5.PointPart5,
	QUESTION.IDQuestion,
    QUESTION.LinkQUESTION AS Question_Link,
    QUESTION.A AS Option_A,
    QUESTION.B AS Option_B,
    QUESTION.C AS Option_C,
    QUESTION.D AS Option_D,
    QUESTION.ANSWER AS Correct_Answer
FROM Part5
JOIN 
    QUESTION ON Part5.IDQUESTION = QUESTION.IDQUESTION
WHERE 
    Part5.IDEXAM = 1 AND Part5.IDQUESTION BETWEEN 1101 AND 1030;
ORDER BY IDPart5;
-- Truy vấn thông tin từng Part6 của một đề (ví dụ: IDEXAM = 1)
SELECT 
    Part6.IDPart6,
    Part6.PointPart6,
	QUESTION.IDQuestion,
    QUESTION.LinkQUESTION AS Question_Link,
    QUESTION.A AS Option_A,
    QUESTION.B AS Option_B,
    QUESTION.C AS Option_C,
    QUESTION.D AS Option_D,
    QUESTION.ANSWER AS Correct_Answer,
    PICTURE.LinkPicture AS Picture_Link
FROM 
    Part6
JOIN 
    QUESTION ON Part6.IDQUESTION = QUESTION.IDQUESTION
JOIN 
    PICTURE ON Part6.IDPicture = PICTURE.IDPicture
WHERE 
    Part6.IDEXAM = 1
ORDER BY IDPart6;
-- Truy vấn thông tin từng Part7 của một đề (ví dụ: IDEXAM = 1)
SELECT 
    Part7.IDPart7,
    Part7.PointPart7,
    QUESTION.LinkQUESTION AS Question_Link,
    QUESTION.A AS Option_A,
    QUESTION.B AS Option_B,
    QUESTION.C AS Option_C,
    QUESTION.D AS Option_D,
    QUESTION.ANSWER AS Correct_Answer,
    PICTURE.LinkPicture AS Picture_Link,
    AUDIO.LinkAudio AS Audio_Link
FROM 
    Part7
JOIN 
    QUESTION ON Part7.IDQUESTION = QUESTION.IDQUESTION
JOIN 
    PICTURE ON Part7.IDPicture = PICTURE.IDPicture
JOIN 
    AUDIO ON Part7.IDAudio = AUDIO.IDAudio
WHERE 
    Part7.IDEXAM = 1
ORDER BY IDPart7;

--Xem tất cả câu hỏi , ảnh và audio của một đề
-- Truy vấn câu hỏi, ảnh và audio từ tất cả các phần của một đề (ví dụ: IDEXAM = 1)
SELECT 
    Part1.IDPart1,
    Part1.PointPart1,
    Part2.IDPart2,
    Part2.PointPart2,
    Part3.IDPart3,
    Part3.PointPart3,
    Part4.IDPart4,
    Part4.PointPart4,
    Part5.IDPart5,
    Part5.PointPart5,
    Part6.IDPart6,
    Part6.PointPart6,
    Part7.IDPart7,
    Part7.PointPart7,
    QUESTION.LinkQUESTION,
    QUESTION.A,
    QUESTION.B,
    QUESTION.C,
    QUESTION.D,
    QUESTION.ANSWER,
    PICTURE.LinkPicture,
    AUDIO.LinkAudio
FROM 
    Part1
JOIN 
    QUESTION ON Part1.IDQUESTION = QUESTION.IDQUESTION
JOIN 
    PICTURE ON Part1.IDPicture = PICTURE.IDPicture
JOIN 
    AUDIO ON Part1.IDAudio = AUDIO.IDAudio
LEFT JOIN 
    Part2 ON Part1.IDEXAM = Part2.IDEXAM
LEFT JOIN 
    Part3 ON Part1.IDEXAM = Part3.IDEXAM
LEFT JOIN 
    Part4 ON Part1.IDEXAM = Part4.IDEXAM
LEFT JOIN 
    Part5 ON Part1.IDEXAM = Part5.IDEXAM
LEFT JOIN 
    Part6 ON Part1.IDEXAM = Part6.IDEXAM
LEFT JOIN 
    Part7 ON Part1.IDEXAM = Part7.IDEXAM
WHERE 
    Part1.IDEXAM = 1;
-- Tìm người dùng có tổng điểm cao nhất trong bảng User1
SELECT TOP 1
    IDUser,
    Name,
    ISNULL(Achievement, 0) + ISNULL(TotalScore, 0) AS TotalPoints
FROM 
    User1
ORDER BY 
    TotalPoints DESC;

-- Tìm người có tổng điểm cao nhất
SELECT TOP 1
    User1.IDUser,
    User1.Name,
    SUM(QL_EXAM.PointExam) AS TotalPoints
FROM 
    User1
JOIN 
    QL_EXAM ON User1.IDUser = QL_EXAM.IDUser
GROUP BY 
    User1.IDUser, User1.Name
ORDER BY TotalPoints DESC;
-- Truy vấn tên và mật khẩu từ bảng User1
SELECT
    Name,
    PassWord
FROM
    User1;
CREATE TABLE Vocabulary (
    WordID INT PRIMARY KEY IDENTITY(1,1),
    EnglishWord NVARCHAR(255) NOT NULL,
    VietnameseDefinition NVARCHAR(MAX),
    PartOfSpeech NVARCHAR(50),
    ExampleSentence NVARCHAR(MAX)
);


--Lấy danh sách tất cả các từ vựng trong cơ sở dữ liệu:
SELECT * FROM Vocabulary;
--Lấy danh sách 10 từ vựng tiếng Anh và định nghĩa tương ứng:
SELECT EnglishWord, VietnameseDefinition FROM Vocabulary LIMIT 10;
--Lọc các từ chỉ là danh từ:
SELECT * FROM Vocabulary WHERE PartOfSpeech = 'Noun';
--Sắp xếp các từ theo thứ tự bảng chữ cái:
SELECT * FROM Vocabulary ORDER BY EnglishWord;
--Tìm kiếm các từ chứa từ "construction":
SELECT * FROM Vocabulary WHERE EnglishWord LIKE '%construction%';


        SELECT
            P.IDPart1,
            P.PointPart1,
            P.IDAudio,
            A.LinkAudio,
            P.IDPicture,
            Pic.LinkPicture,
            P.IDQUESTION
        FROM
            Part1 P
        LEFT JOIN
            AUDIO A ON P.IDAudio = A.IDAudio
        LEFT JOIN
            PICTURE Pic ON P.IDPicture = Pic.IDPicture
        WHERE
            P.IDQUESTION BETWEEN 110001 AND 110006