program ej1p3;

const
  FIN = 100000;

type
  planta = record
    cod: integer;
    nomVulgar, nomCient: string[30];
    altProm: real;
    desc: string[50];
    zona: string[20];
  end;

  arch = file of planta;

procedure bajaLogica(var a: arch; codBorrar: integer);
var
  encontre: boolean;
  reg: planta;
  posBorrar: integer;
begin
  seek(a, 0);
  encontre := false;

  while ((not eof(a)) and (not encontre)) do begin
    read(a, reg);
    if (reg.cod = codBorrar) then encontre := true;
  end;

  if (encontre) then begin
    posBorrar := filePos(a) - 1;
    reg.cod := -1;
    seek(a, posBorrar);
    write(a, reg);
  end;
end;

procedure compactar(var a: arch);
var
  aCompact: arch;
  reg: planta;
begin
  assign(aCompact, 'plantasCompact.dat');
  rewrite(aCompact);

  seek(a, 0);

  while (not eof(a)) do begin
    read(a, reg);
    if (reg.cod <> -1) then write(aCompact, reg);
  end;

  close(aCompact);
end;

procedure bajaFisica(var a: arch; codBorrar: integer);
var
  encontre: boolean;
  reg, aux: planta;
  posBorrar: integer;
begin
  seek(a, 0);
  encontre := false;

  while ((not eof(a)) and (not encontre)) do begin
    read(a, reg);
    if (reg.cod = codBorrar) then encontre := true;
  end;

  if (encontre) then begin
    posBorrar := filePos(a) - 1;
    seek(a, fileSize(a) - 1);
    read(a, aux);
    seek(a, posBorrar);
    write(a, aux);
    seek(a, fileSize(a) - 1);
    truncate(a);
  end;
end;

var
  cod, opc: integer;
  a: arch;

begin
  assign(a, 'plantas.dat');
  reset(a);

  writeln('Ingrese codigo de especie a eliminar: ');
  readln(cod);
  while (cod <> FIN) do begin
    writeln('Seleccione metodo de baja (1 logica 2 fisica): ');
    readln(opc);
    case opc of
      1: bajaLogica(a, cod);
      2: bajaFisica(a, cod);
    end;
    writeln('Ingrese codigo de especie a eliminar: ');
    readln(cod);
  end;

  compactar(a);

  close(a);
end.

