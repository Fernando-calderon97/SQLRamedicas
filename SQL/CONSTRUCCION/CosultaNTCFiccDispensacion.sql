SELECT
CAST(F.FacFec AS DATE) AS 'Fecha NTC',
F.FacNro AS 'NTC',
F.FacTipCod 'Tipo',
F.FacEst 'Estado',
FK.karvaltotMenDes 'Valor NTC',
F.FacCufe 'Cufe',
(
    SELECT
    F2.FacNro
    FROM Factura F2
    WHERE F2.FacSec = F.FacSecDev
) AS 'Factura',
(
    SELECT
    CAST(F2.FacFec AS DATE)
    FROM Factura F2
    WHERE F2.FacSec = F.FacSecDev
) AS 'Factura Fecha'
FROM Factura F 
INNER JOIN FacturaKardex FK ON F.FacSec = FK.FacSec
WHERE F.FacTipCod = 'NTC' AND F.FacEst = 'A' AND F.FacFec BETWEEN '20260401' AND '20260430'


SELECT 
*
FROM Factura
WHERE FacNro IN ('NTC2604000029','FECA8')

SELECT 
FacUsuAnu,
FacAnuObs,
* FROM Factura WHERE FacNro ='FEV353432'