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

  fMaestro = file of empleado;
  fDetalle = file of empleadoDetalle;
  detalles = array[1..10] of fDetalle;

var
  m:fMaestro;
  det:detalles;
  i:integer;
  regM:empleado;
  regD:empleadoDetalle;

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

  reset(m);
  for i:=1 to 10 do reset(det[i]);
end.

