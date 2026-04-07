program ej5p2;

const
  FIN = 'zzz';

type
  infoMuni = record
    partido, localidad, barrio: string [20];
    cantNinos, cantAdultos: integer;
  end;

  arch = file of infoMuni;

procedure crearArchivo(var a: arch);
var
  reg: infoMuni;
begin
  assign(a, 'infoMuni.dat');
  rewrite(a);

  reg.partido := 'La Plata';
  reg.localidad := 'Tolosa';
  reg.barrio := 'Barrio A';
  reg.cantNinos := 25;
  reg.cantAdultos := 10;
  write(a, reg);

  reg.partido := 'La Plata';
  reg.localidad := 'Tolosa';
  reg.barrio := 'Barrio B';
  reg.cantNinos := 15;
  reg.cantAdultos := 5;
  write(a, reg);

  reg.partido := 'La Plata';
  reg.localidad := 'City Bell';
  reg.barrio := 'Centro';
  reg.cantNinos := 10;
  reg.cantAdultos := 8;
  write(a, reg);

  reg.partido := 'Berisso';
  reg.localidad := 'Centro';
  reg.barrio := 'Barrio C';
  reg.cantNinos := 30;
  reg.cantAdultos := 20;
  write(a, reg);

  close(a);
end;

procedure leer(var a: arch; var reg: infoMuni);
begin
  if (not eof(a)) then read(a, reg)
  else reg.partido := FIN;
end;

procedure imprimir(var a: arch);
var
  reg: infoMuni;
  totNinosPartido, totAdultosPartido, totNinosLocalidad, totAdultosLocalidad: integer;
  partidoAct, localidadAct: string[20];
begin
  assign(a, 'infoMuni.dat');
  reset(a);

  leer(a, reg);
  while (reg.partido <> fin) do begin
    partidoAct := reg.partido;
    totNinosPartido := 0;
    totAdultosPartido := 0;
    writeln('Partido: ', partidoAct);
    while (reg.partido = partidoAct) do begin
      localidadAct := reg.localidad;
      totNinosLocalidad := 0;
      totAdultosLocalidad := 0;
      writeln('Localidad: ', localidadAct);
      while ((reg.partido = partidoAct) and (reg.localidad = localidadAct)) do begin
        writeln('Cantidad ninos: ', reg.cantNinos, '. Cantidad adultos: ', reg.cantAdultos);
        totNinosLocalidad := totNinosLocalidad + reg.cantNinos;
        totAdultosLocalidad := totAdultosLocalidad + reg.cantAdultos;
        leer(a, reg);
      end;
      writeln('Total ninos localidad ', localidadAct, ': ', totNinosLocalidad, '. Total adultos localidad ', localidadAct, ': ', totAdultosLocalidad);
      totNinosPartido := totNinosPartido + totNinosLocalidad;
      totAdultosPartido := totAdultosPartido + totAdultosLocalidad;
    end;
    writeln('TOTAL NINOS PARTIDO ', partidoAct, ': ', totNinosPartido, '. TOTAL ADULTOS PARTIDO ', partidoAct,': ', totAdultosPartido);
    writeln;
  end;

  close(a);
end;

var
  a: arch;

begin
  {crearArchivo(a);}
  imprimir(a);
  readln;
end.
