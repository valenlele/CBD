program ej1p2;

const
  CANT_DETALLES = 10;
  valorAlto = 9999;

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
    diasVacaSolicitados:integer;
  end;

  maestro = file of empleado;
  arregloRegistrosDetalles = array[1..CANT_DETALLES] of empleadoDetalle;
  detalle = file of empleadoDetalle;
  arregloDetalles = array[1..CANT_DETALLES] of detalle;

procedure leer(var det: detalle; var regDet: empleadoDetalle);
begin
  if (not eof(det)) then read(det, regDet)
  else regDet.cod := valorAlto;
end;

// devuelve un registro con el codigo minimo de algun archivo detalle
procedure minimo(var det: arregloDetalles; var regsDet: arregloRegistrosDetalles; var min: empleadoDetalle);
var
  posMin: integer;
  i: integer;
begin
  min := regsDet[1];
  posMin := 1;

  for i := 2 to CANT_DETALLES do begin
    if (regsDet[i].cod < min.cod) then begin
      min := regsDet[i];
      posMin := i;
    end;
  end;

  //se avanza en el archivo que tiene el registro con el menor codigo (mientras no se haya leido un EOF)
  if (min.cod <> valorAlto) then leer(det[posMin], regsDet[posMin]);
end;

procedure actualizar(var m: maestro; var det:arregloDetalles);
var
  i: integer;
  regsDet: arregloRegistrosDetalles;
  min: empleadoDetalle;
  regM: empleado;
  archTxt: Text;
begin
  reset(m);
  assign(archTxt, 'empleadosSinVaca');
  rewrite(archTxt);

  // leo el primer registro de cada detalle
  for i := 1 to CANT_DETALLES do
  begin
    reset(det[i]);
    leer(det[i], regsDet[i]);
  end;

  minimo(det, regsDet, min);

  while (min.cod <> valorAlto) do begin
    read(m, regM);

    while (regM.cod <> min.cod) do read(m, regM);

    // busco el mismo codigo minimo en todos los detalle para no recorrer el maestro varias veces (proceso un mismo codigo de una pasada)
    while (regM.cod = min.cod) do begin
      if (regM.diasVaca - min.diasVacaSolicitados < 0) then begin
        writeln(archTxt, regM.cod);
        writeln(archTxt, regM.nomAp);
        writeln(archTxt, regM.diasVaca);
        writeln(archTxt, min.diasVacaSolicitados);
      end
      else regM.diasVaca := regM.diasVaca - min.diasVacaSolicitados;
      minimo(det, regsDet, min);
    end;

    seek(m, filepos(m) -1);
    write(m, regM);
  end;

  close(m);

  for i := 1 to CANT_DETALLES do close(det[i]);

  close(archTxt);
end;

var
  m: maestro;
  det: arregloDetalles;
  nomDet: string[20];
  i: integer;

begin
  assign(m, 'empleados.dat');

  for i:=1 to CANT_DETALLES do begin
    write('Escriba un nombre para el archivo detalle ', i ,': ');
    readln(nomDet);
    assign(det[i], nomDet);
  end;

  actualizar(m, det);
end.
