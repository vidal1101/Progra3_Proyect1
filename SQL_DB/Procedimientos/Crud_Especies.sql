-- crud de especies
-- opciones de insert 
-- cambiar de estado 
-- update 
-- get habitats

use proyectozoologico;

-- --------------------------------------------------------------------
-- insertar nuevo habitats 
delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stp_saveEspecies`(
IN $NumHabitat int(11),
in $nomEspecie varchar(50),
in $indiceVulnerabilidad double
)
begin 

    insert into especies 
    (NumHabitat,nomEspecie,indiceVulnerabilidad)
    values($NumHabitat,$nomEspecie,$indiceVulnerabilidad);
    
end$$
delimiter ;


-- obtener un registro de la habitats para modificar 
delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stp_obtenerEspecie`(
in $idEspecies int(11)
)
begin 
 IF EXISTS (SELECT idEspecies FROM habitats WHERE idEspecies = $idEspecies) THEN
 
         select idEspecies,NumHabitat,nomEspecie,indiceVulnerabilidad from habitats where idEspecies =$idEspecies;
         
 END IF;

end$$
delimiter ;


-- modificar un habitats 
delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stp_modificarEspecies`(
in $idEspecies int(11),
in $NumHabitat int(11),
in $nomEspecie varchar(50),
in $indiceVulnerabilidad double
)
begin 

 IF EXISTS (SELECT idEspecies FROM especies WHERE idEspecies = $idEspecies) THEN
 
     UPDATE especies SET
                           NumHabitat  =   $NumHabitat  ,
						   nomEspecie =   $nomEspecie,
						   indiceVulnerabilidad      = $indiceVulnerabilidad
					
	 WHERE idEspecies  = $idEspecies ;
         
         
 END IF;

end$$
delimiter ;

