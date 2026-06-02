-- QUERY FUENTES WEB

INSERT INTO [RamedicasBI].[dbo].[rmd_objfuente_web]
SELECT 
FueCod AS 'fuecod',
UPPER(FueNom) AS 'fuenom',
FueEst AS 'fueest',
FueTipTra AS 'fuetiptra',
FueCodFic AS 'fuecodfic',
'' AS 'moddoc'
FROM Fuentes

-- CREATE TABLE FUENTES WEB

USE RamedicasBI;
CREATE TABLE rmd_objfuente_web (
    fuecod INT NOT NULL,
    fuenom VARCHAR(80) NOT NULL,
    fueest VARCHAR(3) NULL,
    fuetiptra VARCHAR(3) NULL,
    fuecodfic VARCHAR(7) NULL,
    moddoc VARCHAR(30) NULL
CONSTRAINT [pk_rmd_objfuente_web] PRIMARY KEY CLUSTERED 
(
    [fuecod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]