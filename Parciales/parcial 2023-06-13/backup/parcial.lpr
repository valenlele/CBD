program parcial;

const
  VALOR_ALTO = 9999;

type
  regM = record
    anio, mes, totMonto, totVentas: integer;
  end;

  regD = record
    anio, mes, dia, codMarca, codModelo, monto: integer;
    marca, modelo, color: string[15];
    dni: longint;
  end;

  maestro = file of regM;

  detalle = file of regD;

  vecDetalles = array [1..20] of detalle;
  vecRegsDetalle = array[1..20] of regD;

procedure leer(var d:detalle; var rD: regD);
begin
  if (not eof(d)) then read(d, rD)
  else rD.anio := VALOR_ALTO;
end;

procedure minimo(var min: regD; var dets: vecDetalles; var regsD: vecRegsDetalle);
var
  i, minPos: integer;
begin
  minPos := 1;
  min := regsD[1];

  for i := 2 to 20 do begin
    if (regsD[i].anio < min.anio) or
       (regsD[i].anio = min.anio) and (regsD[i].mes < min.mes) or
       (regsD[i].anio = min.anio) and (regsD[i].mes = min.mes) and (regsD[i].dia < min.dia) or
       (regsD[i].anio = min.anio) and (regsD[i].mes = min.mes) and (regsD[i].dia = min.dia) and (regsD[i].marca < min.marca) or
       (regsD[i].anio = min.anio) and (regsD[i].mes = min.mes) and (regsD[i].dia = min.dia) and (regsD[i].marca = min.marca) and (regsD[i].modelo < min.modelo) then begin
      min := regsD[i];
      minPos := i;
    end;
  end;
  if (min.anio <> VALOR_ALTO) then  leer (dets[minPos], regsD[minPos]);
end;

procedure merge;
var
  m: maestro;
  txt: text;
  dets: vecDetalles;
  regsDet: vecRegsDetalle;
  min, rD: regD;
  rM: regM;
  i, maxVentas, minVentas, totVentas, totMonto, totVentasModelo: integer;
  nomDet, minModeloVentas, maxModeloVentas, marcaAct, modeloAct: string[15];
begin
  assign(m, 'maestro.dat');
  rewrite(m);
  for i := 1 to 20 do begin
    write('Ingrese el nombre del detalle: ');
    readln(nomDet);
    assign(dets[i], nomDet);
    reset(dets[i]);
    leer(dets[i], regsDet[i]);
  end;
  assign(txt, 'informe.txt');
  rewrite(txt);

  minimo(min, dets, regsDet);

  while (min.anio <> VALOR_ALTO) do begin
    rM.anio := min.anio;
    while (min.anio = rM.anio) do begin
      totVentas := 0;
      totMonto := 0;
      rM.mes := min.mes;
      while (min.anio = rM.anio) and (min.mes = rM.mes) do begin
        rD.dia := min.dia;
        while (min.anio = rM.anio) and (min.mes = rM.mes) and (min.dia = rD.dia) do begin
          marcaAct := min.marca;
          maxVentas := -1;
          minVentas := 9999;
          while (min.anio = rM.anio) and (min.mes = rM.mes) and (min.dia = rD.dia) and (min.marca = marcaAct) do begin
            modeloAct := min.modelo;
            totVentasModelo := 0;
            while (min.anio = rM.anio) and (min.mes = rM.mes) and (min.dia = rD.dia) and (min.marca = marcaAct) and (min.modelo = modeloAct) do begin
              totVentas := totVentas + 1;
              totMonto := totMonto + min.monto;
              totVentasModelo := totVentasModelo + 1;
              minimo(min, dets, regsDet);
            end;
            if (totVentasModelo > maxVentas) then begin
              maxVentas := totVentasModelo;
              maxModeloVentas := modeloAct;
            end;
            if (totVentasModelo < minVentas) then begin
              minVentas := totVentasModelo;
              minModeloVentas := modeloAct;
            end;
          end;
          writeln(txt, marcaAct);
          writeln(txt, maxModeloVentas, maxVentas);
          writeln(txt, minModeloVentas, minVentas);
        end;
      end;
      rM.totMonto := totMonto;
      rM.totVentas := totVentas;
      write(m, rM);
    end;
  end;
  close(m);
  for i := 1 to 20 do close(dets[i]);
  close(txt);
end;

begin
  merge;
end.
