program arbolesII_4; 
const fin = 0;
type
	dias = 1..31;
	meses = 1..12;
	fechas = record
		dia: dias;
		mes: meses;
	end;
	prestamo = record
		isbn: integer;
		num: integer;
		fecha: fechas;
	end;
	arbol_1 = ^nodo_1;
	nodo_1 = record
		dato: prestamo;
		HI: arbol_1;
		HD: arbol_1;
	end;
	
	reg_nodos_lista = record
		num: integer;
		fecha: fechas;
	end;
	lista = ^nodos_lista;
	nodos_lista = record
		dato: reg_nodos_lista;
		sig: lista;
	end;
	
	nodos_2 = record
		isbn: integer;
		prestamos: lista;
	end;
	arbol_2 = ^nodo_2;
	nodo_2 = record
		dato: nodos_2;
		HI: arbol_2;
		HD: arbol_2;
	end;
	
	reg_nodo_3 = record
		isbn: integer;
		count: integer;
		end;
	arbol_3 = ^nodo_3;
	nodo_3 = record
		dato: reg_nodo_3;
		HI: arbol_3;
		HD: arbol_3;
	end;


// PUNTO A
procedure leerPrestamos(var a1:arbol_1; var a2:arbol_2);

	procedure leerUno(var p:prestamo);
	begin
		p.isbn := random(50);
		if (p.isbn <> fin) then
		begin
			p.num := 20 + random(50);
			p.fecha.dia := 1 + random(31);
			p.fecha.mes := 1 + random(12);
		end;
	end;
	
	procedure agregarArbol(var a:arbol_1; p:prestamo);
	begin
		if (a = nil) then
		begin
			new(a); 
			a^.dato := p; a^.HI := nil; a^.HD := nil;
		end
		else if (p.isbn < a^.dato.isbn) then
			agregarArbol(a^.HI,p)
		else 
			agregarArbol(a^.HD,p);
	end;

	procedure recorrerArbol(a1:arbol_1; var a2:arbol_2);
	
		procedure buscarNodo(var a:arbol_2; dato:prestamo);
		var aux: lista;
		begin
			if (a = nil) then 
			begin
				new(a); a^.dato.isbn := dato.isbn; 
				new(a^.dato.prestamos); 
				a^.dato.prestamos^.dato.num := dato.num; 
				a^.dato.prestamos^.dato.fecha := dato.fecha;
				a^.dato.prestamos^.sig := nil;
			end
			else if (a^.dato.isbn > dato.isbn) then
				buscarNodo(a^.HI,dato)
			else if (a^.dato.isbn < dato.isbn) then
				buscarNodo(a^.HD,dato)
			else begin
				new(aux); 
				aux^.dato.num := dato.num;
				aux^.dato.fecha := dato.fecha;
				aux^.sig := a^.dato.prestamos;
				a^.dato.prestamos := aux;
			end;
		end;
	begin
		if (a1 <> nil) then begin
			buscarNodo(a2,a1^.dato);
			recorrerArbol(a1^.HI,a2);
			recorrerArbol(a1^.HD,a2);
		end;
	end;
	
var
	p:prestamo;
begin
	leerUno(p);
	while (p.isbn <> fin) do 
	begin
		agregarArbol(a1,p);
		leerUno(p);
	end;
	recorrerArbol(a1,a2);
end;

procedure imprimirArbol(a:arbol_1);
begin
	if (a <> nil) then 
	begin
		imprimirArbol(a^.HI);
		writeln('El IBSN es: ',a^.dato.isbn);
		writeln('El numero del socio es: ',a^.dato.num);
		writeln('La fecha es: ',a^.dato.fecha.dia,'/',a^.dato.fecha.mes);
		imprimirArbol(a^.HD);
	end;
end;

procedure imprimirArbol2(a:arbol_2);
var aux: lista;
begin
	if (a <> nil) then 
	begin
		imprimirArbol2(a^.HI);
		writeln;
		writeln('El IBSN es: ',a^.dato.isbn);
		writeln('Los prestamos son: ');
		aux := a^.dato.prestamos;
		while(aux <> nil) do 
		begin
			write('Numero del socio: ',aux^.dato.num,'. Fecha: ',aux^.dato.fecha.dia,'/',aux^.dato.fecha.mes,' - ');
			aux := aux^.sig;
		end;
		writeln;
		imprimirArbol2(a^.HD);
	end;
end;


// PUNTO B
function buscarMaximo(a:arbol_1): integer;
begin
	if (a = nil) then
		buscarMaximo := -1
	else if (a^.HD <> nil) then
		buscarMaximo := buscarMaximo(a^.HD)
	else 
		buscarMaximo := a^.dato.isbn;
end;


// PUNTO C
function buscarMinimo(a:arbol_2): integer;
begin
	if (a = nil) then
		buscarMinimo := -1
	else if (a^.HD <> nil) then
		buscarMinimo := buscarMinimo(a^.HI)
	else 
		buscarMinimo := a^.dato.isbn;
end;


// PUNTO D
function contarPrestamos(a:arbol_1; num:integer): integer;
begin
	if (a = nil) then 
		contarPrestamos := 0
	else if (a^.dato.num = num) then
		contarPrestamos := 1  + contarPrestamos(a^.HI,num) + contarPrestamos(a^.HD,num)
	else 
		contarPrestamos := 0 + contarPrestamos(a^.HI,num) + contarPrestamos(a^.HD,num);
end;

// PUNTO E
function contarPrestamosEnLista(a:arbol_2; num:integer): integer;
	
	function contarLista(pri:lista; num:integer):integer;
	begin
		if (pri = nil) then 
			contarLista := 0
		else if (pri^.dato.num = num) then 
			contarLista := 1 + contarLista(pri^.sig,num)
		else
			contarLista := 0 + contarLista(pri^.sig,num);
	end;

begin
	if (a = nil) then 
		contarPrestamosEnLista := 0
	else 
		contarPrestamosEnLista := contarLista(a^.dato.prestamos,num) + contarPrestamosEnLista(a^.HI,num) + contarPrestamosEnLista(a^.HD,num);
end;

//PUNTO F
procedure contarApariciones(a1:arbol_1; var a3:arbol_3 );

	procedure incrementarContadores(var a:arbol_3; isbn:integer);
	begin
		if (a = nil) then begin
			new(a);
		    a^.dato.isbn := isbn; 
		    a^.dato.count := 1;
			a^.HI := nil; 
			a^.HD := nil;
			end
		else if (isbn < a^.dato.isbn) then
			incrementarContadores(a^.HI,isbn)
		else if (isbn > a^.dato.isbn) then
			incrementarContadores(a^.HD,isbn)
		else 
			a^.dato.count := 1 + a^.dato.count;
	end;
	
begin
	if (a1 <> nil) then
	begin
		contarApariciones(a1^.HI,a3);
		incrementarContadores(a3, a1^.dato.isbn);
		contarApariciones(a1^.HD,a3);
	end;
end;


//PUNTO G
procedure contarApariciones2(a2:arbol_2; var a3:arbol_3);

	procedure incrementarContadores(var a:arbol_3; isbn, total:integer);
	begin
		if (a = nil) then begin
			new(a);
		    a^.dato.isbn := isbn; 
		    a^.dato.count := total;
			a^.HI := nil; 
			a^.HD := nil;
			end
		else if (isbn < a^.dato.isbn) then
			incrementarContadores(a^.HI,isbn,total)
		else if (isbn > a^.dato.isbn) then
			incrementarContadores(a^.HD,isbn,total)
		else 
			a^.dato.count := total + a^.dato.count;
	end;
	
var total: integer;
	aux: lista;
begin
	if (a2 <> nil) then
	begin
	total := 0;
	aux := a2^.dato.prestamos;
		contarApariciones2(a2^.HI,a3);
		while (aux <> nil) do begin
			total := 1 + total;
			aux := aux^.sig;
			end;
		incrementarContadores(a3, a2^.dato.isbn, total);
		contarApariciones2(a2^.HD,a3);
	end;
end;


//PUNTO H
procedure imprimirArbol3(a:arbol_3);
begin
	if (a <> nil) then
	begin
		imprimirArbol3(a^.HI);
		writeln('ISBN: ',a^.dato.isbn,' - Apariciones: ',a^.dato.count,' // ');
		imprimirArbol3(a^.HD);
	end;
end;


//PUNTO I
function contarEntreRango(a:arbol_1; min,max:integer):integer;
begin
	if (a = nil) then
		contarEntreRango := 0
	else if (a^.dato.isbn >= min) and (a^.dato.isbn <= max) then
		contarEntreRango := 1 + contarEntreRango(a^.HI,min,max) + contarEntreRango(a^.HD,min,max)
	else if (a^.dato.isbn < min) then
		contarEntreRango := contarEntreRango(a^.HD,min,max)
	else 
		contarEntreRango := contarEntreRango(a^.HI,min,max);
end;


//PUNTO J
function contarEntreRango2(a:arbol_2; min,max:integer):integer;
var aux: lista; total: integer;
begin
	total := 0;
	if (a = nil) then
		contarEntreRango2 := 0
	else if (a^.dato.isbn >= min) and (a^.dato.isbn <= max) then
	begin
		aux := a^.dato.prestamos;
		while (aux <> nil) do 
		begin
			total := total + 1;
			aux := aux^.sig;
		end;
		contarEntreRango2 := total + contarEntreRango2(a^.HI,min,max) + contarEntreRango2(a^.HD,min,max);
	end
	else if (a^.dato.isbn < min) then
		contarEntreRango2 := contarEntreRango2(a^.HD,min,max)
	else 
		contarEntreRango2 := contarEntreRango2(a^.HI,min,max);
end;


var
	a1:arbol_1;
	a2:arbol_2;
	primer_a3,segundo_a3 :arbol_3;
	max,min,aux,num1,num2: integer;
begin
	a1 := nil;
	a2 := nil;
	leerPrestamos(a1,a2);
	imprimirArbol(a1);
	imprimirArbol2(a2);
	
	max := buscarMaximo(a1);
	min := buscarMinimo(a2);
	writeln;
	if (max <> -1) then writeln('El IBSN mas grande en el arbol 1 es: ',max)
	else writeln('Arbol 1 vacio.');
	if (min <> -1) then writeln('El IBSN mas chico en el arbol 2 es: ',min)
	else writeln('Arbol 2 vacio.');
	writeln;

	writeln;
	writeln('Ingresar un numero de socio a buscar: ');
	read(aux);
	writeln('El socio ',aux,' tiene ',contarPrestamos(a1,aux),' prestamos.');
	writeln;
	writeln('Ingresar un numero de socio a buscar: ');
	read(aux);
	writeln('El socio ',aux,' tiene ',contarPrestamosEnLista(a2,aux),' prestamos.');
	
	primer_a3 := nil;
	segundo_a3 := nil;
	contarApariciones(a1,primer_a3);
	writeln;
	imprimirArbol3(primer_a3);
	writeln;
	contarApariciones2(a2,segundo_a3);
	writeln;
	imprimirArbol3(segundo_a3);
	writeln;
	
	writeln('Introducir el numero minimo del rango a buscar: ');
	read(num1);
	writeln('Introducir el numero maximo del rango a buscar: ');
	read(num2);
	writeln('Hay ',contarEntreRango(a1,num1,num2),' prestamos realizados a los ISBN comprendidos entre los dos valores recibidos');
	writeln;
	writeln('////Segundo Proceso////');
	writeln('Hay ',contarEntreRango2(a2,num1,num2),' prestamos realizados a los ISBN comprendidos entre los dos valores recibidos');
end.


























