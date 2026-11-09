CREATE TABLE Departments (
    DeptID varchar(20) PRIMARY KEY,
    name nvarchar(200),
    office nvarchar(100)
);

CREATE TABLE Employees (
    EmpCode varchar(20) PRIMARY KEY,
    Name nvarchar(50),
    BirthDate date,
    DeptID varchar(20) FOREIGN KEY REFERENCES Departments(DeptID)
);

CREATE TABLE Dependants (
    Number int,
    Name nvarchar(50),
    BirthDate Date,
    Role nvarchar(30),
    EmpCode varchar(20) FOREIGN KEY REFERENCES Employees(EmpCode),
    PRIMARY KEY (Number, EmpCode)
);