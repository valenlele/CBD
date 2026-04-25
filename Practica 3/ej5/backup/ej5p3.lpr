program ej5p3;

const
  FIN = -1;

type
  artDep = record
    nro: integer;
    desc: string[50];
    color: string[10];
    talle: real;
    stock: integer;
    precio: real;
  end;

  maestro = file of artDep;

procedure procesar(var m: maestro; nro: integer);
var
  txt: Text;
  encontre: boolean;
  reg: artDep;
begin
  reset(m);
  assign(txt, 'articulosDeportivos.txt');
  rewrite(txt);

  encontre := false;
  while (not eof(m)) and (not encontre) do begin
    read(m, reg);
    if (reg.nro = nro) then encontre := true;
  end;

  if (encontre) then begin
    writeln(txt, reg.nro);
    writeln(txt, reg.desc);
    writeln(txt, reg.color);
    writeln(txt, reg.talle);
    writeln(txt, reg.stock);
    writeln(txt, reg.precio);
    writeln(txt, ' ');

    reg.nro := -1;
    seek(m, filepos(m) - 1);
    write(m, reg);
  end;

  close(m);
  close(txt);
end;

var
  nro: integer;
  m: maestro;

begin
  assign(m, 'maestro.dat');
  writeln('Se ingresan codigos de articulos deportivos a eliminar: ');
  write('Codigo: ');
  readln(nro);
  while (nro <> FIN) do procesar(m, nro);
end.
