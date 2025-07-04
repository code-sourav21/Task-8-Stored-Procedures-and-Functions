USE task8;

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(10,2),
    Department VARCHAR(30)
);

INSERT INTO Employees VALUES
(1, 'Sourav', 66550, 'IT'),
(2, 'Debraj', 45000, 'HR'),
(3, 'Souvik', 60000, 'Finance');

-- Procudure

DELIMITER //

CREATE PROCEDURE IncreaseSalaryByDept(
    IN dept_name VARCHAR(30),
    IN percent_increase DECIMAL(5,2)
)
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * percent_increase / 100)
    WHERE Department = dept_name;
END //

DELIMITER ;

-- Function

DELIMITER //

CREATE FUNCTION GetAnnualSalary(emp_id INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE annual_salary DECIMAL(12,2);
    SELECT Salary * 12 INTO annual_salary
    FROM Employees
    WHERE EmpID = emp_id;
    RETURN annual_salary;
END //

DELIMITER ;


SET SQL_SAFE_UPDATES = 0;

CALL IncreaseSalaryByDept('IT', 10);

SELECT * FROM Employees;

SELECT Name, GetAnnualSalary(EmpID) AS AnnualSalary
FROM Employees;
