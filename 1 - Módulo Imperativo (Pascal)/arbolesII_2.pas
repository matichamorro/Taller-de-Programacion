program arbolesII_2;

type rangoEdad = 12..100;
     cadena15 = string [15];
     socio = record
               numero: integer;
               nombre: cadena15;
               edad: rangoEdad;
             end;
     arbol = ^nodoArbol;
     nodoArbol = record
                    dato: socio;
                    HI: arbol;
                    HD: arbol;
                 end;
     
procedure GenerarArbol (var a: arbol);
{ Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente. }

  Procedure CargarSocio (var s: socio);
  var vNombres:array [0..9] of string= ('Ana', 'Jose', 'Luis', 'Ema', 'Ariel', 'Pedro', 'Lena', 'Lisa', 'Martin', 'Lola'); 
  begin
    s.numero:= random (51) * 100;
    If (s.numero <> 0)
    then begin
           s.nombre:= vNombres[random(10)];
           s.edad:= 12 + random (79);
         end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: socio);
  Begin
    if (a = nil) 
    then begin
           new(a);
           a^.dato:= elem; 
           a^.HI:= nil; 
           a^.HD:= nil;
         end
    else if (elem.numero < a^.dato.numero) 
         then InsertarElemento(a^.HI, elem)
         else InsertarElemento(a^.HD, elem); 
  End;

var unSocio: socio;  
Begin
 writeln;
 writeln ('----- Ingreso de socios y armado del arbol ----->');
 writeln;
 a:= nil;
 CargarSocio (unSocio);
 while (unSocio.numero <> 0)do
  begin
   InsertarElemento (a, unSocio);
   CargarSocio (unSocio);
  end;
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;

procedure InformarSociosOrdenCreciente (a: arbol);
{ Informar los datos de los socios en orden creciente. }
  
  procedure InformarDatosSociosOrdenCreciente (a: arbol);
  begin
    if (a <> nil) then begin 
		InformarDatosSociosOrdenCreciente (a^.HI);
		writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
		InformarDatosSociosOrdenCreciente (a^.HD);
	end;		
  end;

Begin
 writeln;
 writeln ('----- Socios en orden creciente por numero de socio ----->');
 writeln;
 InformarDatosSociosOrdenCreciente (a);
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;

procedure InformarSociosOrdenDecreciente (a: arbol);
{ Informar los datos de los socios en orden decreciente. }
  
  procedure InformarDatosSociosOrdenDecreciente (a: arbol);
  begin
    if (a <> nil) then begin 
		InformarDatosSociosOrdenDecreciente (a^.HD);
		writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
		InformarDatosSociosOrdenDecreciente (a^.HI);
	end;		
  end;

Begin
 writeln;
 writeln ('----- Socios en orden decreciente por numero de socio ----->');
 writeln;
 InformarDatosSociosOrdenDecreciente (a);
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;

procedure InformarNumeroSocioConMasEdad (a: arbol);
{ Informar el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

     procedure actualizarMaximo(var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
	begin
	  if (nuevoValor >= maxValor) then
	  begin
		maxValor := nuevoValor;
		maxElem := nuevoElem;
	  end;
	end;
	procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
	begin
	   if (a <> nil) then
	   begin
		  actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
		  numeroMasEdad(a^.hi, maxEdad,maxNum);
		  numeroMasEdad(a^.hd, maxEdad,maxNum);
	   end; 
	end;

var maxEdad, maxNum: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  writeln;
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1) 
  then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Numero de socio con mas edad: ', maxNum);
         writeln;
       end;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure AumentarEdadNumeroImpar (a: arbol);
{Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.}
  
  function AumentarEdad (a: arbol): integer;
  var resto: integer;
  begin
     if (a = nil) 
     then AumentarEdad:= 0
     else begin
            resto:= a^.dato.edad mod 2;
            if (resto = 1) then a^.dato.edad:= a^.dato.edad + 1;
            AumentarEdad:= resto + AumentarEdad (a^.HI) + AumentarEdad (a^.HD);
          end;  
  end;

begin
  writeln;
  writeln ('----- Cantidad de socios con edad aumentada ----->');
  writeln;
  writeln ('Cantidad: ', AumentarEdad (a));
  writeln;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure InformarExistenciaNombreSocio (a: arbol);

	function ExisteNombreSocio (a: arbol; nom:string): boolean;
	var encontro: boolean;
	begin
		if (a <> nil) then
		begin
			if (a^.dato.nombre = nom) 
			then ExisteNombreSocio := True
			else begin
			encontro := ExisteNombreSocio(a^.HI,nom);
			encontro := ExisteNombreSocio(a^.HD,nom);
			ExisteNombreSocio := encontro;
			end; 
		end
		else ExisteNombreSocio := False;
	end;
	
var nom:string;
begin
	writeln;
	writeln('Introduzca un nombre a buscar: ');
	writeln;
	readln(nom);
	writeln;
	if (ExisteNombreSocio(a,nom)) then writeln('El nombre ',nom,' esta en el arbol')
	else writeln('El nombre ',nom,' NO esta en el arbol');
	writeln;
	writeln ('//////////////////////////////////////////////////////////');
    writeln;
end;

function ContarSocios (a: arbol): integer;
begin
	if (a = nil) 
	then ContarSocios := 0
	else ContarSocios := 1 + ContarSocios(a^.HI) + ContarSocios(a^.HD); 
end;

procedure InformarCantidadSocios(a: arbol);
var total: integer;
begin
	total := ContarSocios(a);
	writeln;
	writeln('La cantidad total de socios es: ', total);
	writeln;
	writeln ('//////////////////////////////////////////////////////////');
	writeln;
end;

procedure InformarPromedioDeEdad(a: arbol);

	function SumarEdad (a: arbol): integer;
	begin
		if (a = nil) 
		then SumarEdad := 0
		else SumarEdad := a^.dato.edad + SumarEdad(a^.HI) + SumarEdad(a^.HD); 
	end;

var prom: real;
begin
	prom := SumarEdad(a) / ContarSocios(a);
	writeln;
	writeln('El promedio de edad de los socios es: ', prom:0:0);
	writeln;
	writeln ('//////////////////////////////////////////////////////////');
	writeln;
end;

procedure NumeroSocioMasGrande(a: arbol);

	function NumeroSocioMasGrandeRecursivo(a:arbol): integer;
	begin
		if (a <> nil) then
			if (a^.HD = nil) 
			then NumeroSocioMasGrandeRecursivo := a^.dato.numero
			else NumeroSocioMasGrandeRecursivo := NumeroSocioMasGrandeRecursivo(a^.HD)
		else NumeroSocioMasGrandeRecursivo := -1;
	end;
	
var max: integer;
begin
	max := NumeroSocioMasGrandeRecursivo(a);
	if (max <> -1) then writeln('El numero de socio mas grande es: ', max)
	else writeln('La lista esta vacia');
end;

procedure NumeroSocioMasChico(a: arbol);

	function NumeroSocioMasChicoRecursivo(a:arbol): integer;
	begin
		if (a <> nil) then
			if (a^.HI = nil) 
			then NumeroSocioMasChicoRecursivo := a^.dato.numero
			else NumeroSocioMasChicoRecursivo := NumeroSocioMasChicoRecursivo(a^.HI)
		else NumeroSocioMasChicoRecursivo := -1;
	end;
	
var min: integer;
begin
	min := NumeroSocioMasChicoRecursivo(a);
	if (min <> -1) then writeln('El numero de socio mas grande es: ', min)
	else writeln('La lista esta vacia');
end;

procedure ExisteNumSocio (a: arbol);

	function ExisteNumeroSocio (a: arbol;num: integer): boolean;
	begin
		if (a <> nil) then
		begin
			if (a^.dato.numero = num) then
				ExisteNumeroSocio := True
			else if (a^.dato.numero > num) then
				ExisteNumeroSocio := ExisteNumeroSocio(a^.HI,num)
			else ExisteNumeroSocio := ExisteNumeroSocio(a^.HD,num);
		end
		else ExisteNumeroSocio := False;
	end;

var num:integer;
begin
	writeln;
	writeln('/////// BUSCAR NUMERO DE SOCIO ///////');
	writeln;
	readln(num);
	writeln;
	if (ExisteNumeroSocio (a,num)) 
		then writeln('Existe un socio con el numero: ', num)
		else writeln('NO Existe un socio con el numero: ', num);
	writeln;
end;

function InformarSociosEnRango (a:arbol; min,max:integer):integer;
begin
	if (a = nil) then
		InformarSociosEnRango := 0
	else 
		if (a^.dato.numero <= max) and (a^.dato.numero >= min) then
			InformarSociosEnRango := InformarSociosEnRango(a^.HI,min,max) + InformarSociosEnRango(a^.HD,min,max) + 1
		else if (a^.dato.numero > max)
			then InformarSociosEnRango := InformarSociosEnRango(a^.HI,min,max)
		else InformarSociosEnRango := InformarSociosEnRango(a^.HD,min,max);
end;
	


var a: arbol; 
	min,max: integer;
Begin
  randomize;
  GenerarArbol (a);
  InformarSociosOrdenCreciente (a);
 {InformarSociosOrdenDecreciente (a);
  InformarNumeroSocioConMasEdad (a);
  AumentarEdadNumeroImpar (a);
  InformarExistenciaNombreSocio (a); 
  InformarCantidadSocios (a);
  InformarPromedioDeEdad (a); }
  NumeroSocioMasGrande (a);
  NumeroSocioMasChico (a);
  ExisteNumSocio (a);
  writeln('/////// INGRESAR UN NUMERO MINIMO Y UNO MAXIMO ///////');
  readln(min);
  readln(max);
  writeln('Hay ',InformarSociosEnRango(a,min,max),' socios entre los numeros ',min,' y ',max);
End.
