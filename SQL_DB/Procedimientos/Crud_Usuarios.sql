-- crud de Usuario
-- opciones de insert 
-- cambiar de estado 
-- update 
-- get habitats

use proyectozoologico;

-- --------------------------------------------------------------------
-- insertar nuevo Usuario 
delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stp_saveUsuarios`(
IN $Cedula int(11),
in $Nombre varchar(50),
in $Puesto varchar(45),
in $Telefono text,
in $estado varchar(15)
)
begin 

    IF NOT EXISTS (SELECT Cedula FROM usuarios WHERE Cedula = $Cedula) THEN
		
        INSERT INTO usuarios (Cedula, Nombre, Puesto, Telefono, Estado)
			VALUES ($Cedula, $Nombre, $Puesto, $Telefono, $Estado);
        
    END IF;
    
end$$
delimiter ;


-- cambiar el estado del Usuario 
delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stp_cambiarEstaUsuario`(
in $idUsuario int(11),
out $operacion boolean
)
begin 
 
 DECLARE estadoActual varchar(15);

-- Verificamos si el registro exite para comenzar a operar 
		IF EXISTS (SELECT Cedula FROM usuarios WHERE Cedula = $idUsuario) THEN
			
            -- Revisamos el estado actual y se lo lanzamos a la variable 
			SET estadoActual = (SELECT Estado FROM usuarios WHERE Cedula = $idUsuario);
            
            -- Cambiamos el estado
            IF (estadoActual = 'Activo') THEN
            
				SET estadoActual = 'Inactivo';
                
            ELSE
            
				SET estadoActual = 'Activo';
                
            END IF;
			-- se firma en piedra el cambio del dato 
            UPDATE usuarios SET Estado = estadoActual WHERE Cedula = $idUsuario;
   		   SET $operacion = 1;
            
		ELSE
        
        	SET $operacion = 0;
		END IF;


end $$
delimiter ;


-- obtener un registro de un Usuario  para modificar 
delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stp_obtenerUsuario`(
in $Cedula int(11)
)
begin 
 IF EXISTS (SELECT Cedula FROM usuarios WHERE Cedula = $Cedula) THEN
 
         select Cedula,Nombre,Puesto,Telefono,Estado from usuarios where Cedula =$Cedula;
         
 END IF;

end$$
delimiter ;


-- modificar un Usuario
delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stp_modificarUsuario`(
IN $Cedula int(11),
in $Nombre varchar(50),
in $Puesto varchar(45),
in $Telefono text,
in $estado varchar(15)
)
begin 

 IF EXISTS (SELECT Cedula FROM usuarios WHERE Cedula = $Cedula) THEN
 
     UPDATE usuarios SET
                           Nombre  =   $Nombre  ,
						   Puesto =   $Puesto,
						   Telefono      = $Telefono,
						   estado         =   $estado 
					
	 WHERE Cedula  = $Cedula ;
         
         
 END IF;

end$$
delimiter ;

































































