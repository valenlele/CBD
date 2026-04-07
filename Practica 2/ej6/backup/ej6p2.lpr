program ej6p2;

const
  FIN = -1;

type
  servicio = record
    codMozo: integer;
    fecha: string[10];
    monto: real;
  end;

  arch = file of servicio;

procedure crearArchivo(var a: arch);
var
  reg: servicio;
begin
  assign(a, 'servicios.dat');
  rewrite(a);

  // Mozo 1
  reg.codMozo := 1; reg.fecha := '2026-04-01'; reg.monto := 1500.50; write(a, reg);
  reg.codMozo := 1; reg.fecha := '2026-04-02'; reg.monto := 2000.00; write(a, reg);

  // Mozo 3
  reg.codMozo := 3; reg.fecha := '2026-04-01'; reg.monto := 3500.00; write(a, reg);

  // Mozo 5
  reg.codMozo := 5; reg.fecha := '2026-04-03'; reg.monto := 1000.00; write(a, reg);
  reg.codMozo := 5; reg.fecha := '2026-04-05'; reg.monto := 500.00; write(a, reg);
  reg.codMozo := 5; reg.fecha := '2026-04-07'; reg.monto := 3000.00; write(a, reg);

  close(a);
end;

procedure leer(var a: arch; var reg: servicio);
begin
  if (not eof(a)) then read(a, reg)
  else reg.codMozo := FIN;
end;

procedure compact(var a: arch);
var
  reg, regCompact: servicio;
  aCompact: arch;
  mozoAct: integer;
  montoTot: real;
begin
  assign(a, 'servicios.dat');
  reset(a);

  assign(aCompact, 'serviciosCompact.dat');
  rewrite(a);

  leer(a, reg);
  while (reg.codMozo <> fin) do begin
    mozoAct := reg.codMozo;
    montoTot := 0;
    while (reg.codMozo = mozoAct) do begin
      montoTot := montoTot + reg.monto;
      leer(a, reg);
    end;
    regCompact.codMozo := mozoAct;
    regCompact.monto:= montoTot;
    write(aCompact, regCompact);
  end;
end;

var
  a: arch;

begin
  crearArchivo(a);
  {compact(a);}
  readln;
end.
