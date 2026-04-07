program ej4p2;

const
  CANT_DETALLES = 20;
  VALOR_ALTO = 9999;

type
  pelicula = record
    cod:integer;
    nom:string[30];
    genero:string[15];
    director:string[30];
    duracion:integer;
    fecha:string[10];
    asistencia:integer;
  end;

  fPelicula = file of pelicula;

  arregloDetalles = array [1..CANT_DETALLES] of fPelicula;

  arregloRegsDetalle = array [1..CANT_DETALLES] of pelicula;

procedure leer(var det: fPelicula; var p: pelicula);
begin
  if (not eof(det)) then read(det, p)
  else p.cod := VALOR_ALTO;
end;

procedure minimo(var d: arregloDetalles; var min: pelicula; var regsD: arregloRegsDetalle);
var
  i, posMin:integer;
begin
  min := regsD[1];
  posMin := 1;

  for i := 2 to CANT_DETALLES do begin
    if (regsD[i].cod < min.cod) then begin
      min := regsD[i];
      posMin := i;
    end;
  end;

  if (min.cod <> VALOR_ALTO) then leer(d[posMin], regsD[posMin]);
end;

procedure merge(var d: arregloDetalles; ruta:string);
var
  m: fPelicula;
  regsD: arregloRegsDetalle;
  i: integer;
  min: pelicula;
  numStr: string;
  p: pelicula;

  det: file of pelicula;
begin
  for i := 1 to CANT_DETALLES do begin
    Str(i, numStr);
    assign(det, 'detalle ' + numStr + '.dat');
    rewrite(det);
  end;

  p.cod := 10;
  p.nom := 'taxi driver';
  p.genero := 'drama';
  p.director := 'martin scorsese';
  p.duracion := 120;
  p.fecha := '2026-04-01';
  p.asistencia := 50;
  write(det, p);

  p.asistencia := 25;
  write(det, p);

  {for i := 1 to CANT_DETALLES do begin
    Str(i, numStr);
    assign(d[i], 'detalle ' + numStr + '.dat');
  end;

  assign(m, ruta);
  rewrite(m);

  for i := 1 to CANT_DETALLES do begin
    reset(d[i]);
    leer(d[i], regsD[i]);
  end;

  minimo(d, min, regsD);

  while (min.cod <> VALOR_ALTO) do begin
    p.cod := min.cod;
    p.nom := min.nom;
    p.genero := min.genero;
    p.director := min.director;
    p.duracion := min.duracion;
    p.fecha := min.fecha;
    p.asistencia := 0;

    while (min.cod = p.cod) do begin
      p.asistencia := p.asistencia + min.asistencia;
      minimo(d, min, regsD);
    end;

    write(m, p);
  end;

  close(m);

  for i := 1 to CANT_DETALLES do close(d[i]);}
end;

var
  d: arregloDetalles;

begin
  merge(d, 'maestroSemanal.dat');
  readln;
end.
