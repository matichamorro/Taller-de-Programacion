program arbolesII_2;

const fin = -1;

type 
	venta = record
		cod: integer;
		prod: integer;
		cant: integer;
		precio: real;
		end;
	producto = record 
		cod: integer;
		canttotal: integer;
		montototal: real;
		end;
	maximo = record
		cod: integer;
		canttotal: integer;
		end;
	arbol = ^nodos;
	nodos = record
		dato: producto;
		HI : arbol;
		HD : arbol;
		end;

{Punto a)}
procedure crearArbol(var a:arbol);

	procedure leerVenta(var v:venta);
	begin
		v.cod := random(102) - 1;
		if (v.cod <> fin) then
		begin
			v.prod := 100 + random(101);
			v.cant := 20 + random(101);
			v.precio := 100 + random(501);
		end;
	end;

	procedure agregarArbol(var a:arbol; v:venta);
	begin
		if (a = nil) then begin
			new(a); 
			a^.dato.cod := v.prod;
			a^.dato.canttotal := v.cant;
			a^.dato.montototal := v.cant * v.precio;
			a^.HI := nil;
			a^.HD := nil;
			end
		else if (v.prod  < a^.dato.cod) then
			agregarArbol(a^.HI,v)
		else if (v.prod  > a^.dato.cod) then
			agregarArbol(a^.HD,v)
		else begin
			a^.dato.canttotal := a^.dato.canttotal + v.cant;
			a^.dato.montototal := a^.dato.montototal + v.cant * v.precio;
			end;
	end;

var v: venta;
begin
	a := nil;
	leerVenta(v);
	while (v.cod <> fin) do
	begin
		agregarArbol(a,v);
		leerVenta(v);
	end;
end;

{Punto b)}
procedure imprimirArbol(a:arbol);

	procedure imprimirNodo(p:producto);
	begin
		writeln('El codigo del producto es: ',p.cod);
		writeln('La cantidad total de unidades vendidas es: ',p.canttotal);
		writeln('El monto total de las ventas es: ',p.montototal:0:2);
		writeln;
	end;
	
begin
	if (a <> nil) then begin
		imprimirArbol(a^.HI);
		imprimirNodo(a^.dato);
		imprimirArbol(a^.HD);
		end;
end;
	
{Punto c)}
function buscarMaximo(a:arbol): integer;
		
	procedure buscarMaximoRecursivo(a:arbol; var max:maximo);
	begin
		if (a <> nil) then begin
			buscarMaximoRecursivo(a^.HI,max);
			if (a^.dato.canttotal > max.canttotal) then begin
				max.cod := a^.dato.cod;
				max.canttotal := a^.dato.canttotal;
				end;
			buscarMaximoRecursivo(a^.HD,max);
			end;
	end;

var
	max: maximo;
begin
	if (a = nil) then buscarMaximo := -1
	else buscarMaximoRecursivo(a,max);
	buscarMaximo := max.cod
end;

{Punto d)}
procedure contarMenoresQue(a:arbol);

	function MenoresQue(a:arbol; max:integer):integer;
	begin
		if (a = nil) then 
			MenoresQue := 0
		else if (a^.dato.cod > max) then
			MenoresQue := 0 + MenoresQue(a^.HI,max)
		else if (a^.dato.cod = max) then
			MenoresQue := 1 + MenoresQue(a^.HI,max)
		else if (a^.dato.cod < max) then
			MenoresQue := 1 + MenoresQue(a^.HI,max) + MenoresQue(a^.HD,max)
	end;

var max:integer;
begin
	writeln('Ingresa un numero para buscar codigos menores a ese: ');
	read(max);
	writeln;
	writeln('Hay ',MenoresQue(a,max),' codigos menores a ',max);
	writeln
end;

{Punto e)}
procedure contarCodigosEntre(a:arbol);

	function codigosEntre(a:arbol; min, max:integer):integer;
	begin
		if (a = nil) then 
			codigosEntre := 0
		else if (a^.dato.cod < max) and (a^.dato.cod > min) then
			codigosEntre := 1 + codigosEntre(a^.HI,min,max) + codigosEntre(a^.HD,min,max)		
		else if (a^.dato.cod >= max) then
			codigosEntre := 0 + codigosEntre(a^.HI,min,max)
		else 
			codigosEntre := 0 + codigosEntre(a^.HD,min,max)
	end;

var min,max:integer;
begin
	writeln('//////////////////////////////////////////////////////////////////////');
	writeln;
	writeln('Ingresa un numero minimo, para buscar codigos mayores a ese: ');
	read(min);
	writeln('Ahora ingresa un numero maximo, para buscar codigos menores a ese: ');
	read(max);
	writeln;
	writeln('Hay ',codigosEntre(a,min,max),' codigos mayores a ',min,' y menores a ',max);
	writeln
end;

{Programa Principal}
var
	a: arbol;
begin
	crearArbol(a);
	imprimirArbol(a);
	writeln;
	writeln('//////////////////////////////////////////////////////////////////////');
	writeln;
	writeln('El producto con mas unidades vendidas es el numero ',buscarMaximo(a));
	writeln;
	writeln('//////////////////////////////////////////////////////////////////////');
	writeln;
	contarMenoresQue(a);
	contarCodigosEntre(a);
end.
