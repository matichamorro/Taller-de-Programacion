program Netflix;

const fin = -1;

type
    generos = 1..8;
    pelicula = record
        cod: integer;
        gen: generos;
        prom: real;
        end; 
    lista = ^nodos;
    nodos = record
        dato: pelicula;
        sig: lista;
        end;
    vector = array [generos] of lista;
    maximos = array [generos] of pelicula;

procedure generarListas (var v: vector);
  
    procedure leerPelicula (var p:pelicula);
    begin
        write ('Codigo de pelicula: ');
        p.cod:= random(101)-1;
        writeln (p.cod);
        if (p.cod <> fin)
        then begin
            write ('Codigo de genero de la pelicula: ');
            p.gen:= random(8)+1;
            writeln (p.gen);
            write ('Promedio de puntuacion: ');
            p.prom := random(100)/10 ;
            writeln (p.prom:0:1);
            end;
    end;
    procedure agregarAdelante(var L:lista; p:pelicula);
    var nue:lista;
    begin
        new(nue);
        nue^.dato := p;
        nue^.sig := L;
        L := nue;
    end;

var p: pelicula;
begin
    leerPelicula(p);
    while (p.cod <> fin) do 
    begin
        agregarAdelante(v[p.gen],p);
        leerPelicula(p);
    end;
end;

procedure buscarMaximos(var m:maximos; v:vector);
var i: integer; max: pelicula;
begin
    for i := 1 to 8 do
    begin
        max.cod := -1;
        max.prom := -1;
        while (v[i] <> nil) do
        begin
            if (v[i]^.dato.prom > max.prom) then
                max := v[i]^.dato;
            v[i] := v[i]^.sig;
        end;
        m[i] := max;
        if (max.prom = -1) then writeln('No se encontraron peliculas del genero ',i)
        else  writeln('La mejor pelicula del genero ',i,' tiene el codigo: ',m[i].cod,', y un promedio de: ',m[i].prom:0:1);
        
    end;
end;

procedure vectorInsercion(var m:maximos);
var i,j:generos; p: pelicula;
begin
    for i := 2 to 8 do
    begin
        p := m[i];
        j := i-1;
        while (j > 0) and (m[j].prom > p.prom) do
        begin
            m[j+1] := m[j];
            j := j-1;
        end;
        m[j+1] := p;
    end;
end;

var
    v:vector;
    m:maximos;
    i:integer;
begin
    for i := 1 to 8 do
        v[i] := nil;
    Randomize;
    generarListas(v);
    buscarMaximos(m,v);
    vectorInsercion(m);
    
 { Voy a mostrar el vector ordenado }
    for i := 1 to 7 do
        write (m[i].prom:0:1,', ');
    writeln (m[8].prom:0:1);
    
    writeln('El codigo de la pelicula con mayor puntaje es: ',m[8].cod);
    writeln('El codigo de la pelicula con menor puntaje es: ',m[1].cod);
end.
















