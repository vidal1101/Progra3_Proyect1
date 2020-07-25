
-- Mostrar las tablas de la base de datos 



use proyectozoologico;


delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stp_mostrarTablas`(
IN  $tabla   VARCHAR(50)
)
BEGIN
-- Solo para tener valores por defecto
-- 	SET $mensaje = 'Tabla encontrada.';
    
	CASE $tabla 
		
		WHEN 'habitats' THEN 
			SElECT * FROM `habitats`;
        
        -- inner join 
        WHEN 'especies' THEN
        
			   SELECT especies.idEspecies as Num_Especie, habitats.NomHabitat as Habitat,
              especies.nomEspecie as Especie , especies.indiceVulnerabilidad as Indice_Vulnerabilidad 
              FROM especies INNER JOIN habitats ON especies.NumHabitat=habitats.NumHabitat 
              order by especies.idEspecies, especies.nomEspecie ;
            

        WHEN 'usuarios' THEN 
			SELECT  * FROM `usuarios`;
        
-- ineer join
        WHEN 'itinerarios' THEN 
        
			select it.Codigo , hab.NomHabitat as Habittats, it.Duracion , it.Longitud , it.NumMaximo
            from  itinerarios as it inner join habitats  as hab on it.NumHabitat= hab.NumHabitat
            order by it.Codigo;
            
		-- inner join 
        WHEN 'visitas' THEN
			select * from visitas;
            
            
       WHEN 'animales' THEN          
             SELECT a.idAnimales, h.NomHabitat , e.nomEspecie, a.NomComun, a.NomCientifico, a.Descripcion, a.Imagen
             FROM  animales as a inner join especies as e on e.idEspecies = a.idEspecie 
             inner join habitats as h on h.NumHabitat = e.NumHabitat
             WHERE a.idEspecie = e.idEspecies and e.NumHabitat = h.NumHabitat
             group by a.idAnimales;
		
    END CASE;
END$$
delimiter ;

