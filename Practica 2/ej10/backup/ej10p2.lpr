program ej10p2;

const
  FIN = 99999;

type
  regM = record
    cod: integer;
    nom: string[20];
    desc: string[50];
    precio: real;
    ventas, maxVentas: integer;
  end;

  regD = record
    cod, ventas: integer;
  end;

  maestro = file of regM;

  detalle = file of regD;

  arregloDetalles = array [1..8] of detalle;

  arregloRegsDetalle = array [1..8] of regD;

procedure crearMaestro(var m: maestro);
var
  reg: regM;
begin
  assign(m, 'maestro.dat');
  rewrite(m);

  reg.cod := 10; reg.nom := 'Heladera'; reg.desc := 'No Frost'; reg.precio := 500000; reg.ventas := 100; reg.maxVentas := 20;
  write(m, reg);

  reg.cod := 20; reg.nom := 'Microondas'; reg.desc := '20 Litros'; reg.precio := 150000; reg.ventas := 50; reg.maxVentas := 5;
  write(m, reg);

  close(m);
end;

procedure crearDetalles(var d: arregloDetalles);
var
  i: integer;
  numStr: string;
  reg: regD;
begin
  for i := 1 to 8 do begin
    Str(i, numStr);
    assign(d[i], 'detalle' + numStr + '.dat');
    rewrite(d[i]);

    // Solo cargamos ventas en algunas sucursales para probar
    if (i mod 2 = 0) then begin
      reg.cod := 10; reg.ventas := 5; write(d[i], reg);
      reg.cod := 20; reg.ventas := 2; write(d[i], reg);
    end else begin
      reg.cod := 10; reg.ventas := 3; write(d[i], reg);
    end;

    close(d[i]);
  end;
end;

procedure leer(var det: detalle; var rD: regD);
begin
  if (not EOF(det)) then read(det, rD)
  else rD.cod := FIN;
end;

procedure minimo(var d: arregloDetalles; var regsD: arregloRegsDetalle; var min: regD);
var
  minPos, i: integer;
begin
  min := regsD[1];
  minPos := 1;

  for i := 2 to 8 do begin
    if (regsD[i].cod < min.cod) then begin
      min := regsD[i];
      minPos := i;
    end;
  end;

  if (min.cod <> FIN) then leer(d[minPos], regsD[minPos]);
end;

procedure actualizar(var m: maestro);
var
  d: arregloDetalles;
  i: integer;
  numStr: string;
  regsD: arregloRegsDetalle;
  min: regD;
  rM: regM;
  ventasMesAct: integer;
begin
  {crearMaestro(m);

  crearDetalles(d);}

  assign(m, 'maestro.dat');
  reset(m);

  for i := 1 to 8 do begin
    Str(i, numStr);
    assign(d[i], 'detalle' + numStr + '.dat');
    reset(d[i]);
    leer(d[i], regsD[i]);
  end;

  minimo(d, regsD, min);

  while (min.cod <> FIN) do begin
    read(m, rM);

    while (rM.cod <> min.cod) do read(m, rM);

    ventasMesAct := 0;
    while (rM.cod = min.cod) do begin
      ventasMesAct := ventasMesAct + min.ventas;
      minimo(d, regsD, min);
    end;

    rM.ventas := rm.Ventas + ventasMesAct;

    if (ventasMesAct > rM.maxVentas) then begin
      writeln('Codigo producto: ', rM.cod);
      writeln('Nombre producto: ', rM.nom);
      writeln('Mayor cantidad vendida el mes anterior: ', rM.maxVentas);
      writeln('Mayor cantidad vendida actual:', ventasMesAct);
      rM.maxVentas := ventasMesAct;
    end;

    seek(m, filepos(m) - 1);
    write(m, rM);
  end;

  close(m);

  for i := 1 to 8 do close(d[i]);
end;

var
  m: maestro;

begin
  actualizar(m);
  readln;
end.

