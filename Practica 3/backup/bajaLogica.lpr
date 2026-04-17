program bajaLogica;

type
  str20 = string[20];
  persona = record
    ape, nom: str20;
    fechNac: longInt;
  end;

  arch = file of persona;

procedure bajaLogica(var a: arch; apBuscar, nomBuscar: str20);
var
  encontre: boolean;
  rp: persona;
  posBorrar: integer;
begin
  reset(a);
  encontre := false;

  while ((not eof(a)) and (not encontre)) do begin
    read(a, rp);
    if ((rp.ape = apBuscar) and (rp.nom = nomBuscar)) then encontre := true;
  end;

  if ((rp.ape = apBuscar) and (rp.nom = nomBuscar)) then begin
    posBorrar := filePos(a) - 1; // guarda la posicion del registro que queremos borrar
    rp.ape := '@';               // ponemos marca
    seek(a, posBorrar);          // volvemos a la posicion dle registro que queremos borrar
    write(a, rp);                // sobreescribimos el registro a borrar con la marca
  end;

  close(a);
end;

begin
end.

