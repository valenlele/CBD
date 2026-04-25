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

procedure procesar(var m: maestro; nro: integer; var txt:Text);
var
  encontre, mayor: boolean;
  reg: artDep;
begin
  seek(m, 0);
  encontre := false;
  mayor := false;
  while (not eof(m)) and (not encontre) and (not mayor) do begin
    read(m, reg);
    if (reg.nro = nro) then encontre := true;
    if (reg.nro > nro) then mayor := true;
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
end;

procedure compactar(var m: maestro);
var
  mCompact: maestro;
  reg: artDep;
begin
  assign(mCompact, 'maestroComapct.dat');
  rewrite(mCompact);

  seek(m, 0);
  while (not eof(m)) do begin
    read(m, reg);
    if (reg.nro <> -1) then write(mCompact, reg);
  end;

  close(m);
  close(mCompact);

  erase(m);
  rename(mCompact, 'maestro.dat');
end;

var
  nro: integer;
  m: maestro;
  txt: Text;

begin
  assign(m, 'maestro.dat');
  reset(m);
  assign(txt, 'articulosDeportivos.txt');
  rewrite(txt);

  writeln('Se ingresan codigos de articulos deportivos a eliminar: ');
  write('Codigo: ');
  readln(nro);
  while (nro <> FIN) do begin
    procesar(m, nro, txt);
    readln(nro);
  end;

  close(txt);

  compactar(m);
end.
