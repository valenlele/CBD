program parcial;

const
  FIN = 9999;

type
  tArch = record
    codPartido, cantViviendas: integer;
    tVivienda: string[15];
  end;

  arch = file of tArch;

procedure leer(var a: arch; var regA: tArch);
begin
  if (not eof(a)) then read(a, regA)
  else regA.codPartido := FIN;
end;

procedure compactar(var a: arch);
var
  aCompact: arch;
  maxCantViviendas, codPartidoAct, cantViviendasxPartido, cantTVivienda, maxCodPartido: integer;
  regA, regACompact: tArch;
  tViviendaAct: string[15];
begin
  assign(a, 'archivo.dat');
  reset(a);
  assign(aCompact, 'archivoCompact.dat');
  rewrite(aCompact);

  maxCantViviendas := -1;

  leer(a, regA);
  while (regA.codPartido <> FIN) do begin
    codPartidoAct := regA.codPartido;
    cantViviendasxPartido := 0;
    while (regA.codPartido = codPartidoAct) do begin
      tViviendaAct := regA.tVivienda;
      cantTVivienda := 0;
      while (regA.codPartido = codPartidoAct) and (regA.tVivienda = tViviendaAct) do begin
        cantTVivienda := cantTVivienda + regA.cantViviendas;
        leer(a, regA);
      end;
      cantViviendasxPartido := cantViviendasxPartido + cantTVivienda;
      regACompact.codPartido := codPartidoAct;
      regACompact.tVivienda := tViviendaAct;
      regACompact.cantViviendas := cantTVivienda;
      write(aCompact, regACompact);
    end;
    if (cantViviendasxPartido > maxCantViviendas) then begin
      maxCantViviendas := cantViviendasxPartido;
      maxCodPartido := codPartidoAct;
    end;
  end;
  write(maxCodPartido, ',', maxCantViviendas);

  close(a);
  close(aCompact);
end;

var
  a:arch;

begin
  compactar(a);
end.
