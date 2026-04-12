program ej9p2;

const
  FIN = 99999999;

type
  regD = record
    dni: longInt;
    apNom: string[20];
    km: integer;
    gano: boolean;
  end;

  regM = record
    dni: longInt;
    apNom: string[20];
    kmTot: integer;
    carrerasWin: integer;
  end;

  detalle = file of regD;

  maestro = file of regM;

  arregloDetalles = array [1..5] of detalle;

  arregloRegsDetalle = array[1..5] of regD;

procedure crearDetalles(var d: arregloDetalles);
var
  i: integer;
  numStr: string;
  reg: regD;
begin
  for i := 1 to 5 do begin
    Str(i, numStr);
    assign(d[i], 'detalle' + numStr + '.dat');
    rewrite(d[i]);
  end;

  // Corredor 1 (Corre en detalle 1 y 2)
  reg.dni := 100; reg.apNom := 'Perez Juan'; reg.km := 10; reg.gano := true;
  write(d[1], reg);
  reg.dni := 100; reg.apNom := 'Perez Juan'; reg.km := 21; reg.gano := false;
  write(d[2], reg);

  // Corredor 2 (Corre en detalle 3 y 5)
  reg.dni := 200; reg.apNom := 'Gomez Ana'; reg.km := 42; reg.gano := true;
  write(d[3], reg);
  reg.dni := 200; reg.apNom := 'Gomez Ana'; reg.km := 10; reg.gano := true;
  write(d[5], reg);

  for i := 1 to 5 do close(d[i]);
end;

procedure leer(var det: detalle; var rD: regD);
begin
  if (not EOF(det)) then read(det, rD)
  else rD.dni := FIN;
end;

procedure minimo(var d: arregloDetalles; var regsD: arregloRegsDetalle; var min: regD);
var
  minPos, i: integer;
begin
  min := regsD[1];
  minPos := 1;

  for i := 2 to 5 do begin
    if (regsD[i].dni < min.dni) then begin
      min := regsD[i];
      minPos := i;
    end;
  end;

  if (min.dni <> FIN) then leer(d[minPos], regsD[minPos]);
end;

procedure merge;
var
  i: integer;
  d: arregloDetalles;
  numStr: string;
  regsD: arregloRegsDetalle;
  m: maestro;
  min: regD;
  rM: regM;
begin
  crearDetalles(d);

  {for i := 1 to 5 do begin
    Str(i, numStr);
    assign(d[i], 'detalle' + numStr + '.dat');
    reset(d[i]);
    leer(d[i], regsD[i]);
  end;

  assign(m, 'maestro.dat');
  rewrite(m);

  minimo(d, regsD, min);

  while (min.dni <> FIN) do begin
    rM.dni := min.dni;
    rM.apNom := min.apNom;
    rM.kmTot := 0;
    rM.carrerasWin := 0;

    while (rM.dni = min.dni) do begin
      rM.kmTot := rM.kmTot + min.km;
      if (min.gano) then rM.carrerasWin := rM.carrerasWin + 1;
      minimo(d, regsD, min);
    end;

    write(m, rM);
  end;

  close(m);

  for i := 1 to 5 do close(d[i]);}
end;

begin
  merge;
end.
