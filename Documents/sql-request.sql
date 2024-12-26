-- 1. Donner les produits dont le prix dépasse 150
SELECT * 
FROM PRODUIT 
WHERE prix > 150;

-- 2. Le nombre de produits dont le prix dépasse 150
SELECT COUNT(*) AS nombre_produits 
FROM PRODUIT 
WHERE prix > 150;

-- 3. Donner les produits dont le prix est compris entre 50 et 150
SELECT * 
FROM PRODUIT 
WHERE prix BETWEEN 50 AND 150;

-- 4. Chercher le nombre de produits par tranche de prix
SELECT 
    CASE 
        WHEN prix BETWEEN 35 AND 45 THEN '[35-45]'
        WHEN prix BETWEEN 46 AND 60 THEN '[46-60]'
        WHEN prix BETWEEN 61 AND 85 THEN '[61-85]'
        WHEN prix BETWEEN 86 AND 100 THEN '[86-100]'
        WHEN prix BETWEEN 101 AND 200 THEN '[101-200]'
        WHEN prix BETWEEN 201 AND 300 THEN '[201-300]'
        ELSE 'autre'
    END AS tranche_prix,
    COUNT(*) AS nombre_produits
FROM PRODUIT
GROUP BY tranche_prix;

-- 5. Donner les produits de la catégorie 1
SELECT * 
FROM PRODUIT 
WHERE idcat = 1;

-- 6. Donner le nombre de commandes par mois en 2020
SELECT MONTH(jour) AS mois, COUNT(*) AS nombre_commandes
FROM COMMANDE
WHERE YEAR(jour) = 2020
GROUP BY MONTH(jour);

-- 7. Donner le nombre de commandes par semaine au mois de janvier 2020
SELECT WEEK(jour) AS semaine, COUNT(*) AS nombre_commandes
FROM COMMANDE
WHERE YEAR(jour) = 2020 AND MONTH(jour) = 1
GROUP BY WEEK(jour);

-- 8. Donner le nombre de commandes par an
SELECT YEAR(jour) AS annee, COUNT(*) AS nombre_commandes
FROM COMMANDE
GROUP BY YEAR(jour);

-- 9. Donner le fournisseur dont le produit est le moins vendu en 2020
SELECT F.nomf, MIN(SUM(LC.qte)) AS total_vendu
FROM FOURNISSEUR F
JOIN PRODUIT P ON F.idf = P.idf
JOIN LIGNECOMMANDE LC ON P.idp = LC.idp
JOIN COMMANDE C ON LC.ncom = C.ncom
WHERE YEAR(C.jour) = 2020
GROUP BY F.idf
ORDER BY total_vendu ASC
LIMIT 1; -- affiche seulement une ligne. 

-- 10. Donner les trois produits les plus livrés en 2021
SELECT P.prd, SUM(L.qtel) AS total_livree
FROM PRODUIT P
JOIN LIVRER L ON P.idp = L.idp
WHERE YEAR(L.jour) = 2021
GROUP BY P.idp
ORDER BY total_livree DESC
LIMIT 3;

-- 11. Donner les cinq produits les moins livrés en 2021
SELECT P.prd, SUM(L.qtel) AS total_livree
FROM PRODUIT P
JOIN LIVRER L ON P.idp = L.idp
WHERE YEAR(L.jour) = 2021
GROUP BY P.idp
ORDER BY total_livree ASC
LIMIT 5;

-- 12. Pourcentage de produits vendus au deuxième trimestre 2020
SELECT COUNT(*) * 100.0 / (SELECT COUNT(*) FROM LIGNECOMMANDE WHERE YEAR(C.jour) = 2020) AS pourcentage
FROM LIGNECOMMANDE LC
JOIN COMMANDE C ON LC.ncom = C.ncom
WHERE YEAR(C.jour) = 2020 AND MONTH(C.jour) BETWEEN 4 AND 6;

-- 13. Liste des dix premiers clients ayant des numéros NigerTelecoms
SELECT * 
FROM CLIENT
WHERE tel LIKE '+227%'
ORDER BY idc
LIMIT 10;

-- 14. Nombre de produits par catégorie (trié par ordre croissant du nom de catégorie)
SELECT C.categorie, COUNT(P.idp) AS nombre_produits
FROM CATEGORIE C
LEFT JOIN PRODUIT P ON C.idcat = P.idcat
GROUP BY C.categorie
ORDER BY C.categorie ASC;

-- 15. Commandes dont le montant total dépasse 1500 au mois de janvier 2007
SELECT C.ncom, SUM(LC.qte * P.prix) AS total
FROM COMMANDE C
JOIN LIGNECOMMANDE LC ON C.ncom = LC.ncom
JOIN PRODUIT P ON LC.idp = P.idp
WHERE YEAR(C.jour) = 2007 AND MONTH(C.jour) = 1
GROUP BY C.ncom
HAVING total > 1500;

-- 16. Chiffre d'affaires réalisé au dernier trimestre 2016
SELECT SUM(LC.qte * P.prix) AS chiffre_affaires
FROM LIGNECOMMANDE LC
JOIN PRODUIT P ON LC.idp = P.idp
JOIN COMMANDE C ON LC.ncom = C.ncom
WHERE YEAR(C.jour) = 2016 AND MONTH(C.jour) BETWEEN 10 AND 12;

-- 17. Les 3 produits les moins vendus au dernier trimestre 2016
SELECT P.prd, SUM(LC.qte) AS total_vendu
FROM PRODUIT P
JOIN LIGNECOMMANDE LC ON P.idp = LC.idp
JOIN COMMANDE C ON LC.ncom = C.ncom
WHERE YEAR(C.jour) = 2016 AND MONTH(C.jour) BETWEEN 10 AND 12
GROUP BY P.idp
ORDER BY total_vendu ASC
LIMIT 3;
