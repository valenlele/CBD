program bajaFisica;

type
  str20 = string[20];
  persona = record
    ape, nom: str20;
    fechNac: longInt;
  end;

  arch = file of persona;

procedure bajaFisica(var a: arch; apBuscar, nomBuscar: str20);
var
  encontre: boolean;
  rp, aux: persona;
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
    seek(a, fileSize(a) - 1);       // mueve el puntero del archivo al ultimo registro del archivo (filesize - 1 porque el ultimo es EOF)
    read(a, aux);                // lee el ultimo registro y lo guarda en aux
    seek(a, posBorrar);          // volvemos a la posicion dle registro que queremos borrar
    write(a, aux);               // sobreescribimos ese registro con el ultimo registro del archivo
    seek(a, fileSize(a) - 1);    // volvemos al final del archivo
    truncate(a);                 // corta el archivo en la posicion donde se encuentra el puntero
  end;

  close(a);
end;

begin
end.

