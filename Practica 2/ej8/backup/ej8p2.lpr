program ej8p2;

const
  FIN = 9999;

type
  regD = record
    codZona: integer;
    nomZona: string[15];
    descZona: string[50];
    fecha: string[10];
    metrosConstruidos: real;
  end;

  regM = record
    codZona: integer;
    nomZona: string[15];
    metrosConstruidos: real;
  end;

  detalle = file of regD;

  arregloDetalles = array [1..15] of detalle;

  maestro = file of regM;

  arregloRegsD = array [1..15] of regD;

procedure crearDetalles(var d: arregloDetalles);
var
  i: integer;
  numStr: string;
  reg: regD;
begin
  for i := 1 to 15 do begin
    Str(i, numStr);
    assign(d[i], 'detalle' + numStr + '.dat');
    rewrite(d[i]);
  end;

  reg.codZona := 10; reg.nomZona := 'Norte'; reg.descZona := 'Av. 7 y 32'; reg.fecha := '2026-04-01'; reg.metrosConstruidos := 15.5; write(d[1], reg);
  reg.codZona := 20; reg.nomZona := 'Sur'; reg.descZona := 'Av. 7 y 72'; reg.fecha := '2026-04-02'; reg.metrosConstruidos := 20.0; write(d[1], reg);

  // Arquitecto 2 (detalle 2)
  reg.codZona := 10; reg.nomZona := 'Norte'; reg.descZona := 'Av. 7 y 32'; reg.fecha := '2026-04-05'; reg.metrosConstruidos := 5.0; write(d[2], reg);
  reg.codZona := 30; reg.nomZona := 'Oeste'; reg.descZona := 'Av. 44 y 131'; reg.fecha := '2026-04-10'; reg.metrosConstruidos := 10.5; write(d[2], reg);

  for i := 1 to 15 do close(d[i]);
end;

procedure leer(var det: detalle; var regDetalle: regD);
begin
  if (not eof(det)) then read(det, regDetalle)
  else regDetalle.codZona := FIN;
end;

procedure minimo(var d: arregloDetalles; var regsD: arregloRegsD; var min: regD);
var
  minPos, i: integer;
begin
  min := regsD[1];
  minPos := 1;

  for i := 2 to 15 do begin
    if (regsD[i].codZona < min.codZona) then begin
      min := regsD[i];
      minPos := i;
    end;
  end;
  if (min.codZona <> FIN) then leer(d[minPos], regsD[minPos]);
end;

procedure merge;
var
  d: arregloDetalles;
  i: integer;
  numStr: string;
  regsD: arregloRegsD;
  min: regD;
  m: maestro;
  rM: regM;
  descZona: string[50];
  archTxt: Text;
begin
  crearDetalles(d);

  for i := 1 to 15 do begin
    Str(i, numStr);
    assign(d[i], 'detalle' + numStr + '.dat');
    reset(d[i]);
    leer(d[i], regsD[i]);
  end;

  assign(m, 'maestro.dat');
  rewrite(m);

  assign(archTxt, 'infoTexto');
  rewrite(archTxt);

  minimo(d, regsD, min);

  while (min.codZona <> FIN) do begin
    rM.codZona := min.codZona;
    rM.nomZona := min.nomZona;
    rM.metrosConstruidos := 0;
    descZona := min.descZona;

    while (rM.codZona = min.codZona) do begin
      rM.metrosConstruidos := rM.metrosConstruidos + min.metrosConstruidos;
      minimo(d, regsD, min);
    end;

    writeln(archTxt, rm.codZona);
    writeln(archTxt, rm.nomZona);
    writeln(archTxt, descZona);
    writeln(archTxt, rm.metrosConstruidos);

    write(m, rM);
  end;

  close(m);

  for i := 1 to 15 do close(d[i]);

  close(archTxt);
end;

begin
  merge;
end.

