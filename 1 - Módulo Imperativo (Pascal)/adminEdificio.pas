program AdminEdificio;

const 
    dimF = 300;
    fin = -1;
type
    oficina = record
	cod : integer;
	dni : integer;
	valor : real;
	end;
    vector = array [1..dimF] of oficina;
 
procedure generarVector (var v: vector; var dimL: integer);
  
  procedure leerOficina (var o:oficina);
  begin
    write ('Codigo de identificación: ');
    o.cod:= random(301);
    writeln (o.cod);
    if (o.cod <> fin)
    then begin
           write ('DNI del propietario: ');
           o.dni:= random(1000000)+30000000;
           writeln (o.dni);
           write ('Valor de la expensa: ');
	       o.valor:= random(30)*1000+300000 ;
	       writeln (o.valor:0:2);
           end;
  end;

var o: oficina;
begin
    dimL := 0;
    leerOficina (o);
    while (o.cod <> fin)  and ( dimL < dimF ) do 
    begin
       dimL := dimL + 1;
       v[dimL]:= o;
       leerOficina (o);
    end;
end;

procedure imprimirVector(v:vector; dimL:integer);

    procedure mostrarOficina(o:oficina);
    begin
        write('El codigo es ',o.cod,'; ');
        write('El dni del propietario es ',o.dni,'; ');
        write('El valor es ',o.valor:0:2);
        writeln;
    end;

var i: integer;
begin
    for i := 1 to dimL do
        mostrarOficina(v[i]);
    writeln;
end;

procedure ordenarPorInsercion(var v:vector;dimL:integer);
var i,j: integer; actual: oficina;
begin
    for i := 2 to dimL do
    begin
        actual := v[i];
        j := i-1;
        while (j > 0) and (v[j].cod > actual.cod) do
        begin   
            v[j+1] := v[j];
            j := j-1;
        end;
        v[j+1] := actual;
    end;
end;

procedure ordenarPorSeleccion(var v:vector; dimL:integer);
var i,j,pos: integer; aux: oficina;
begin
    for i := 1 to dimL-1 do
    begin
        pos := i;
        for j := i+1 to dimL do
            if (v[pos].cod > v[j].cod) then
                pos := j;
        aux := v[i];
        v[i] := v[pos];
        v[pos] := aux;
    end;
end;

var
    v: vector;
    dimL: integer;
begin
    Randomize;
    generarVector(v,dimL);
    imprimirVector(v,dimL);
    {ordenarPorInsercion(v,dimL);}
    ordenarPorSeleccion(v,dimL);
    imprimirVector(v,dimL);
end.


