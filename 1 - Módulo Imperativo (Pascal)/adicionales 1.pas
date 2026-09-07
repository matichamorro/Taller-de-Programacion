program Adicionales1;

const
	dF = 300;
	fin = 0;

type
	oficina = record
		cod: integer;
		dni: integer;
		valor: real;
		end;
	vector = array [1..dF] of oficina;
	
	
procedure imprimirVector(v:vector; dL:integer);
var i:integer;
begin
	for i := 1 to dL do
	begin
		write('Codigo de identificacion: ',v[i].cod);
		write(' - DNI del propietario: ',v[i].dni);
		writeln(' - Valor de la expensa: ',v[i].valor:0:2,' ///');
	end;
end;

procedure cargarVector(var v:vector; var dL:integer);
	
	procedure leerOficina(var o:oficina);
	begin
		o.cod := random(101);
		if (o.cod <> fin) then
		begin
			o.dni := 3000 + random(1001);
			o.valor := 150000 + random(51)*1000;
		end;
	end;

var
	o:oficina;
begin 
	dL := 0;
	leerOficina(o);
	while (o.cod <> fin) do
	begin
		dL := dL + 1;
		v[dL] := o;
		leerOficina(o);
	end;
end;

procedure ordenarPorInsercion(var v:vector; dL:integer);
var i, j: integer; elem: oficina;
begin
	for i := 2 to dL do
	begin
		elem := v[i];
		j := i-1;
		while (j > 0) and (v[j].cod > elem.cod) do
		begin
			v[j+1] := v[j];
			j := j-1;
		end;
		v[j+1] := elem;
	end;
end;

function busquedaDicotomica(v:vector; dL:integer; cod:integer): integer;
var min,medio: integer;
begin
	min := 1;
	medio := (min + dL) div 2;
	while (min <= dL) and (v[medio].cod <> cod) do
	begin
		if (cod < v[medio].cod) then
			dL := medio - 1
		else 
			min := medio + 1;
		medio := (min + dL) div 2;
	end;
	if (min <= dL) then busquedaDicotomica := medio
	else busquedaDicotomica := 0;
end;

function montoTotal(v:vector; dL:integer):real;
begin
	if (dL >0) then
		montoTotal := v[dL].valor + montoTotal(v,dL-1);
end;


var
	v: vector;
	dL, cod, pos: integer;
begin
	cargarVector(v,dL);
	writeln;
	writeln(' -------- Vector desordenado --------');
	imprimirVector(v,dL);
	writeln(' ------------------------------------');
	
	ordenarPorInsercion(v,dL);
	writeln;
	writeln(' ---------- Vector ordenado ----------');
	imprimirVector(v,dL);
	writeln(' -------------------------------------');

	writeln;
	writeln(' Ingresar un codigo de identificacion a buscar');
	read(cod);
	pos := busquedaDicotomica(v,dL,cod);
	if (pos = 0) then writeln(' No existe esa oficina. ')
	else writeln(' El propietario  de esa oficina tiene el dni ',v[pos].dni);	

	writeln;
	writeln(' -------------------------------------');
	writeln;
	writeln(' El monto total entre todas las expensas asciende a:');
	writeln(montoTotal(v,dL):0:2);
	writeln;
end.






















