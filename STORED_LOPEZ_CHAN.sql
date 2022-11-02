/**************************************************************************************************
* David José de Jesús López Chan	       													      *
* Sistema: Nómina																	    		  *
* Objetivo: El primer S.P. debe permitir indicar a través de un parámetro el campo de             *
* ordenamiento de una tabla y mediante un segundo parámetro, si el orden es descendente           *
* o ascendente.			                                                                          *																			  
* ------------------------------------------------------------------------------------------------*
*																						          *
* Versión   Fecha        Usuario            Descripción									          *
* -------   ----------   ------------------ ------------------------------------------- ----------*
*  1.0      02/11/2022   David López	    Intento 1 para la creación de una SP                  *
*  																								  *
**************************************************************************************************/
USE nomina;

DROP PROCEDURE IF EXISTS `OrdernarTabla`;

DELIMITER //

CREATE DEFINER=`root`@`localhost` PROCEDURE `OrdernarTabla` (IN band INTEGER, IN columna CHAR(40), IN forma CHAR(40)) /*La SP recibirá la info de bandera, para que sepa como procede, nombre de la tabla y la forma (ASC o DESC)*/
BEGIN
	SET @forma = (forma); /*variable de la forma*/
	IF band = 1 THEN
		SET @tableorder = concat('ORDER BY ', columna);/* si la condición es para saber si se ordena o no*/
        
	ELSE
		SET @tableorder = '';
	END IF;
    
	    
    SET @clausula = concat('SELECT * FROM nomina.nomempleados ', @tableorder, @forma); /*realiza la selección de la tabla y la forma en la que se verá en la consulta*/
    
    PREPARE runSQL FROM @clausula;
    EXECUTE runSQL;
    DEALLOCATE PREPARE runSQL; 

END//
 
call OrdernarTabla("1","nom_formapago", " DESC"); /*A la SP hay que mandarle la bandera (0 o 1), el nomnre de la columna, y la manera en que regresará la info de la tabla*/

/**************************************************************************************************
* David José de Jesús López Chan	       													      *
* Sistema: Nómina																	    		  *
* Objetivo: El otro S.P. qué crearás, puede (1: insertar registros en una tabla de tu proyecto.   *
* 2: eliminar algún registro específico de una tabla de tu proyecto.)		                      *                                                   *																			  
* ------------------------------------------------------------------------------------------------*
*																						          *
* Versión   Fecha        Usuario            Descripción									          *
* -------   ----------   ------------------ ------------------------------------------- ----------*
*  1.0      02/11/2022   David López	    Insertar y Eliminar Registros                         *
*  																								  *
**************************************************************************************************/
USE nomina;

DROP PROCEDURE IF EXISTS `InsertarEliminar`;

DELIMITER //
/*La SP validará una bandera para saber si inserta o elimina, el ID para eliminar, en su defecto es '0', las variables de Ciudad, Estado y Pais*/
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarEliminar` (IN band INTEGER, IN ID INT, IN CIUDAD VARCHAR(40), IN ESTADO VARCHAR (40), IN PAIS VARCHAR (40))
BEGIN
	IF band = 1 THEN /*Bandera que valida si inserta o elimina*/
		INSERT INTO princiudades (PRIN_NOMBRECIUDAD, PRIN_NOMBREESTADO, PRIN_NOMBREPAIS)
		VALUES (CIUDAD, ESTADO, PAIS);
	ELSE
		DELETE FROM princiudades WHERE PRIN_IDCIUDAD = ID;
	END IF;
END//


CALL INSERTARELIMINAR ('1','0','CDMX', 'CDMX', 'MÉXICO') /*Las variables que se manda son: 1 para insertar, 0 para elimindar, el ID del registro, y las variables*/

