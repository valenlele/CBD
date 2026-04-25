program ej7p3;

Type
  persona= Record
    DNI:integer;
    nombre: String[20];
    apellido:String[20];
    sueldo: real;
  end;
  tArchivo = File of persona;

Procedure crear(var arch: tArchivo; var info:TEXT);
var
  p: persona;
begin
  reset(info);
  rewrite(arch);

  p.DNI := 0;
  write(arch, p);

  while (not eof(info)) do begin
    readln(info, p.dni);
    readln(info, p.nombre);
    readln(info, p.apellido);
    readln(info, p.sueldo);
    write(arch, p);
  end;
end;

Procedure agregar (var arch: tArchivo; p: persona);
var
  nLibre: integer;
  reg, rLibre: persona;
begin
  seek(arch, 0);

  read(arch, reg);
  nLibre := -reg.dni;

  if (nLibre = 0) then seek(arch, filesize(arch))
  else begin
    seek(arch, nLibre);
    read(arch, rLibre);
    seek(arch, 0);
    write(arch, rLibre);
    seek(arch, nLibre);
  end;

  write(arch, p);
end;

Procedure eliminar (var arch: tArchivo; DNI: integer);
var
  encontre: boolean;
  rLibre, reg: persona;
  nLibre: integer;
begin
  seek(arch, 0);

  read(arch, rLibre);
  encontre := false;

  while (not eof(arch)) and (not encontre) do begin
    read(arch, reg);
    if (reg.dni = dni) then encontre := true;
  end;
  if (encontre) then begin
    nLibre := filepos(arch) - 1;
    seek(arch, nLibre);
    reg.dni := rLibre.dni;
    write(arch, reg);
    seek(arch, 0);
    rLibre.dni := nLibre;
    write(arch, rLibre);
  end;
end;

begin
end.

