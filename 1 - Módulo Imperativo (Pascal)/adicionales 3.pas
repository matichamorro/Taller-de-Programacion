program Adicionales3;

type
	meses = 1..12;

	compra = record
		cod_videojuego : integer;
		cod_cliente : integer;
		mes : integer;
	end;
	
	reg_nodos_lista = record
		cod_cliente: integer;
		mes: meses;
	end;
	lista = ^nodos_lista;
	nodos_lista = record
		dato: reg_nodos_lista;
		sig: lista;
	end;
	
	reg_nodos_arbol = record
		cod_videojuego: integer;
		compras: lista;
	end;
	arbol = ^nodos_arbol;
	nodos_arbol = record
		dato: reg_nodos_arbol;
		HI: arbol;
		HD: arbol;
	end;
	
procedure cargarArbol(var a:arbol);
	
	procedure leerCompra (var c : compra);
	begin
		c.cod_cliente := Random(200);
		if (c.cod_cliente <> 0)
		then begin
			c.mes := Random(12) + 1;
			c.cod_videojuego := Random(200) + 1000;
		end;
	end;
	procedure agregarAdelante(var l:lista; elem:compra);
	var nue:lista;
	begin
		new(nue);
		nue^.dato.cod_cliente := elem.cod_cliente;
		nue^.dato.mes := elem.mes;
		nue^.sig := l;
		l := nue;
	end;
	procedure agregarArbol(var a:arbol; c:compra);
	begin
		if (a = nil) then begin
			new(a);
			a^.dato.cod_videojuego := c.cod_videojuego;
			a^.dato.compras := nil;
			agregarAdelante(a^.dato.compras,c);
			a^.HI := nil;
			a^.HD := nil;
		end
		else if (c.cod_videojuego < a^.dato.cod_videojuego) then
			agregarArbol(a^.HI,c)
		else if (c.cod_videojuego > a^.dato.cod_videojuego) then
			agregarArbol(a^.HD,c)
		else
			agregarAdelante(a^.dato.compras,c);
	end;
var
	c:compra;
begin
	a := nil;
	leerCompra(c);
	while (c.cod_cliente <> 0) do begin
		agregarArbol(a,c);
		leerCompra(c);
	end;
end;

procedure imprimirArbol(a:arbol);
var aux: lista;
begin
	if (a <> nil) then 
	begin
		imprimirArbol(a^.HI);
		writeln;
		writeln('El codigo de videojuego es: ',a^.dato.cod_videojuego);
		writeln('Las compras son: ');
		aux := a^.dato.compras;
		while(aux <> nil) do 
		begin
			write('Codigo de cliente: ',aux^.dato.cod_cliente,'. Mes: ',aux^.dato.mes,' /// ');
			aux := aux^.sig;
		end;
		writeln;
		imprimirArbol(a^.HD);
	end;
end;

function buscarLista(a:arbol; cod:integer): lista;
begin
	if (a = nil) then
		buscarLista := nil
	else if (cod < a^.dato.cod_videojuego) then
		buscarLista := buscarLista(a^.HI,cod)
	else if (cod > a^.dato.cod_videojuego) then
		buscarLista := buscarLista(a^.HD,cod)
	else 
		buscarLista := a^.dato.compras;
end;

function contarEnLista(l:lista; mes:meses): integer;
begin
	if (l = nil) then contarEnLista := 0
	else if (l^.dato.mes = mes) then contarEnLista := 1 + contarEnLista(l^.sig,mes)
	else contarEnLista := contarEnLista(l^.sig,mes);
end;

var
	a: arbol;
	cod: integer;
	l: lista;
	mes: meses;
begin
	cargarArbol(a);
	imprimirArbol(a);
	
	writeln;
	writeln;
	writeln('Ingresar un codigo de videojuego a buscar: ');
	readln(cod);
	l := buscarLista(a,cod);
	writeln;
	writeln('Ingresar un mes a buscar: ');
	readln(mes);
	writeln('En el mes ',mes,' el videojuego con el codigo ',cod,' fue comprado ',contarEnLista(l,mes),' veces.');
end.
	






