CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    UpdatedAt DATETIME2 DEFAULT GETDATE()
);

CREATE TABLE FoodGroups (
    FoodGroupId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(255)
);

CREATE TABLE Ingredients ( 
    IngredientId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    DefaultUnit NVARCHAR(20) NOT NULL, -- e.g., 'g', 'ml', 'pieces'
	FoodGroupId INT,
    Calories DECIMAL(6,2),
    Protein DECIMAL(6,2),
    Carbs DECIMAL(6,2),
    Fat DECIMAL(6,2),
    Fibre DECIMAL(6,2),
    Sugar DECIMAL(6,2),
    Sodium DECIMAL(6,2),
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (FoodGroupId) REFERENCES FoodGroups(FoodGroupId)
);

CREATE TABLE Units (
    UnitId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(20) NOT NULL UNIQUE,
    Category NVARCHAR(20) NOT NULL -- 'weight', 'volume', 'quantity'
);

CREATE TABLE UserIngredients (
    UserIngredientId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    IngredientId INT NOT NULL,
    Quantity DECIMAL(10,2) NOT NULL,
    Unit NVARCHAR(20) NOT NULL,
    ExpiryDate DATE,
    LastUpdated DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (IngredientId) REFERENCES Ingredients(IngredientId)
);

CREATE TABLE Recipes (
    RecipeId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL, -- Creator of the recipe
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    Instructions NVARCHAR(MAX) NOT NULL,
    PrepTime INT, -- in minutes
    CookTime INT, -- in minutes
    Servings INT,
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    UpdatedAt DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

CREATE TABLE RecipeIngredients (
    RecipeId INT NOT NULL,
    IngredientId INT NOT NULL,
    Quantity DECIMAL(10,2) NOT NULL,
    Unit NVARCHAR(20) NOT NULL,
    Notes NVARCHAR(255),
    PRIMARY KEY (RecipeId, IngredientId),
    FOREIGN KEY (RecipeId) REFERENCES Recipes(RecipeId),
    FOREIGN KEY (IngredientId) REFERENCES Ingredients(IngredientId)
);

CREATE INDEX IX_UserIngredients_UserId ON UserIngredients(UserId);
CREATE INDEX IX_UserIngredients_IngredientId ON UserIngredients(IngredientId);
CREATE INDEX IX_Recipes_UserId ON Recipes(UserId);
CREATE INDEX IX_RecipeIngredients_IngredientId ON RecipeIngredients(IngredientId);
CREATE INDEX IX_Ingredients_FoodGroup ON Ingredients(FoodGroupId);