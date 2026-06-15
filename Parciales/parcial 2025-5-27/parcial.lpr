program parcial;

type
  reg = record
    dni, codHerram: integer;
    nom, ap: string[20];
    descHerram: string[50];
    fecha: string[8];
  end;

  archivo = file of reg;

procedure alta(var arch: archivo); //asumo que se hizo el assign y apertura del arch
var
  cabecera: reg;
  rLibre: integer;
begin
  reset(arch);
  seek(arch, 0);
  read(arch, cabecera);
  rLibre:= -cabecera.DNI;
  if (rLibre = 0) then seek(arch, filepos(arch))
  else begin
    seek(arch, rLibre);
    read(arch, cabecera);
    seek(arch, 0);
    write(arch, cabecera);
    seek(arch, rLibre);
  end;
  write(arch, cabecera);
end;

procedure baja(var arch: archivo); //asumo que se hizo el assign del .txt
var
  bajas: text;
  cabecera, rBaja, r: reg;
  rLibre: integer;
  encontre: boolean;
begin
  append(bajas);
  encontre := false;
  seek(arch, 0);
  read(arch, cabecera);
  writeln('Se lee el registro a borrar: ');
  read(rBaja.dni);
  read(rBaja.nom);
  read(rBaja.ap);
  read(rBaja.codHerram);
  read(rBaja.descHerram);
  read(rBaja.fecha);
  while (not eof(arch)) and (not encontre) do begin
    read(arch, r);
    if (r.dni = rBaja.dni) and (r.nom = rBaja.nom) and (r.ap = rBaja.ap) and (r.codHerram = rBaja.codHerram) and (r.descHerram = rBaja.descHerram) and (r.fecha = rBaja.fecha) then encontre := true;
  end;
  if (encontre) then begin
    rLibre := filepos(arch) - 1;
    seek(arch, rLibre);
    write(arch, cabecera);
    seek(arch, 0);
    cabecera.dni := -rLibre;
    write(arch, cabecera);
    writeln(bajas, rBaja.dni);
    writeln(bajas, rBaja.nom);
    writeln(bajas, rBaja.ap);
    writeln(bajas, rBaja.codHerram);
    writeln(bajas, rBaja.descHerram);
    writeln(bajas, rBaja.fecha);
  end;
  close(bajas);
end;

begin
end.
