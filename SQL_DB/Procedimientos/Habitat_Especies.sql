use proyectozoologico;

-- ver especies de un habitat
delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stp_verEspecies`(
IN $numHabitat int(11)
)
begin 
SELECT h.NomHabitat ,e.idEspecies, e.nomEspecie, e.indiceVulnerabilidad

FROM  especies as e inner join habitats as h on h.NumHabitat = e.NumHabitat

WHERE e.NumHabitat = $numHabitat

group by h.NomHabitat, e.idEspecies;

    
end$$
delimiter ;
