program parcial;

type
  reg = record
    dni: longint;
    nom, ap: string[20];
    codH: integer;
    descH: string[50];
    fecha: string[8];
  end;

  tArch = file of reg;

procedure altas(var arch: tArch);
var
  r, cabecera: reg;
  nrrLibre: integer;
begin
  reset(arch);
  seek(arch, 0);
  read(r.dni); read(r.nom); read(r.ap); read(r.codH); read(r.descH); read(r.fecha);
  read(arch, cabecera);
  nrrLibre := -cabecera.dni;
  if (nrrLibre = 0) then seek(arch, filesize(arch))
  else begin
    seek(arch, nrrLibre);
    read(arch, cabecera);
    seek(arch, 0);
    write(arch, cabecera);
    seek(arch, nrrLibre);
  end;
  write(arch, r);

  close(arch);
end;

procedure bajas(var arch: tArch; var txt: text);
var
  r, cabecera, aux: reg;
  nrrLibre: integer;
  encontre: boolean;
begin
  reset(arch);
  append(txt);

  seek(arch, 0);
  encontre := false;
  read(arch, cabecera);
  read(r.dni); read(r.codH); read(r.fecha);

  while (not eof(arch)) and (not encontre) do begin
    read(arch, aux);
    if (aux.dni = r.dni) and (aux.codH = r.codH) and (aux.fecha = r.fecha) then encontre := true;
  end;

  if (encontre) then begin
    writeln(txt, r.dni);
    writeln(txt, aux.nom);
    writeln(txt, aux.ap);
    writeln(txt, r.codH);
    writeln(txt, aux.descH);
    writeln(txt, r.fecha);

    nrrLibre := filepos(arch) - 1;
    seek(arch, nrrLibre);
    aux.dni := cabecera.dni;
    write(arch, aux);
    seek(arch, 0);
    cabecera.dni := -nrrLibre;
    write(arch, cabecera);
  end;

  close(arch);
  close(txt);
end;

begin
end.
