program Recursividad;

const   fin = 100;
        max = 200;

type
	lista = ^nodos;
	nodos = record
		dato : integer;
		sig : lista;
		end;
	
procedure generarLista(var pri:lista);
var num: integer; nue: lista;
begin
	num := fin + random(max-fin+1);
	{readln(num);}
	if (num <> fin) then
	begin
		new(nue);
		nue^.dato := num;
		nue^.sig := pri;
		pri := nue;
		generarLista(pri);
	end;
end;

procedure imprimirLista(pri:lista);
begin
	if (pri <> nil) then
	begin
		writeln(pri^.dato);
		pri := pri^.sig;
		imprimirLista(pri);
	end;
end;

procedure imprimirListaInversa(pri:lista);
begin
	if(pri <> nil) then
		if(pri^.sig <> nil) then begin
			imprimirListaInversa(pri^.sig);
			writeln(pri^.dato);
			end
		else
			writeln(pri^.dato);
end;
	
function buscarMin(pri:lista): integer;

    function buscarMinRecursivo(pri:lista; min:integer): integer;
    begin
    	if(pri <> nil) then 
    	begin
    		if (pri^.dato < min) then
    			min := pri^.dato;
    		buscarMinRecursivo := buscarMinRecursivo(pri^.sig,min);
    	end
    	else buscarMinRecursivo := min;
    end;
var min: integer;
begin
    min := 201;
    buscarMin := buscarMinRecursivo(pri,min);
end;

function buscarElem(pri:lista; elem:integer): boolean;
begin
    if (pri <> nil) then
        if(pri^.dato = elem) then buscarElem := True
        else buscarElem := buscarElem(pri^.sig,elem)
    else buscarElem := False;
end;


var
	elem: integer;
	pri: lista;
begin
	Randomize;
	pri := nil;
	generarLista(pri);
	writeln;
	imprimirLista(pri);
	writeln;
	imprimirListaInversa(pri);
	writeln;
	write('El minimo es: ',buscarMin(pri));
	writeln;
	read(elem);
	if (buscarElem(pri,elem)) 
	then write('El elemento ',elem,' esta en la lista')
	else write('El elemento ',elem,' NO esta en la lista');
end.
