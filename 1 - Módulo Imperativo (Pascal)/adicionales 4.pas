program Adicionales4;

const fin = 0;

type 
	subGenero = 1..7;
	libro = record
		isbn : integer;
		codAutor : integer;
		genero : subGenero;
	end; 
	
	reg_nodos = record
		codAutor: integer;
		cantLibros: integer;
	end;
	arbol = ^nodos;
	nodos = record
		dato: reg_nodos;
		HI: arbol;
		HD: arbol;
	end;
	
	reg_contador = record
		nom: string;
		cantLibros: integer;
	end;
	contador = array [subGenero] of reg_contador;

procedure leerLibros(var a:arbol; var c:contador);

	procedure leerLibro (var l : libro);
	begin
	 l.isbn := Random(1000);
	 if (l.isbn <> 0) then begin
	 l.codAutor := Random(300) + 100;
	 l.genero := Random(7) + 1;
	 end;
	end;
	procedure agregarArbol(var a:arbol; l:libro);
	begin
		if(a = nil) then begin
			new(a);
			a^.dato.codAutor := l.codAutor;
			a^.dato.cantLibros := 1;
			a^.HI := nil;
			a^.HD := nil;
		end
		else if (l.codAutor < a^.dato.codAutor) then
			agregarArbol(a^.HI,l)
		else if (l.codAutor > a^.dato.codAutor) then
			agregarArbol(a^.HD,l)	
		else
			a^.dato.cantLibros := a^.dato.cantLibros + 1;
	end;
	
var
	i:integer;
	l: libro;
begin
	for i:= 1 to 7 do
		c[i].cantLibros := 0;
	leerLibro(l);
	while (l.isbn <> 0) do begin
		agregarArbol(a,l);
		c[l.genero].cantLibros := c[l.genero].cantLibros + 1;
		leerLibro(l);
	end;
end;

procedure imprimirArbol(a:arbol);
begin	
	if (a <> nil) then begin
		imprimirArbol(a^.HI);
		write('Codigo del auto: ',a^.dato.codAutor);
		write(' - Cantidad de libros: ',a^.dato.cantLibros,' ////');
		writeln;
		imprimirArbol(a^.HD);
	end;
end;

procedure imprimirVector(c:contador);
var
	i: integer;
begin
	for i:= 1 to 7 do
		writeln('/// ',c[i].nom,': ',c[i].cantLibros,' libros.');
end;
	
procedure buscarMaximo(var c:contador; var generoMax:string);

	procedure ordenarPorInsercion(var c:contador);
	var i,j: integer; elem: reg_contador;
	begin
		for i := 2 to 7 do begin
			elem := c[i];
			j := i-1;
			while (j > 0) and (c[j].cantLibros < elem.cantLibros) do begin
				c[j+1] := c[j];
				j := j-1;
			end;
			c[j+1] := elem;
		end;
	end;
	
begin
	ordenarPorInsercion(c);
	generoMax := c[1].nom;
end;

function sumarTotal(a:arbol; min,max: integer):integer;
begin
	if (a = nil) then 
		sumarTotal := 0
	else if (a^.dato.codAutor >= min) and (a^.dato.codAutor <= max) then
		sumarTotal := a^.dato.cantLibros + sumarTotal(a^.HI,min,max) + sumarTotal(a^.HD,min,max)
	else if (a^.dato.codAutor < min) then
		sumarTotal := sumarTotal(a^.HD,min,max)
	else 
		sumarTotal := sumarTotal(a^.HI,min,max);
end;


var 
	v: array [1..7] of string = ('literario', 'filosofia', 'arte', 'biologia', 'computacion', 'medicina', 'ingenieria');
	i, libros, min, max: integer;
	a:arbol;
	c:contador;
	generoMaximo: string;
	
begin
	leerLibros(a,c);
	for i:= 1 to 7 do
		c[i].nom := v[i];
		
	imprimirArbol(a);
	writeln;
	imprimirVector(c);
	
	writeln;
	buscarMaximo(c,generoMaximo);
	writeln('El genero con mayor cantidad de libros es: ',generoMaximo);
	
	writeln;
	writeln('Ingresar un numero minimo para la busqueda');
	readln(min);
	writeln('Ingresar un numero maximo para la busqueda');
	readln(max);
	libros := sumarTotal(a,min,max);
	writeln('Hay ',libros,' libros entre los autores con los codigos entre ',min,' y ',max);
end.
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
