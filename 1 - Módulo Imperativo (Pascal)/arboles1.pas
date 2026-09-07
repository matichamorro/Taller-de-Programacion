program arboles_1;

const fin = 0;

type
	dias = 1..31;
	meses = 1..12;
	fechas = record
		dia: dias;
		mes: meses;
		anio: integer;
		end;
	venta = record
		cod: integer;
		fecha: fechas;
		uni: integer;
		end;
	arbol_1 = ^nodos_1;
	nodos_1 = record
		venta: venta;
		HI: arbol_1;
		HD: arbol_1;
		end;
	reg_2 = record
		cod: integer;
		totaluni: integer;
		end;
	arbol_2 = ^nodos_2;
	nodos_2 = record
		dato: reg_2;
		HI: arbol_2;
		HD: arbol_2;
		end;
	subreg_3 = record
		fecha: fechas;
		uni: integer;
		end;
	lista = ^nodos;
	nodos = record
		venta: subreg_3;
		sig: lista;
		end;
	reg_3 = record
		cod: integer;
		lista: lista;
		end;
	arbol_3 = ^nodos_3;
	nodos_3 = record
		dato: reg_3;
		HI: arbol_3;
		HD: arbol_3;
		end;
		
		
procedure leerVenta(var v:venta);
begin
	v.cod := random(51);
	if (v.cod <> fin) then
	begin
		v.fecha.dia := 1 + random(31);
		v.fecha.mes := 1 + random(12);
		v.fecha.anio := 2025;
		v.uni := 20 + random(101);
	end;
end;

procedure primerArbol(var a:arbol_1);

	procedure agregarArbol(var a:arbol_1; v:venta);
	begin
		if (a = nil) then begin
			new(a);
			a^.venta := v; a^.HI := nil; a^.HD := nil;
			end
		else if (v.cod < a^.venta.cod) 
			then agregarArbol(a^.HI, v)
			else agregarArbol(a^.HD, v);
	end;

var v:venta;
begin 
	a := nil;
	leerVenta(v);
	while(v.cod <> fin) do
	begin
		agregarArbol(a,v);
		leerVenta(v);
	end;
end;

procedure recorrerArbol(a:arbol_1);
begin
	if(a <> nil) then
	begin
		write('El producto ',a^.venta.cod);
		write(' vendido el dia ',a^.venta.fecha.dia,'/',a^.venta.fecha.mes,'/',a^.venta.fecha.anio);
		write(', un total de: ',a^.venta.uni,' unidades.');
		writeln;
		recorrerArbol(a^.HI);
		recorrerArbol(a^.HD);
	end;
end;

procedure segundoArbol(var a:arbol_2);

	procedure agregarArbol(var a:arbol_2; elem:reg_2);
	begin
		if (a = nil) then begin
			new(a);
			a^.dato := elem; a^.HI := nil; a^.HD := nil;
			end
		else if (elem.cod < a^.dato.cod) 
			then agregarArbol(a^.HI, elem)
		else if (elem.cod > a^.dato.cod)
			then agregarArbol(a^.HD, elem)
		else a^.dato.totaluni := a^.dato.totaluni + elem.totaluni;
	end;
	
var elem:reg_2;
begin 
	a := nil;
	elem.cod := random(51);
	while(elem.cod <> fin) do
	begin
		elem.totaluni := 20 + random(101);
		agregarArbol(a,elem);
		elem.cod := random(51);
	end;
end;

procedure recorrerArbol_2(a:arbol_2);
begin
	if(a <> nil) then
	begin
		recorrerArbol_2(a^.HI);
		write('El producto ',a^.dato.cod);
		write(' fue vendido ',a^.dato.totaluni,' veces.');
		writeln;
		recorrerArbol_2(a^.HD);
	end;
end;

procedure tercerArbol(var a:arbol_3);

	procedure agregarLista(var pri:lista; v:venta);
	var nue:lista;
	begin
		new(nue);
		nue^.venta.fecha := v.fecha;
		nue^.venta.uni := v.uni;
		nue^.sig := pri;
		pri := nue;
	end;
	
	procedure agregarArbol(var a:arbol_3; v:venta);
	begin
		if (a = nil) then begin
			new(a);
			a^.dato.cod := v.cod; a^.dato.lista := nil;
			agregarLista(a^.dato.lista,v);
			a^.HI := nil; a^.HD := nil;
			end
		else if (v.cod < a^.dato.cod) 
			then agregarArbol(a^.HI, v)
		else if (v.cod > a^.dato.cod)
			then agregarArbol(a^.HD, v)
		else agregarLista(a^.dato.lista,v);
	end;
		
var v:venta;
begin 
	a := nil;
	leerVenta(v);
	while(v.cod <> fin) do
	begin
		agregarArbol(a,v);
		leerVenta(v);
	end;
end;

procedure recorrerArbol_3(a:arbol_3);
begin
	if(a <> nil) then
	begin
		recorrerArbol_3(a^.HI);
		write('El producto ',a^.dato.cod,' fue vendido los dias ');
		while (a^.dato.lista <> nil) do
		begin
		write(a^.dato.lista^.venta.fecha.dia,'/',a^.dato.lista^.venta.fecha.mes,'/',a^.dato.lista^.venta.fecha.anio,' - ');
		a^.dato.lista := a^.dato.lista^.sig;
		end;
		writeln;
		recorrerArbol_3(a^.HD);
	end;
end;

var
	a_01:arbol_1;
	a_02:arbol_2;
	a_03:arbol_3;
begin
	Randomize;
	primerArbol(a_01);
	recorrerArbol(a_01);
	writeln;
	writeln('///////////////////////////////////////////////////////////////////////////////////');
	writeln;
	segundoArbol(a_02);
	recorrerArbol_2(a_02);
	writeln;
	writeln('///////////////////////////////////////////////////////////////////////////////////');
	writeln;
	tercerArbol(a_03);
	recorrerArbol_3(a_03);
	writeln;
	writeln('///////////////////////////////////////////////////////////////////////////////////');
	writeln;
end.
		
		
		
		
