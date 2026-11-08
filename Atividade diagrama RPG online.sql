-- Banco de dados: RPG Online
-- Script DDL baseado no diagrama entidade-relacionamento fornecido.
-- Compatível com MySQL 8.0+

CREATE DATABASE IF NOT EXISTS rpg_online
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE rpg_online;

-- Tabela de usuários
CREATE TABLE IF NOT EXISTS USUARIOS (
    UsuarioId INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(150) NOT NULL UNIQUE,
    Senha VARCHAR(255) NOT NULL
);

-- Tabela de classes
CREATE TABLE IF NOT EXISTS CLASSES (
    ClasseId INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT
);

-- Tabela de personagens
-- Um usuário pode possuir vários personagens.
-- Cada personagem pertence a uma única classe.
CREATE TABLE IF NOT EXISTS PERSONAGENS (
    PersonagemId INT AUTO_INCREMENT PRIMARY KEY,
    NomePersonagem VARCHAR(100) NOT NULL,
    UsuarioId INT NOT NULL,
    ClasseId INT NOT NULL,
    CONSTRAINT FK_PERSONAGENS_USUARIOS
        FOREIGN KEY (UsuarioId) REFERENCES USUARIOS (UsuarioId)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FK_PERSONAGENS_CLASSES
        FOREIGN KEY (ClasseId) REFERENCES CLASSES (ClasseId)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Tabela de habilidades
CREATE TABLE IF NOT EXISTS HABILIDADES (
    HabilidadeId INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

-- Tabela associativa para o relacionamento N:N entre classes e habilidades.
-- A chave primária composta impede duplicidade da associação.
CREATE TABLE IF NOT EXISTS CLASSES_HABILIDADES (
    ClasseId INT NOT NULL,
    HabilidadeId INT NOT NULL,
    PRIMARY KEY (ClasseId, HabilidadeId),
    CONSTRAINT FK_CLASSES_HABILIDADES_CLASSES
        FOREIGN KEY (ClasseId) REFERENCES CLASSES (ClasseId)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FK_CLASSES_HABILIDADES_HABILIDADES
        FOREIGN KEY (HabilidadeId) REFERENCES HABILIDADES (HabilidadeId)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Observação de segurança:
-- Armazene em Senha somente hashes seguros (ex.: Argon2id ou bcrypt),
-- nunca a senha em texto puro. A geração do hash deve ocorrer na aplicação.
