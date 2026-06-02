USE RamedicasBI;

CREATE TABLE rmd_pryconprovcom_man (
    ran INT NULL ,
    nomcli VARCHAR(150) NULL,
    nit VARCHAR(20) NOT NULL,
    nitlim INT NULL,
    numart INT NULL,
    razsoc VARCHAR(100) NULL,
    plazo INT NULL,
    dctopp DECIMAL NULL,
    dctoinf DECIMAL NULL,
    dctolog DECIMAL NULL,
    plazomta INT NULL,
    dctoppmta DECIMAL NULL,
    dctoinfmta DECIMAL NULL,
    dctologmta DECIMAL NULL,
    comaniomta NUMERIC(18, 2),
    codneg INT
 CONSTRAINT [pk_rmd_pryconprovcom_man] PRIMARY KEY CLUSTERED 
(
    [nit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

USE RamedicasBI;
DROP TABLE  rmd_pryconprovcom_man