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
begin
  for i := 1 to 15 do begin
    Str(i, numStr);
    assign(d[i], 'detalle' + numStr + '.dat');
    rewrite(d[i]);
  end;

  //asignar datos

  for i := 1 to 15 do close(d[i]);
end;

procedure minimo(var d: arregloDetalles; var regsD: arregloRegsD; var min: regD);
begin

end;

procedure merge;
var
  d: arregloDetalles;
  i: integer;
  numStr: string;
  regsD: arregloRegsD;
  min: regD;
begin
  //crearDetalles(d);

  for i := 1 to 15 do begin
    assign(d[i], 'detalle' + numStr + '.dat');
    reset(d[i]);
    leer(d[i], regsD);
  end;

  assign(m, 'maestro.dat');
  rewrite(m);

  minimo(d, regsD, min);

  while (min.codZona <> FIN) do begin

  end;

  close(m);

  for i := 1 to 15 do close(d[i]);
end;

begin
  merge;
end.

