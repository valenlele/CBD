program ej2p2;

const
  fin = 'zzz';

type
  cd = record
    codAutor:integer;
    nomAutor:string[20];
    nomDisco:string[20];
    genero:string[20];
    cantVendida:integer;
  end;

  archivo = file of cd;

procedure leer(var arch: archivo; var regCd: cd);
begin
  if (not eof(arch)) then read(arch, regCd)
  else regCd.nomAutor := fin;
end;

{procedure cargarReg(var r: cd; cod: integer; autor, disco, gen: string; cant: integer);
begin
  r.codAutor := cod;
  r.nomAutor := autor;
  r.nomDisco := disco;
  r.genero := gen;
  r.cantVendida := cant;
end;}

var
  arch: archivo;
  reg: cd;
  totGeneral, totAutor, totGenero, totDisco: integer;
  autorAct, generoAct, discoAct: string[30];
  archTxt:Text;

begin
  assign(arch, 'discos.dat');
  reset(arch);

  assign(archTxt, 'cd.txt');
  rewrite(archTxt);

  leer(arch, reg);
  totGeneral := 0;
  while (reg.nomAutor <> fin) do begin
    autorAct := reg.nomAutor;
    totAutor := 0;
    writeln('Autor: ', autorAct);
    while (reg.nomAutor = autorAct) do begin
      generoAct := reg.genero;
      totGenero := 0;
      writeln('Genero: ', generoAct);
      while ((reg.nomAutor = autorAct) and (reg.genero = generoAct)) do begin
        discoAct := reg.nomDisco;
        totDisco := 0;
        write('Nombre disco: ', discoAct);
        while ((reg.nomAutor = autorAct) and (reg.genero = generoAct) and (reg.nomDisco = discoAct)) do begin
          totDisco := totDisco + reg.cantVendida;
          leer(arch, reg);
        end;
        writeln(' cantidad vendida: ', totDisco);
        totGenero := totGenero + totDisco;
        write(archTxt, discoAct,' ', autorAct,' ', totDisco);
      end;
      writeln('Total genero: ', totGenero);
      totAutor := totAutor + totGenero;
    end;
    writeln('Total autor: ', totAutor);
    writeln;
    totGeneral := totGeneral + totAutor;
  end;
  writeln('Total discografica: ', totGeneral);

  close(arch);
  close(archTxt);
  readln;

  {assign(arch, 'discos.dat');
  rewrite(arch);

  // Autor 1: Charly Garcia (Codigo 10)
  // Genero: Pop
  cargarReg(reg, 10, 'Charly Garcia', 'Clics Modernos', 'Pop', 500);
  write(arch, reg);
  // Genero: Rock
  cargarReg(reg, 10, 'Charly Garcia', 'Piano Bar', 'Rock', 450);
  write(arch, reg);
  cargarReg(reg, 10, 'Charly Garcia', 'Yendo de la cama al living', 'Rock', 300);
  write(arch, reg);

  // Autor 2: Gustavo Cerati (Codigo 15)
  // Genero: Electronica
  cargarReg(reg, 15, 'Gustavo Cerati', 'Bocanada', 'Electronica', 800);
  write(arch, reg);
  cargarReg(reg, 15, 'Gustavo Cerati', 'Colores Santos', 'Electronica', 400);
  write(arch, reg);
  // Genero: Rock
  cargarReg(reg, 15, 'Gustavo Cerati', 'Ahi vamos', 'Rock', 1000);
  write(arch, reg);
  cargarReg(reg, 15, 'Gustavo Cerati', 'Fuerza Natural', 'Rock', 1200);
  write(arch, reg);

  // Autor 3: Luis Alberto Spinetta (Codigo 20)
  // Genero: Rock
  cargarReg(reg, 20, 'Spinetta', 'Artaud', 'Rock', 600);
  write(arch, reg);
  cargarReg(reg, 20, 'Spinetta', 'Kamikaze', 'Rock', 350);
  write(arch, reg);

  close(arch);
  writeln('Archivo discos.dat generado con exito.');
  readln;}
end.

