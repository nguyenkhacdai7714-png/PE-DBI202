USE [PE_DBI202]
GO
CREATE TABLE Salespersons (
SalespersonID INT,
Name VARCHAR(100),
CONSTRAINT PK_Salespersons PRIMARY KEY (SalespersonID)
)

CREATE TABLE Cars (
SerialNO INT,
Price DECIMAL(12),
Model VARCHAR(50),
SaleDate DATE,
SalespersonID INT,

CONSTRAINT PK_Cars PRIMARY KEY(SerialNO),
CONSTRAINT FK_Salespersons FOREIGN KEY (SalespersonID)
        REFERENCES Salespersons(SalespersonID));


CREATE TABLE Options (
SerialNo INT,
OptionName VARCHAR(100),
Price DECIMAL(8),
CONSTRAINT PK_Options PRIMARY KEY(SerialNo, OptionName),
CONSTRAINT FK_Options_Cars  FOREIGN KEY (SerialNo)
        REFERENCES Cars(SerialNo));
--NOTE:
--NHIỀU NHIỀU: LẶP BẢNG RIÊNG CHO QUAN HỆ 2 bảng -> BỔ SUNG THÊM 2 khóa chính của 2 bên vào bảng -> KHÓA CHÍNH LÀ KHÓA NGOẠI -> BỔ SUNG THÊM THUỘC TÍNH CÒN THIẾU

