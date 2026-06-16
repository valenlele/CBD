program parcial;

type
  sesion = record
    codDocente, anio, codTaller, asistentes, abandonos: integer;
    nomDocente, nomTaller: string[20];
    puntajeProm: real;
  end;

  archivo = file of sesion;

procedure informe;
var
  arch: archivo;
  s: sesion;
  totSesiones, cantAnios, anioAct, totSesionesAnio, codTallerAct, codDocenteAct, totAsistentesDoc, totAbandonosDoc: integer;
  minPuntajeDoc, totPuntajeDoc: real;
  nomDocenteAct, nomDocenteMinPuntaje: string[20];
begin
  assign(arch, 'sesiones.dat');
  reset(arch);

  if (not eof(arch)) then read(arch, s);

  totSesiones := 0;
  cantAnios := 0;

  while (not eof(arch)) do begin
    anioAct := s.anio;
    writeln('Anio: ', anioAct);
    totSesionesAnio := 0;
    while (not eof(arch)) and (s.anio = anioAct) do begin
      codTallerAct := s.codTaller;
      minPuntajeDoc := 9999;
      writeln('Taller: ', s.nomTaller, ' (Codigo: ', codTallerAct, ')');
      while (not eof(arch)) and (s.anio = anioAct) and (s.codTaller = codTallerAct) do begin
        codDocenteAct := s.codDocente;
        nomDocenteAct:= s.nomDocente;
        writeln('Docente: ', s.nomDocente, ' (Codigo: ', codDocenteAct, ')');
        totAsistentesDoc := 0;
        totAbandonosDoc := 0;
        totPuntajeDoc := 0;
        while (not eof(arch)) and (s.anio = anioAct) and (s.codTaller = codTallerAct) and (s.codDocente = codDocenteAct) do begin
          totSesiones := totSesiones + 1;
          totAsistentesDoc := totAsistentesDoc + s.asistentes;
          totAbandonosDoc := totAbandonosDoc + s.abandonos;
          totPuntajeDoc := totPuntajeDoc + s.puntajeProm;
          read(arch, s);
        end;
        writeln('Total de asistentes: ', totAsistentesDoc);
        writeln('Total de abandonos: ', totAbandonosDoc);
        writeln('Tasa de abandono: ', (totAbandonosDoc / totAsistentesDoc)*100, '%');
        writeln('Puntaje acumulado: ', totPuntajeDoc);
        if (totPuntajeDoc < minPuntajeDoc) then begin
          minPuntajeDoc := totPuntajeDoc;
          nomDocenteMinPuntaje := nomDocenteAct;
        end;
      end;
      writeln('El docente ', nomDocenteMinPuntaje, ' tuvo el menor impacto en ', s.nomTaller, 'durante el anio ', anioAct);
    end;
    cantAnios := cantAnios + 1;
    writeln('Durante el anio ', anioAct,' se registraron ', totSesionesAnio,' sesiones de capacitacion');
  end;
  writeln('El promedio total de sesiones por anio es: ', totSesiones/cantAnios);

  close(arch);
end;

begin
  informe;
end.
