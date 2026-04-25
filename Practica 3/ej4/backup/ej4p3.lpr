program ej4p3;

const
  FIN = -1;

type
  cd = record
    cod: integer;
    nom: string[20];
    genero: string[15];
    artista: string[20];
    desc: string[30];
    anio, stock: integer;
  end;

  arch = file of cd;

procedure bajaLogica(var a: arch; cod: integer);
var
  encontre: boolean;
  reg: cd;
begin
  reset(a);

  encontre := false;
  while (not eof(a)) and (not encontre) do begin
    read(a, reg);
    if (reg.cod = cod) then encontre := true;
  end;

  if (encontre) then begin
    writeln('Nombre disco: ', reg.nom);
    reg.stock := 0;
    seek(a, filepos(a) - 1);
    write(a, reg);
  end;

  close(a);
end;

procedure bajaFisica(var a: arch);
var
  posBorrar: integer;
  aux: cd;
begin
  posBorrar := filepos(a) - 1;
  seek(a, filesize(a) - 1);
  read(a, aux);
  while (aux.stock = 0) do begin
    seek(a, filesize(a) - 1);
    truncate(a);
    seek(a, filesize(a) - 1);
    read(a, aux);
  end;
  seek(a, posBorrar);
  write(a, aux);
  seek(a, filesize(a) - 1);
  truncate(a);
end;

procedure compactar(var a: arch);
var
  reg: cd;
  pos: integer;
begin
  reset(a);

  while (not eof(a)) do begin
    read(a, reg);
    if (reg.stock = 0) then begin
      pos := filepos(a) - 1;
      bajaFisica(a);
      seek(a, pos);
    end
  end;

  close(a);
end;

var
  cod: integer;
  a: arch;

begin
  assign(a, 'discos.dat');

  writeln('Se ingresan por teclado codigos de discos sin stock: ');
  write('Ingrese codigo: ');
  readln(cod);
  while (cod <> FIN) do begin
    bajaLogica(a, cod);
    write('Ingrese codigo: ');
    readln(cod);
  end;
  compactar(a);
end.

