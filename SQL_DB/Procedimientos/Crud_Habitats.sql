-- crud de habitats 
-- opciones de insert 
-- cambiar de estado 
-- update 
-- get habitats

use proyectozoologico;

-- --------------------------------------------------------------------
-- insertar nuevo habitats 
delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stp_saveHabitats`(
IN $nombrehabi varchar(50),
in $clima varchar(50),
in $vegetacion varchar(50),
in $estado varchar(15)
)
begin 

    insert into habitats 
    (NomHabitat,Clima,Vegetacion,EstadoHabitat)
    values($nombrehabi,$clima,$vegetacion,$estado);
    
end$$
delimiter ;


-- cambiar el estado de los habitats
delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stp_cambiarEstaHabitats`(
in $idhab int(11),
out $operacion boolean
)
begin 
 
 DECLARE estadoActual varchar(15);

-- Verificamos si el registro exite para comenzar a operar 
		IF EXISTS (SELECT NumHabitat FROM habitats WHERE NumHabitat = $idhab) THEN
			
            -- Revisamos el estado actual y se lo lanzamos a la variable 
			SET estadoActual = (SELECT EstadoHabitat FROM habitats WHERE NumHabitat = $idhab);
            
            -- Cambiamos el estado
            IF (estadoActual = 'Activo') THEN
            
				SET estadoActual = 'Inactivo';
                
            ELSE
            
				SET estadoActual = 'Activo';
                
            END IF;
			-- se firma en piedra el cambio del dato 
            UPDATE habitats SET EstadoHabitat = estadoActual WHERE NumHabitat = $idhab;
   		   SET $operacion = 1;
            
		ELSE
        
        	SET $operacion = 0;
		END IF;


end $$
delimiter ;


-- obtener un registro de la habitats para modificar 
delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stp_obtenerHabitats`(
in $idhabitats int(11)
)
begin 
 IF EXISTS (SELECT NumHabitat FROM habitats WHERE NumHabitat = $idhabitats) THEN
 
         select NumHabitat,NomHabitat,Clima,Vegetacion,EstadoHabitat from habitats where NumHabitat =$idhabitats;
         
 END IF;

end$$
delimiter ;


-- modificar un habitats 
delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stp_modificarHabitats`(
in $idhabitats int(11),
in $nombrehabi varchar(50),
in $clima varchar(50),
in $vegetacion varchar(50),
in $estado varchar(15)
)
begin 

 IF EXISTS (SELECT NumHabitat FROM habitats WHERE NumHabitat = $idhabitats) THEN
 
     UPDATE habitats SET
                           NomHabitat  =   $nombrehabi  ,
						   Clima =   $clima,
						   Vegetacion      = $vegetacion,
						   EstadoHabitat         =   $estado 
					
	 WHERE NumHabitat  = $idhabitats ;
         
         
 END IF;

end$$
delimiter ;

































































