USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'BD Salarios')
BEGIN
    ALTER DATABASE [BD Salarios] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [BD Salarios];
END
GO


CREATE DATABASE [BD Salarios];
GO

USE [BD Salarios];
GO


CREATE TABLE Departamento
(
    IdDepartamento INT PRIMARY KEY IDENTITY(1,1),
    NombreDepto VARCHAR(50) NOT NULL
);

CREATE TABLE Empleado
(
    IdEmpleado INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Cargo VARCHAR(50) NOT NULL,
    IdDepartamento INT,
    FechaIngreso DATE NOT NULL,
    CONSTRAINT FK_Empleado_Depto FOREIGN KEY (IdDepartamento) REFERENCES Departamento(IdDepartamento)
);

CREATE TABLE Salario
(
    IdSalario INT PRIMARY KEY IDENTITY(1,1),
    IdEmpleado INT NOT NULL,
    SalarioBase DECIMAL(10, 2) NOT NULL,
    Bono DECIMAL(10, 2) DEFAULT 0.00,
    Deducciones DECIMAL(10, 2) DEFAULT 0.00,
    MesCorrespondiente VARCHAR(20) NOT NULL DEFAULT 'Noviembre 2026',
    MetodoPago VARCHAR(30) NOT NULL DEFAULT 'Transferencia Bancaria',
    FechaPago DATE NOT NULL,
    CONSTRAINT FK_Empleado_Salario FOREIGN KEY (IdEmpleado) REFERENCES Empleado(IdEmpleado)
);

INSERT INTO Departamento (NombreDepto) VALUES ('Sistemas'), ('Recursos Humanos'), ('Contabilidad');

INSERT INTO Empleado (Nombre, Apellido, Cargo, IdDepartamento, FechaIngreso) VALUES 
('Carlos', 'Martínez', 'Desarrollador Junior', 1, '2025-02-01'),
('Ana', 'Rodríguez', 'Analista de Sistemas', 1, '2024-06-15'),
('José', 'Hernández', 'Soporte Técnico', 2, '2025-05-10');

INSERT INTO Salario (IdEmpleado, SalarioBase, Bono, Deducciones, MesCorrespondiente, MetodoPago, FechaPago) VALUES 
(1, 750.00, 50.00, 30.00, 'Noviembre 2026', 'Transferencia', '2026-08-31'),
(2, 958.00, 100.00, 45.00, 'Noviembre 2026', 'Transferencia', '2026-08-31'),
(3, 600.00, 25.00, 20.00, 'Noviembre 2026', 'Efectivo', '2026-08-31');