program ej7p2;

const
  FIN = 9999;

type
  regMaestro = record
    codProd: integer;
    nomProd: string[20];
    desc: string[30];
    precio: real;
    stock, stockMin: integer;
  end;

  regDetalle = record
    codProd, cantVentas: integer;
  end;

  maestro = file of regMaestro;

  detalle = file of regDetalle;

  arregloDetalles = array [1..10] of detalle;

  arregloRegsDetalle = array [1..10] of regDetalle;

procedure crearMaestro(var m: maestro);
var
  archTxt: Text;
  regM: regMaestro;
begin
  assign(m, 'maestro.dat');
  rewrite(m);

  assign(archTxt, 'productos.txt');
  reset(archTxt);

  while (not eof(archTxt)) do begin
    readln(archTxt, regM.codProd);
    readln(archTxt, regM.nomProd);
    readln(archTxt, regM.desc);
    readln(archTxt, regM.precio);
    readln(archTxt, regM.stock);
    readln(archTxt, regM.stockMin);
    write(m, regM);
  end;

  close(archTxt);
  close(m);
end;

procedure crearDetalles();
var
  i: integer;
  numStr: string;
  det: detalle;
  regD: regDetalle;
begin
  for i := 1 to 10 do begin
    Str(i, numStr);
    assign(det, 'detalle' + numStr + '.dat');
    rewrite(det);

    // Carga de datos de prueba
    if (i mod 2 = 0) then begin
      regD.codProd := 5; regD.cantVentas := 2; write(det, regD);
      regD.codProd := 10; regD.cantVentas := 1; write(det, regD);
    end else begin
      regD.codProd := 5; regD.cantVentas := 3; write(det, regD);
      regD.codProd := 15; regD.cantVentas := 5; write(det, regD);
    end;

    close(det);
  end;
end;

procedure leer(var det: detalle; var regD: regDetalle);
begin
  if (not eof(det)) then read(det, regD)
  else regD.codProd := FIN;
end;

procedure minimo(var d: arregloDetalles; var regsD: arregloRegsDetalle; var min: regDetalle);
var
  minPos, i: integer;
begin
  min := regsD[1];
  minPos := 1;

  for i := 2 to 10 do begin
    if (regsD[i].codProd < min.codProd) then begin
      min := regsD[i];
      minPos := i;
    end;
  end;

  if (min.codProd <> FIN) then leer(d[minPos], regsD[minPos]);
end;

procedure actMaestro(var m: maestro);
var
  i: integer;
  numStr: string;
  d: arregloDetalles;
  regsD: arregloRegsDetalle;
  min: regDetalle;
  regM: regMaestro;
begin
  assign(m, 'maestro.dat');
  reset(m);

  crearDetalles();

  for i := 1 to 10 do begin
    Str(i, numStr);
    assign(d[i], 'detalle' + numStr + '.dat');
    reset(d[i]);
    leer(d[i], regsD[i]);
  end;

  minimo(d, regsD, min);

  while (min.codProd <> FIN) do begin
    read(m, regM);

    while (regM.codProd <> min.codProd) do read(m, regM);

    while (regM.codProd = min.codProd) do begin
      regM.stock := regM.stock - min.cantVentas;
      minimo(d, regsD, min);
    end;

    seek(m, filepos(m) - 1);
    write(m, regM);
  end;

  close(m);
  for i := 1 to 10 do close(d[i]);
end;

var
  opc: integer;
  m: maestro;

begin
  writeln('Ingrese una opcion: ');
  writeln('1: Crear el archivo maestro a partir de un archivo de texto llamado "productos.txt".');
  writeln('2: Actualizar el archivo maestro con los archivos detalle.');
  writeln('0: terminar programa');
  readln(opc);

  while (opc <> 0) do begin
    case opc of
      1: crearMaestro(m);
      2: actMaestro(m);
    end;
    writeln('Ingrese una opcion: ');
    writeln('1: Crear el archivo maestro a partir de un archivo de texto llamado "productos.txt".');
    writeln('2: Actualizar el archivo maestro con los archivos detalle.');
    writeln('0: terminar programa');
    readln(opc);
  end;

end.
