
CREATE VIEW vw_rmd_artcosultcom AS
SELECT 
    COALESCE(MF.ArtCod, MW.ArtCod) AS 'Codigo',
    COALESCE(
        (
            SELECT TOP 1 
            FC.preundact
            FROM [RamedicasBI_FICC].[dbo].[rmd_trafaccom_ficc] FC
            WHERE FC.artsec = MF.ArtSec 
            AND FC.preartcod = MF.ArtPreCodPrin
            ORDER BY FC.facfec DESC
        ),
        (
            SELECT TOP 1 
            FW.prepres
            FROM [RamedicasBI_WIN].[dbo].[rmd_tracomwin] FW
            WHERE FW.artcod = MW.artcod
            ORDER BY FW.facfec DESC
        ),
        0
    ) AS Costo
FROM [RamedicasBI_FICC].[dbo].[rmd_maearticulo_ficc] MF
FULL JOIN [RamedicasBI_WIN].[dbo].[rmd_maearticulowin] MW ON MF.ArtCod = MW.ArtCod
WHERE 
COALESCE(
    (
        SELECT TOP 1 FC.preundact
        FROM [RamedicasBI_FICC].[dbo].[rmd_trafaccom_ficc] FC
        WHERE FC.artsec = MF.ArtSec 
        AND FC.preartcod = MF.ArtPreCodPrin
        ORDER BY FC.facfec DESC
    ),
    (
        SELECT TOP 1 FW.prepres
        FROM [RamedicasBI_WIN].[dbo].[rmd_tracomwin] FW
        WHERE FW.artcod = MW.artcod
        ORDER BY FW.facfec DESC
    ),
    0
) <> 0

GO

SELECT TOP 100 * FROM [RamedicasBI_FICC].[dbo].[rmd_maearticulo_ficc] 
SELECT TOP 100 * FROM [RamedicasBI_WIN].[dbo].[rmd_maearticulowin]