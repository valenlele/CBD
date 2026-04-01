program ejemploUnMaestroNDetalles;

const
  ValorA = 9999;
  CANT_RESTOS = 17;

type
  cadenaResto = record
    codigo: integer;
    nombre: string[30];
    costo: real;
    fecha: longInt;
    cant_ven: integer;
  end;

  restoReg = record
    codigo: integer;
    cant_ven: integer;
  end;

  maestro = file of cadenaResto;
  fdetalle = file of restoReg;

  // Se definen los tipos arreglo para poder pasarlos por parametro
  arregloDetalles = array[1..CANT_RESTOS] of fdetalle;
  arregloRegistros = array[1..CANT_RESTOS] of restoReg;

procedure Leer(var det: fdetalle; var regDet: restoReg);
begin
  if (not eof(det)) then
    read(det, regDet)
  else
    regDet.codigo := ValorA;
end;

procedure minimo(var det: arregloDetalles; var res: arregloRegistros; var min: restoReg);
var
  i, posMin: integer;
begin
  min := res[1];
  posMin := 1;

  for i := 2 to CANT_RESTOS do begin
    if (res[i].codigo < min.codigo) then begin
      min := res[i];
      posMin := i;
    end;
  end;

  // Solo avanza el archivo si no se llegó al final de todos
  if (min.codigo <> ValorA) then
    Leer(det[posMin], res[posMin]);
end;

procedure Actualizar(var M: maestro; var det: arregloDetalles);
var
  i: integer;
  res: arregloRegistros;
  min: restoReg;
  regM: cadenaResto;
begin
  // Abrir detalles y leer el primer registro de cada uno
  for i := 1 to CANT_RESTOS do begin
    reset(det[i]);
    Leer(det[i], res[i]);
  end;

  reset(M);
  minimo(det, res, min);

  // Procesar mientras haya datos en algún detalle
  while (min.codigo <> ValorA) do begin
    read(M, regM);

    // Avanzar en el maestro hasta encontrar el código a actualizar
    while (regM.codigo <> min.codigo) do begin
      read(M, regM);
    end;

    // Sumar todas las ventas de ese código provenientes de distintos detalles
    while (regM.codigo = min.codigo) do begin
      regM.cant_ven := regM.cant_ven + min.cant_ven;
      minimo(det, res, min);
    end;

    // Reposicionar y sobrescribir el registro actualizado
    seek(M, filepos(M) - 1);
    write(M, regM);
  end;

  close(M);
  for i := 1 to CANT_RESTOS do
    close(det[i]);
end;

var
  M: maestro;
  det: arregloDetalles;
  nombreDet: string[20];
  i: integer;
begin
  for i := 1 to CANT_RESTOS do begin
    write('Escriba un nombre para el archivo detalle ', i, ': ');
    readln(nombreDet);
    assign(det[i], nombreDet);
  end;

  assign(M, 'maestro.dat');
  Actualizar(M, det);
end.
