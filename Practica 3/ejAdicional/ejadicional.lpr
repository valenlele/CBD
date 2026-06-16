program ejadicional;

type
  reg = record
    dni: longint;
    nom, ap, especialidad: string[20];
    fecha: string[8];
  end;

  archivo = file of reg;

procedure alta(var arch: archivo);
var
  nrrLibre: integer;
  r, cabecera: reg;
begin
  seek(arch, 0);

  read(r.ap);
  read(r.nom);
  read(r.especialidad);
  read(r.fecha);
  read(r.dni);

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
end;

procedure baja(var arch: archivo; var txt:text);
var
  nrrLibre: integer;
  cabecera, r, aux: reg;
  encontre: boolean;
begin
  reset(txt);
  readln(txt, r.dni);
  readln(txt, r.nom);
  readln(txt, r.ap);
  readln(txt, r.fecha);

  while (not eof(txt)) do begin
    seek(arch, 0);
    read(arch, cabecera);
    encontre := false;

    while (not eof(arch)) and (not encontre) do begin
      read(arch, aux);
      if (aux.dni = r.dni) then encontre := true;
    end;

    if (encontre) then begin
      nrrLibre := filepos(arch) - 1;
      seek(arch, nrrLibre);
      aux.dni := cabecera.dni;
      write(arch, aux);
      seek(arch, 0);
      cabecera.dni := -nrrLibre;
      write(arch, cabecera);
    end;

    readln(txt, r.dni);
    readln(txt, r.nom);
    readln(txt, r.ap);
    readln(txt, r.fecha);
  end;
  close(txt);
end;

begin
end.

