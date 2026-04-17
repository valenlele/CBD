program altasYBajas;

type
  tRaza = string[50];
  tArchRaza = file of tRaza;

procedure eliminarRaza(var a: tArchRaza; razaABorrar: tRaza);
var
  encontre: boolean;
  r, sLibre: tRaza;
  nLibre: integer;
begin
  reset(a);
  encontre := false;

  read(a, sLibre); // guarda la posicion del primer espacio libre. la primera vez es -1. no hay huecos libres

  while ((not eof(a)) and (encontre = false)) do begin
    read(a, r);
    if (r = razaABorrar) then encontre := true;
  end;

  if (encontre) then begin
    nLibre := filePos(a) - 1;

    seek(a, nLibre);

    write(a, sLibre); // escribo en el registro que quiero borrar el puntero que tenia la cabecera

    Str(nLibre, sLibre); // escribo como texto la primera posicion libre para guardarla en la cabecera

    seek(a, 0); // vamos a la cabecera
    write(a, sLibre);
  end;
end;

procedure agregarRaza(var a: tArchRaza; nuevaRaza: tRaza);
var
  sLibre: tRaza; // registro cabezera.
  nLibre, codError: integer;
begin
  reset(a);

  read(a, sLibre); // leemos la cabecera para saber si hay huecos
  Val(sLibre, nLibre, codError); // convertimos en un numero el valor de la cabecera

  if (nLibre = -1) then seek(a, fileSize(a))  // no hay registros borrados. el nuevo registro va al final
  else begin
    seek(a, nLibre); // vamos a la posicion de la cabecera de la pila (primer espacio libre, ultimo borrado)

    read(a, sLibre); // leemos lo que hay dentro de ese hueco (direccion del siguiente hueco)

    seek(a, 0);

    write(a, sLibre); // actualizamos cabecera

    seek(a, nLibre); // volvemos al hueco original

  end;

  write(a, nuevaRaza);
end;

begin
end.

