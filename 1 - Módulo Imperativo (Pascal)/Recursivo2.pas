program Recursividad2;

const 
    dimF = 20;
    min = 300;
    max = 1550;
    
type
    indice = 1..dimF;
    vector = array [indice] of integer;
    
procedure cargarVector(var v:vector);

    procedure cargarVectorRecursivo(var v:vector; i:indice);
    var num: integer;
    begin
        num := min + random(max-min+1);
        v[i] := num;
        if (i < dimF) then
            cargarVectorRecursivo(v,i+1);
    end;

var i:indice;
begin
    i := 1;
    cargarVectorRecursivo(v,i);
end;

procedure ordenarVectorPorInsercion(var v:vector);
var i,j: indice; elem: integer;
begin
    for i := 2 to dimF do
    begin
        elem := v[i];
        j := i-1;
        while (j > 0) and (v[j] > elem) do
        begin
            v[j+1] := v[j];
            j := j-1;
        end;
        v[j+1] := elem;
    end;
end;

procedure busquedaDicotomica(v:vector; ini,fin:indice; dato:integer; var pos:integer);
begin
    if (fin <> ini) then
        if (dato > v[fin div 2]) then busquedaDicotomica(v,((ini+fin) div 2),fin,dato,pos) 
        else busquedaDicotomica(v,ini,((ini+fin) div 2),dato,pos) 
    else if (dato = v[ini]) then
        pos := ini
    else pos := -1;
end;  


var 
    v: vector;
    i,ini,fin: indice;
    numABuscar,pos: integer;
begin
    cargarVector(v);
    for i := 1 to dimF do   
        write(v[i],' | ');
    writeln;
    
    ordenarVectorPorInsercion(v);
    for i := 1 to dimF do   
        write(v[i],' | ');
    writeln;
    
    readln(numABuscar);
    ini := 1;
    fin := dimF;
    busquedaDicotomica(v,ini,fin,numABuscar,pos);
    
    {No muestraa nada, no se como arreglarlo}
    if (pos = -1) then writeln('El numero ',numABuscar,' NO esta en el vector')
    else writeln('El numero ',numABuscar,' esta en el vector');
end.












