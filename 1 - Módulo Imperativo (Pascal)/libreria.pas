program Libreria;

const 
    fin = -1;
    dimF = 20;

type
    rubros = 1..6;
    producto = record
        cod: integer;
        rub: rubros;
        precio: real;
        end; 
    lista = ^nodos;
    nodos = record
        dato: producto;
        sig: lista;
        end;
    vector = array [rubros] of lista;
    vector2 = array [1..dimF] of producto;

procedure generarListas (var v: vector);

    procedure leerProducto (var p:producto);
    begin
        write ('Codigo de producto: ');
        p.cod:= random(1001)-1;
        writeln (p.cod);
        if (p.cod <> fin)
        then begin
            write ('Codigo de rubro del producto: ');
            p.rub:= random(6)+1;
            writeln (p.rub);
            write ('Precio del producto: ');
            p.precio := random(10000)/10 ;
            writeln (p.precio:0:1);
            end;
    end;
    procedure agregarAdelante(var L:lista; p:producto);
    var nue:lista;
    begin
        new(nue);
        nue^.dato := p;
        nue^.sig := L;
        L := nue;
    end;
var p: producto;
begin
    leerProducto(p);
    while (p.cod <> fin) do 
    begin
        agregarAdelante(v[p.rub],p);
        leerProducto(p);
    end;
end;

procedure mostrarRubros(v:vector);
    procedure mostrarLista(L:lista);
    begin
        while (L <> nil) do
        begin
            write(L^.dato.cod,' - ');
            L := L^.sig;
        end;
        writeln;
    end;
var
    i: integer;
begin
    { Voy a mostrar cada rubro }
    for i := 1 to 6 do 
    begin
        writeln('-- Rubro ',i,' --');
        mostrarLista(v[i]);
    end;
end;
    
procedure generarVector(var v:vector2; var dimL:integer; L:lista);
begin
    dimL := 0;
    while (L <> nil) and (dimL < dimF) do
    begin
        dimL := dimL+1;
        v[dimL] := L^.dato;
        L := L^.sig;
    end;
end;

procedure vectorInsercion(var v:vector2; dimL:integer);
var i,j:integer; p: producto;
begin
    for i := 2 to dimL do
    begin
        p := v[i];
        j := i-1;
        while (j > 0) and (v[j].precio > p.precio) do
        begin
            v[j+1] := v[j];
            j := j-1;
        end;
        v[j+1] := p;
    end;
end;

procedure mostrarVector(v:vector2;dimL:integer);
var i: integer;
begin
     { Voy a mostrar el vector ordenado }
    for i := 1 to dimL-1 do
        write (v[i].precio:0:1,', ');
    writeln(v[dimL].precio:0:1);
end;

function prom(v: vector2; dimL: integer): real;
var i:integer; total: real;
begin
    total := 0;
    for i := 1 to dimL do
        total := total + v[i].precio;
    prom := total / dimL;
end;

var
    v: vector;
    v2:vector2;
    i,dimL: integer;
    promedio: real;
begin
    for i := 1 to 6 do
        v[i] := nil;
    Randomize;
    generarListas(v);
    mostrarRubros(v);
    generarVector(v2,dimL,v[3]);
    vectorInsercion(v2,dimL);
    mostrarVector(v2,dimL);
    promedio := prom(v2,dimL);
    writeln('El promedio entre los precios del vector anterior es: ',promedio:0:1);
end.















