program ej2p3;

Type
  tVehiculo = record
    codigoVehiculo: integer;
    patente: String[7];
    motor: String[10];
    cantidadPuertas: integer;
    precio: real;
    descripcion: String[1] // valor 0 significa que no existren registros borrados. N indica que el proximo registro a utilizar esta en la posicion N
  end;

  tArchivo = file of tVehiculo;

procedure agregar(var arch: tArchivo; vehiculo: tVehiculo);
var
  reg: tVehiculo;
  sLibre: string[1];
  nLibre: integer;
begin
  reset(arch);

  read(arch, reg);
  sLibre := reg.descripcion;

  Val(sLibre, nLibre);

  if (nLibre = 0) then seek(arch, fileSize(arch))
  else begin
    seek(arch, nLibre);

    read(arch, reg);
    sLibre := reg.descripcion;

    seek(arch, 0);
    reg.descripcion := sLibre;
    write(arch, reg);

    seek(arch, nLibre); //volvermos al huevo original
  end;

  write(arch, vehiculo);

  close(arch);
end;

procedure eliminar(var arch: tArchivo; vehiculo: tVehiculo);
var
  encontre: boolean;
  reg: tVehiculo;
  sLibre: string[1];
  nLibre: integer;
begin
  reset(arch);
  encontre := false;

  read(arch, reg);
  sLibre := reg.descripcion;

  Val(sLibre, nLibre);

  while (not eof(arch)) and (encontre = false) do begin
    read(arch, reg);
    if (reg = vehiculo) then encontre := true;
  end;

  if (encontre) then begin
    nLibre := filePos(arch) - 1;

    seek(arch, nLibre);

    reg.descripcion := sLibre;
    write(arch, reg);

    Str(nLibre, sLibre);

    seek(arch, 0);
    reg.descripcion := sLibre;
    write(arch, reg);
  end;

  close(arch);
end;

begin
end.

