program ejadicional;

const
  VALOR_ALTO = 9999;

type
  regM = record
    codProv, votos, votosB, votosA: integer;
    nomProv: string[15];
  end;

  regD = record
    codProv, codLoc, votos, votosB, votosA: integer;
  end;

  maestro = file of regM;

  detalle = file of regD;
  vecDetalles = array [1..500] of detalle;
  vecRegsDetalles = array [1..500] of regD;

procedure leer(var d: detalle; var rD: regD);
begin
  if (not eof(d)) then read(d, rD)
  else rD.codProv := VALOR_ALTO;
end;

procedure minimo(var min: regD; var dets: vecDetalles; var regsD: vecRegsDetalles);
var
  minPos, i: integer;
begin
  minPos := 1;
  min := regsD[1];

  for i := 2 to 500 do begin
    if (regsD[i].codProv < min.codProv) or
       (regsD[i].codProv = min.codProv) and (regsD[i].codLoc < min.codLoc) then begin
         min := regsD[i];
         minPos := i;
       end;
  end;

  if (min.codProv <> VALOR_ALTO) then leer(dets[minPos], regsD[minPos]);
end;

procedure actualizar;
var
  m: maestro;
  i, votos, votosV, votosB, votosA: integer;
  nomDet: string[15];
  dets: vecDetalles;
  regsD: vecRegsDetalles;
  txt: text;
  min: regD;
  rM: regM;
begin
  assign(m, 'maestro.dat');
  reset(m);
  for i := 1 to 500 do begin
    write('Ingrese un nombre para el detalle: ');
    readln(nomDet);
    assign(dets[i], nomDet);
    reset(dets[i]);
    leer(dets[i], regsD[i]);
  end;
  assign(txt, 'cantidad_votos_04_07_2023.txt');
  rewrite(txt);

  votos := 0;
  votosV := 0;
  votosB := 0;
  votosA := 0;

  minimo(min, dets, regsD);

  while (min.codProv <> VALOR_ALTO) do begin
    read(m, rM);
    while (rM.codProv <> min.codProv) do read(m, rM);

    while (rM.codProv = min.codProv) do begin
      rM.votos := rM.votos + min.votos;
      rM.votosB := rM.votosB + min.votosB;
      rM.votosA := rM.votosA + min.votosA;
      votos := votos + min.votos + min.votosB + min.votosA;
      votosV := votosV + min.votos;
      votosB := votosB + min.votosB;
      votosA := votosA + min.votosA;
      minimo(min, dets, regsD);
    end;
    seek(m, filepos(m) - 1);
    write(m, rM);
  end;
  writeln(txt, 'Cantidad de archivos procesados: ', 500);
  writeln(txt, 'Cantidad Total de votos: ', votos);
  writeln(txt, 'Cantidad de votos válidos: ', votosV);
  writeln(txt, 'Cantidad de votos anulados: ', votosA);
  writeln(txt, 'Cantidad de votos en blanco: ', votosB);

  close(m);
  for i := 1 to 500 do close(dets[i]);
  close(txt);
end;

begin
  actualizar;
end.
