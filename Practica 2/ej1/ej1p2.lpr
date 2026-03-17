program ej1p2;

type
  empleado = record
    cod:integer;
    nomAp:string[20];
    fechaNacimiento:string[8];
    direccion:string[15];
    cantHijos:integer;
    tel:integer;
    diasVaca:integer;
  end;

  empleadoDetalle = record
    cod:integer;
    fecha:string[8];
  end;

  detalles = array[1..10] of empleadoDetalle;
  fMaestro = file of empleado;
  fDetalle = file of empleadoDetalle;
  fDetalles = array[1..10] of fDetalle;

procedure leer(var det:fDetalles; d:detalles);
begin
  if (not eof(detalle)) then read(detalle,detalles);
end;

procedure minimo(var det:detalles); //devuelve el archivo con el empleado con el codigo minimo
begin

end;

procedure actualizar(var m:fMaestro; var det:fDetalles);
var
  i:integer;
  d:detalles;
begin
  for i:=1 to 10 do
  begin
    reset(det[i]);
    leer(det[i], d[i]);
  end;
  reset(m);

  minimo(det, d);
end;

var
  m:fMaestro;
  det:fDetalles;

begin
  assign(m, 'empleados');
  assign(det[1], 'licenciaEmpleados1');
  assign(det[2], 'licenciaEmpleados2');
  assign(det[3], 'licenciaEmpleados3');
  assign(det[4], 'licenciaEmpleados4');
  assign(det[5], 'licenciaEmpleados5');
  assign(det[6], 'licenciaEmpleados6');
  assign(det[7], 'licenciaEmpleados7');
  assign(det[8], 'licenciaEmpleados8');
  assign(det[9], 'licenciaEmpleados9');
  assign(det[10], 'licenciaEmpleados10');

  actualizar(m, det):
end.
