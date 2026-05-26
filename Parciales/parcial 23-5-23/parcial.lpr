program parcial;

type
  profesional = record
    DNI: integer;
    nombre: String;
    apellido: String;
  end;
  tArchivo = File of profesional;

procedure crear(var arch: tArchivo; var info:TEXT);
var
  reg: profesional;
begin
  rewrite(arch);
  reset(info);

  reg.DNI := 0;
  write(arch, reg);

  while (not eof(info)) do begin
    readln(info, reg.DNI);
    readln(info, reg.nombre);
    readln(info, reg.apellido);
    write(arch, reg);
  end;

  close(info);
  close(arch);
end;

procedure agregar(var arch: tArchivo; p:profesional);
var
  rLibre: integer;
  cabecera, reg: profesional;
begin
  seek(arch, 0);

  read(arch, reg);
  rLibre := -reg.DNI;

  if (rLibre = 0) then seek(arch, filesize(arch))
  else begin
    seek(arch, rLibre);
    read(arch, cabecera);
    seek(arch, 0);
    write(arch, cabecera);
    seek(arch, rLibre);
  end;
  write(arch, p);
end;

procedure eliminar(var arch: tArchivo; DNI: integer; var bajas: TEXT);
var
  encontre: boolean;
  cabecera, reg: profesional;
  rLibre: integer;
begin
  append(bajas);
  seek(arch, 0);
  encontre := false;
  read(arch, cabecera);

  while (not eof(arch)) and (not encontre) do begin
    read(arch, reg);
    if (reg.DNI = DNI) then encontre := true;
  end;

  if (encontre) then begin
    writeln(bajas, reg.DNI);
    writeln(bajas, reg.nombre);
    writeln(bajas, reg.apellido);

    rLibre := filepos(arch) - 1;
    seek(arch, rLibre);
    write(arch, cabecera);
    seek(arch, 0);
    cabecera.DNI := rLibre * (-1);
    write(arch, cabecera);
  end;
  close(bajas);
end;

begin
end.

