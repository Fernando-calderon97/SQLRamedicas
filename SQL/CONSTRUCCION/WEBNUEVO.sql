SELECT 
F.FacDocCom,
N.NitIde,
CAST(F.FacFec AS DATE) AS 'Fecha',
F.FacNro,
F.FacEst,
F.FacTipCod,
K.TotalFacturaBruto,
K.IVA,
K.TotalFacturaNeta,
(
	SELECT TOP 1
	CAST(F01.FacValDocCom AS NUMERIC(18,2)) AS 'Doc'
	FROM Factura F01
	WHERE F01.FacDocCom = F.FacDocCom AND F01.FacTipTra = 'REV'
) AS 'ValorDocumento',
(
	(
		SELECT
		CAST(COALESCE(SUM(K1.KarValtotMenDes),0) AS NUMERIC(18,2)) AS 'CM'
		FROM Kardex K1
		WHERE K1.FacSec IN (SELECT F1.FacSec FROM Factura F1 WHERE F1.FacSecDev IN (SELECT F0.FacSec FROM Factura F0 WHERE F.FacDocCom = F0.FacDocCom AND F0.FacTipTra = 'REV'))
	) +
	(
		SELECT
		CAST(COALESCE(SUM(K3.KarvaltotMenDes),0) AS NUMERIC(18,2)) AS 'CM'
		FROM Kardex K3
		WHERE K3.FacSec IN (SELECT F2.FacSec FROM Factura F2 WHERE F2.FacEst = 'A' AND F2.FacSecDev IN (SELECT F3.FacSec FROM Factura F3 WHERE F3.FacEst = 'A' AND F3.FacEscPac = F.FacNro))
	) -
	(
		SELECT
		CAST(COALESCE(SUM(K4.karvaltotMenDes),0) AS NUMERIC(18,2)) AS 'CM'
		FROM Kardex K4
		WHERE K4.FacSec IN (SELECT F4.FacSec FROM Factura F4 WHERE F4.FacSecDev IN (SELECT F5.FacSec FROM Factura F5 WHERE F5.FacSecDev IN (SELECT F6.FacSec FROM Factura F6 WHERE F6.FacEscPac = F.FacNro)))
	)
) AS 'CM'
FROM Factura F
LEFT JOIN Nit N ON F.FacNitSec = N.NitSec
LEFT JOIN (
	SELECT
	FacSec,
	CAST(SUM(karvaltotMenDes) AS NUMERIC(18,2)) AS 'TotalFacturaBruto',
	CAST(SUM(KarArtIva) AS NUMERIC(18,2)) AS 'IVA',
	CAST(SUM(karvaltotMenDes) + SUM(KarArtIva) AS NUMERIC(18,2)) AS 'TotalFacturaNeta'
	FROM Kardex
	GROUP BY FacSec
) K ON F.FacSec = K.FacSec
WHERE F.FacEst = 'A' AND F.FacTipTra = 'FDV' AND F.FacFec BETWEEN '20260301' AND '20260331' AND /*F.FacTipCod = 'FVA' AND*/ /*N.NitIde = '830003564' AND*/ F.FacNro IN ('FEV321208')



select
F.FacFec,
F.FacSecUnique,
F.FacSec,
F.FacSecCop,
F.FacSecDev,
F.Facpaccedsec,
F.facdoccom,
F.faccomsec,
F.facnro,
F.FacEscPac,
K.Karvaltotmendes,
*
from factura F
LEFT JOIN Kardex K ON F.FacSec = K.FacSec
where facnro in ('FEV291023', 'RL22500035763') OR F.FacSecDev ='20735496'
 
select
facdoccom,
facnro,
facest,
*
from factura
where Facpaccedsec = '2695852'/*'2700616'*/ '2700019'

select
FacEst,
FacValDocCom,
FacFec
FacSecUnique,
FacSec,
FacSecCop,
FacSecDev,
Facpaccedsec,
facdoccom,
faccomsec,
facnro,
FacEscPac,
*
from factura
where Facdoccom = '434483194'