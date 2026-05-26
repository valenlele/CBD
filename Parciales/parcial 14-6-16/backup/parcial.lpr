program parcial;

const
  FIN = 9999;

type
  regM = record
    cod: integer;
    nom: string[20];
    desc: string[100];
    stock: integer;
  end;

  regD = record
    cod: integer;
    ventas: integer;
  end;

  maestro = file of regM;

  detalle = file of regD;
  arregloDetalles = array [1..50] of detalle;
  arregloRegsDetalle = array [1..50] of regD;

procedure leer(var d: detalle; var rD: regD);
begin
  if (not eof(d)) then read(d, rD)
  else rD.cod := FIN;
end;

procedure minimo(var min: regD; var regsD: arregloRegsDetalle; var d: arregloDetalles);
var
  minPos, i: integer;
begin
  min := regsD[1];
  minPos := 1;

  for i := 2 to 50 do begin
    if (regsD[i].cod < min.cod) then begin
      min := regsD[i];
      minPos := i;
    end;
  end;

  if (regsD[minPos].cod <> FIN) then read(d[minPos], regsD[minPos]);
end;

procedure actualizar(var m: maestro);
var
  i: integer;
  iStr: string;
  d: arregloDetalles;
  regsD: arregloRegsDetalle;
  min: regD;
  rM: regM;
begin
  assign(m, 'maestro.dat');
  reset(m);

  for i := 1 to 50 do begin
    Str(i, iStr);
    assign(d[i], 'detalle' + iStr + '.dat');
    reset(d[i]);
    leer(d[i], regsD[i]);
  end;

  minimo(min, regsD, d);

  while (min.cod <> FIN) do begin
    read(m, rM);
    while (rM.cod <> min.cod) do read(m, rM);

    while (min.cod = rM.cod) do begin
      rM.stock := rM.stock - min.ventas;
      minimo(min, regsD, d);
    end;

    seek(m, filepos(m) - 1);
    write(m, rm);
  end;

  close(m);

  for i := 1 to 50 do close(d[i]);
end;

var
  m: maestro;

begin
  actualizar(m);
end.

