CREATE DATABASE MaxwellB2B;
GO

USE MaxwellB2B;
GO

CREATE TABLE Tarefas (
    Id INT PRIMARY KEY,
    Titulo NVARCHAR(150) NOT NULL,
    Status NVARCHAR(30) NOT NULL
        CHECK (Status IN (
            N'Pendente',
            N'Em andamento',
            N'Concluída'
        ))
);
GO

INSERT INTO Tarefas (Id, Titulo, Status)
VALUES
    (1, N'Assinar contrato', N'Pendente'),
    (2, N'Treinamento - ética no trabalho', N'Em andamento'),
    (3, N'Reunião com cliente', N'Concluída');
GO

SELECT * FROM Tarefas;
GO


USE MaxwellB2B;
GO

SELECT Id, Titulo, Status
FROM Tarefas
ORDER BY Id;