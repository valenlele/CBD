program ej3p2;

const
  cantArch = 20;
  valorAlto = 9999;

type
  regMaestro = record
    codCalzado, num: integer;
    desc: string[30];
    precio: real;
    color: string[15];
    stock, stockMin: integer;
  end;

  regDetalle = record
    codCalzado, num, cantVendida: integer;
  end;

  maestro = file of regMaestro;

  detalle = file of regDetalle;

  arregloDetalles = array [1..cantArch] of detalle;

  arregloRegD = array [1..cantArch] of regDetalle;

procedure leer(var d: detalle; var regD: regDetalle);
begin
  if (not eof(d)) then read(d, regD)
  else regD.codCalzado := valorAlto;
end;

procedure minimo(var d: arregloDetalles; var regsD: arregloRegD; var regMin: regDetalle);
var
  i, minPos: integer;
begin
  regMin := regsD[1];
  minPos := 1;

  for i := 2 to cantArch do begin
    if ((regsD[i].codCalzado < regMin.codCalzado) or ((regsD[i].codCalzado = regMin.codCalzado) and (regsD[i].num < regMin.num))) then begin
      regMin := regsD[i];
      minPos := i;
    end;
  end;

  if (regMin.codCalzado <> valorAlto) then leer(d[minPos], regsD[minPos]);
end;

procedure actualizar(var m: maestro; var d: arregloDetalles);
var
  regsD: arregloRegD;
  regMin: regDetalle;
  regM: regMaestro;
  archTxt: Text;
  i: integer;
begin
  reset(m);

  for i:= 1 to cantArch do begin
    reset(d[i]);
    leer(d[i], regsD[i]);
  end;

  assign(archTxt, 'calzadossinstock.txt');
  rewrite(archTxt);

  minimo(d, regsD, regMin);

  while (regMin.codCalzado <> valorAlto) do begin
    read(m, regM);

    while (regM.codCalzado <> regMin.codCalzado) or (regM.num <> regMin.num) do begin
      writeln('El calzado con codigo ', regM.codCalzado,' y numero ', regM.num, ' no se vendio');
      read(m, regM);
    end;

    while ((regM.codCalzado = regMin.codCalzado) and (regM.num = regMin.num)) do begin
      regM.stock:= regM.stock - regMin.cantVendida;
      if (regM.stock < regM.stockMin) then writeln(archTxt, regM.codCalzado,' ', regM.num);
      minimo(d, regsD, regMin);
    end;

    seek(m, filepos(m) - 1);
    write(m, regM);
  end;

  while (not eof(m)) do begin
    writeln('El calzado con codigo ', regM.codCalzado,' y numero ', regM.num, ' no se vendio');
    read(m, regM);
  end;

  close(m);
  for i := 1 to cantArch do close(d[i]);
  close(archTxt);
end;

{procedure cargarMaestro(var r: regMaestro; cod, num: integer; desc: string; p: real; col: string; st, stMin: integer);
begin
  r.codCalzado := cod;
  r.num := num;
  r.desc := desc;
  r.precio := p;
  r.color := col;
  r.stock := st;
  r.stockMin := stMin;
end;

procedure cargarDetalle(var r: regDetalle; cod, num, cant: integer);
begin
  r.codCalzado := cod;
  r.num := num;
  r.cantVendida := cant;
end;}

var
  m: maestro;
  d: arregloDetalles; //comentar cuando creo archivos
  i: integer;
  numStr: string; //comentar cuando creo archivos

  {regM:regMaestro;
  regD: regDetalle;
  numStr: string;
  d: file of regDetalle;}

begin
  assign(m, 'maestro.dat');

  for i := 1 to cantArch do begin
    Str(i, numStr);
    assign(d[i], 'detalle' + numStr+ '.dat');
  end;

  actualizar(m, d);
  readln;

  {assign(m, 'maestro.dat');
  rewrite(m);

  cargarMaestro(regM, 100, 38, 'Zapatilla Running', 50000.0, 'Negro', 50, 10);
  write(m, regM);
  cargarMaestro(regM, 100, 39, 'Zapatilla Running', 50000.0, 'Negro', 15, 10);
  write(m, regM);

  cargarMaestro(regM, 105, 40, 'Zapato Vestir', 80000.0, 'Marron', 20, 5);
  write(m, regM);

  cargarMaestro(regM, 110, 41, 'Borcego', 90000.0, 'Negro', 10, 5);
  write(m, regM);

  close(m);

  for i := 1 to 20 do begin
    Str(i, numStr);
    assign(d, 'detalle' + numStr + '.dat');
    rewrite(d);

    if (i = 1) then begin
      cargarDetalle(regD, 100, 38, 5);
      write(d, regD);
      cargarDetalle(regD, 100, 39, 10);
      write(d, regD);
    end;

    if (i = 5) then begin
      cargarDetalle(regD, 100, 38, 3);
      write(d, regD);
      cargarDetalle(regD, 110, 41, 4);
      write(d, regD);
    end;

    if (i = 20) then begin
      cargarDetalle(regD, 110, 41, 2);
      write(d, regD);
    end;

    close(d);
  end;}
end.
