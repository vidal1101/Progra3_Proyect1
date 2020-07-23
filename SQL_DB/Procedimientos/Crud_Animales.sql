-- crud de Animales
-- opciones de insert 
-- update 
-- get habitats

use proyectozoologico;

-- --------------------------------------------------------------------
-- insertar nuevo Animal  
delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stp_saveAnimal`(
IN $idEspecie int(11),
IN $NomComun text,
in $NomCientifico text,
in $Descripcion text,
in $Imagen mediumblob
)
begin 

    insert into animales 
    (idEspecie,NomComun,NomCientifico,Descripcion, Imagen)
    values($idEspecie,$NomComun,$NomCientifico,$Descripcion,$Imagen);
    
end$$
delimiter ;




-- obtener un animal para modificar 
delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stp_obtenerAnimal`(
in $idAnimales int(11)
)
begin 
 IF EXISTS (SELECT idAnimales FROM animales WHERE idAnimales = $idAnimales) THEN
 
 select  * from animales where idAnimales = $idAnimales;
         
 END IF;

end$$
delimiter ;


-- modificar un Animal
delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stp_modificarAnimal`(
IN $idAnimales int(11),
IN $idEspecie int(11),
IN $NomComun text,
in $NomCientifico text,
in $Descripcion text,
in $Imagen mediumblob
)
begin 

 IF EXISTS (SELECT idAnimales FROM animales WHERE idAnimales = $idAnimales) THEN
 
     UPDATE animales SET
                           idEspecie  =   $idEspecie  ,
						   NomComun =   $NomComun,
						   NomCientifico      = $NomCientifico,
						   Descripcion         =   $Descripcion,
                           Imagen          =  $Imagen
					
	 WHERE idAnimales  = $idAnimales ;
         
         
 END IF;

end$$
delimiter ;


