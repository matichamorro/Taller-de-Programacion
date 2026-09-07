program Adicionales2;

const fin = 'MMM';

type
	fabricacion = 2015..2024;
	auto = record
	  patente: string;
		fabr: fabricacion;
		marca: string;
		color: string;
		modelo: string;
		end;
			
	arboluno = ^nodosuno;
	nodosuno = record
		dato: auto;
		HI: arboluno;
		HD: arboluno;
		end;
	
	reg_lista_nodosdos = record
		patente: string;
		color: string;
		end;
	lista = ^nodos_lista;
	nodos_lista = record
		dato: reg_lista_nodosdos;
		sig: lista;
		end;
	reg_nodosdos = record
		marca: string;
		autos: lista;
		end;
	arboldos = ^nodosdos;
	nodosdos = record
		dato: reg_nodosdos;
		HI: arboldos;
		HD: arboldos;
	end;

	lista_vector = ^nodos_lista_vector;
	nodos_lista_vector = record
		dato: auto;
		sig: lista_vector;
		end;
	vector = array[fabricacion] of lista_vector;

procedure agregarArbol(var a1:arboluno; var a2:arboldos);

	{procedure leerAuto(var a:auto);
	var
		marcas: array [0..49] of string= ('Toyota', 'Ford', 'Fiat', 'Peugeot', 'Nissan', 'Hyundai', 'Renault', 'Volkswagen', 'Citroen', 'Honda','Toyota', 'Ford', 'Fiat', 'Peugeot', 'Nissan', 'Hyundai', 'Renault', 'Volkswagen', 'Citroen', 'Honda','Toyota', 'Ford', 'Fiat', 'Peugeot', 'Nissan', 'Hyundai', 'Renault', 'Volkswagen', 'Citroen', 'Honda','Toyota', 'Ford', 'Fiat', 'Peugeot', 'Nissan', 'Hyundai', 'Renault', 'Volkswagen', 'Citroen', 'Honda','Toyota', 'Ford', 'Fiat', 'Peugeot', 'Nissan', 'Hyundai', 'Renault', 'Volkswagen', 'Citroen', 'MMM');
		colores: array [0..9] of string= ('Gris', 'Negro', 'Plateado', 'Blanco', 'Rojo', 'Azul', 'Beige', 'Gris Oscuro', 'Amarillo', 'Dorado'); 
	begin
		a.marca := marcas[random(50)];
		if (a.marca <> fin) then
		begin
			a.patente := random(1000);
			a.fabr := 2015 + random(10);
			a.color := colores[random(10)];
			a.modelo := random(10)*100;
		end;
	end;}
	
	procedure leerAuto(var a:auto);
	begin
		writeln('Ingresar marca:');
		readln(a.marca); 
		if (a.marca <> fin) then
		begin
			writeln('Ingresar patente:');
			readln(a.patente);
			writeln('Ingresar anio de fabricacion:');
			readln(a.fabr);
			writeln('Ingresar color:');
			readln(a.color);
			writeln('Ingresar modelo:');
			readln(a.modelo);
		end;
	end;
	
	procedure agregarArbolUno(var a:arboluno; elem:auto);
	begin
		if (a = nil) then begin
			writeln('Generando nodo nuevo en arbol uno');
			new(a);
			a^.dato := elem;
			a^.HI := nil;
			a^.HD := nil;
			end
		else if (elem.patente < a^.dato.patente) then
			agregarArbolUno(a^.HI,elem)
		else if (elem.patente > a^.dato.patente) then
			agregarArbolUno(a^.HD,elem)
		else
			writeln('Patente repetida. No se ejecutaria nada.');
		// No hay un else para que no se repitan las patentes
	end;
	
	procedure agregarAdelante(var L:lista; elem:auto);
	var	
		nue:lista;
	begin
		writeln('Generando nodo nuevo en lista de arbol dos');
		new(nue);
		writeln('Pegando el contenido en el nodo nuevo en lista de arbol dos');
		nue^.dato.patente := elem.patente;
    nue^.dato.color := elem.color;	
		nue^.sig := L;
		L := nue;
	end;
	
	procedure agregarArbolDos(var a:arboldos; elem:auto);
	begin
		if (a = nil) then begin
		  writeln('Generando nodo nuevo en arbol dos');
			new(a);
			a^.dato.marca := elem.marca;
			a^.dato.autos := nil;
			agregarAdelante(a^.dato.autos,elem);
			a^.HI := nil;
			a^.HD := nil;
			end
		else if (elem.marca < a^.dato.marca) then
			agregarArbolDos(a^.HI,elem)
		else if (elem.marca > a^.dato.marca) then
			agregarArbolDos(a^.HD,elem)
		else
			agregarAdelante(a^.dato.autos,elem);
	end;

var
	a:auto;
begin
	a1 := nil;
	a2 := nil;
	leerAuto(a);
	while (a.marca <> fin) do begin
		agregarArbolUno(a1,a);
		agregarArbolDos(a2,a);
		leerAuto(a);
	end;
end;

procedure imprimirArbol(a:arboluno);
begin
	if (a <> nil) then 
	begin
		imprimirArbol(a^.HI);
		writeln('La patente es: ',a^.dato.patente);
		writeln('El anio de fabricacion es: ',a^.dato.fabr);
		writeln('La marca es: ',a^.dato.marca);
		writeln('El color es: ',a^.dato.color);
		writeln('El modelo es: ',a^.dato.modelo);
		imprimirArbol(a^.HD);
	end;
end;

procedure imprimirArbolDos(a:arboldos);
var aux: lista;
begin
	if (a <> nil) then 
	begin
		imprimirArbolDos(a^.HI);
		writeln;
		writeln('La marca es: ',a^.dato.marca);
		writeln('Los autos son: ');
		aux := a^.dato.autos;
		while(aux <> nil) do 
		begin
			write('Patente: ',aux^.dato.patente,'. Color: ',aux^.dato.color,' /// ');
			aux := aux^.sig;
		end;
		writeln;
		imprimirArbolDos(a^.HD);
	end;
end;

function contarAutos(a:arboluno; marca:string):integer;
begin
		if (a = nil) then contarAutos := 0
		else if (a^.dato.marca = marca) then contarAutos := 1 + contarAutos(a^.HI,marca) + contarAutos(a^.HD,marca)
		else contarAutos := 0 + contarAutos(a^.HI,marca) + contarAutos(a^.HD,marca);
end;

function contarAutosDos(a:arboldos; marca:string): integer;
		
		function contarAutosEnLista(l:lista): integer;
		begin
				if (l = nil) then contarAutosEnLista := 0
				else contarAutosEnLista :=  1 + contarAutosEnLista(l^.sig)
		end;	
begin
		if (a = nil) then
			contarAutosDos := 0
		else if (a^.dato.marca < marca) then
			contarAutosDos := contarAutosDos(a^.HD,marca)
		else if (a^.dato.marca > marca) then
			contarAutosDos := contarAutosDos(a^.HI,marca)	
		else
			contarAutosDos := contarAutosEnLista(a^.dato.autos);
end;

procedure generarListas(var v:vector; a:arboluno);

	procedure agregarAdelante(var L:lista_vector; elem:auto);
	var nue: lista_vector;
	begin
		new(nue);
		nue^.dato := elem;
		nue^.sig := L;
		L := nue;
	end;
	
	procedure recorrerArbol(var v:vector; a:arboluno);
	begin
		if (a <> nil) then begin
			recorrerArbol(v,a^.HI);
			agregarAdelante(v[a^.dato.fabr],a^.dato);
			recorrerArbol(v,a^.HD);
		end;
	end;
	
	// comprobacion de las listas
	procedure recorrerListas(v:vector);
	var i,j:integer; L: lista_vector;
	begin
		for i := 2015 to 2024 do begin
			writeln(' //////// LISTA ',i,' ////////');
			L := v[i];
			j := 1;
			while (L <> nil) do begin
				writeln;
				writeln(' //// Nodo ',j,': //// ');
				writeln('Patente: ',L^.dato.patente );
				writeln('Marca: ',L^.dato.marca );
				writeln('Fabricacion: ',L^.dato.fabr );
				writeln('Color: ',L^.dato.color );
				writeln('Modelo: ',L^.dato.modelo );
				L := L^.sig;
				j := j+1;
			end;
			writeln;
			writeln;
		end;
	end;		
		
var i: integer;
begin
	for i := 2015 to 2024 do
	v[i] := nil;
	recorrerArbol(v,a);
	recorrerListas(v);
end;


procedure buscarPatenteUno (a:arboluno; patente:string; var modelo:string);
begin
	if (modelo = 'No existe') then 
		if (a <> nil) then begin
			buscarPatenteUno(a^.HI,patente,modelo);
			if (patente = a^.dato.patente) then modelo := a^.dato.modelo;
			buscarPatenteUno(a^.HD,patente,modelo);
		end;
end;

procedure buscarPatenteDos(a:arboldos; patente:string; var color:string);

	procedure buscarEnLaLista (l:lista; patente:string; var color:string);
	begin
		if (l <> nil) then begin
			if (l^.dato.patente = patente) then color := l^.dato.color
			else buscarEnLaLista(l^.sig,patente,color);
		end;
	end;

var aux:lista;
begin
	if (color = 'No existe') then 
		if (a <> nil) then begin
			buscarPatenteDos(a^.HI,patente,color);
			aux := a^.dato.autos;
			buscarEnLaLista(aux,patente,color);
			buscarPatenteDos(a^.HD,patente,color);
		end;
end;


var
	a1:arboluno;
	a2:arboldos;
	marca, patente1, modelo, patente2, color: string;
	v: vector;
begin
	agregarArbol(a1,a2);
	
	if (a1 = nil) then writeln('Arbol 1 vacio.')
	else imprimirArbol(a1);
	if (a2 = nil) then writeln('Arbol 2 vacio.')
	else imprimirArbolDos(a2);
	
	writeln;
	writeln('Ingresar una marca para buscar cuantos autos posee: ');
	readln(marca);
	writeln('Hay ',contarAutos(a1,marca),' autos de la marca ',marca,'.');
	writeln('Hay ',contarAutosDos(a2,marca),' autos de la marca ',marca,'.');
	
	writeln;
	generarListas(v,a1);
	
	writeln;
	writeln('Ingresar una patente para buscar su modelo de auto: ');
	readln(patente1);
	modelo := 'No existe';
	buscarPatenteUno(a1, patente1,modelo);
	if (modelo <> 'No existe') then writeln('El modelo de esa patente es: ',modelo)
	else writeln('Esa patente no existe.');
	
	writeln;
	writeln('Ingresar una patente para buscar el color del auto: ');
	readln(patente2);
	color := 'No existe';
	buscarPatenteDos(a2, patente2,color);
	if (color <> 'No existe') then writeln('El color del auto con esa patente es: ',color )
	else writeln('Esa patente no existe.');
	
end.
