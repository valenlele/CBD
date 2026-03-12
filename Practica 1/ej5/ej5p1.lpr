program ej5p1;

const
  fin = 'zzz';

type
  flor = record
    nroEspecie:integer;
    altMax:real;
    nomCientifico:string[20];
    nomVulgar:string[20];
    color:string[20];
    altMax2:real;
  end;

  archivo = file of flor;

procedure leerFlor(var f:flor);
begin
  write('Numero de especie: ');
  readln(f.nroEspecie);
  write('Altura maxima: ');
  readln(f.altMax);
  write('Nombre vulgar: ');
  readln(f.nomVulgar);
  write('Color: ');
  readln(f.color);
  write('Altura maxima que alcanza: ');
  readln(f.altMax2);
end;

procedure imprimirFlor(f:flor);
begin
  writeln('Nombre cientifico: ',f.nomCientifico);
  writeln('Numero de especie: ', f.nroEspecie);
  writeln('Altura maxima: ', f.altMax:2:2);
  writeln('Nombre vulgar: ', f.nomVulgar);
  writeln('Color: ', f.color);
  writeln('Altura maxima que alcanza: ', f.altMax2:2:2);
end;

procedure opc1(var arch:archivo);
var
  f:flor;
  cantEspecies:integer;
  especieMinAltura:integer;
  minAltura:real;
  especieMaxAltura:integer;
  maxAltura:real;
begin
  cantEspecies:=0;
  minAltura:=9999;
  maxAltura:=-1;
  reset(arch); //al leer los datos al principio, el archivo queda posicionado al final. esto lo devuelve al principio
  while (not eof(arch)) do begin
    read(arch,f);
    cantEspecies:=cantEspecies+1;
    if (f.altMax2 < minAltura) then begin
      minAltura:=f.altMax2;
      especieMinAltura:=f.nroEspecie;
    end;
    if (f.altMax2 > maxAltura) then begin
      maxAltura:=f.altMax2;
      especieMaxAltura:=f.nroEspecie;
    end;
  end;
  writeln('Cantidad de especies: ', cantEspecies);
  writeln('Numero de especie de menor altura a alcanzar: ', especieMinAltura);
  writeln('Numero de especie de mayor altura a alcanzar: ', especieMaxAltura);
  writeln;
end;

procedure opc2(var arch:archivo);
var
  f:flor;
begin
  reset(arch);
  while (not eof(arch)) do begin
    read(arch,f);
    imprimirFlor(f);
    writeln;
  end;
end;

procedure opc3(var arch:archivo);
var
  f:flor;
begin
  reset(arch);
  while (not eof(arch)) do begin
    read(arch,f);
    if (f.nomCientifico = 'Victoria amazonia') then begin
      f.nomCientifico:= 'Victoria amazónica';
      seek(arch,filepos(arch)-1);
      write(arch,f);
    end;
  end;
end;

procedure opc4(var arch:archivo);
var
  f:flor;
begin
  seek(arch,filesize(arch));
  writeln('Se ingresa nueva informacion de especies de flores: ');
  write('Nombre cientifico: ');
  readln(f.nomCientifico);
  if (f.nomCientifico <> fin) then leerFlor(f);

  while (f.nomCientifico <> fin) do begin
    write(arch,f);
    writeln;
    writeln('Se ingresa informacion de especies de flores: ');
    write('Nombre cientifico: ');
    readln(f.nomCientifico);
    if (f.nomCientifico <> fin) then leerFlor(f);
  end;
end;

procedure opc5(var arch:archivo; var archTxt:Text);
var
  f:flor;
begin
  reset(arch);
  rewrite(archTxt); //lo pongo aca para que el archivo no quede bloqueado durante la ejecucion
  while (not eof(arch)) do begin
    read(arch,f);
    writeln(archTxt, f.nomCientifico);
    writeln(archTxt,f.nroEspecie);
    writeln(archTxt,f.altMax:2:2);
    writeln(archTxt,f.nomVulgar);
    writeln(archTxt,f.color);
    writeln(archTxt,f.altMax2:2:2);
    imprimirFlor(f);
    writeln;
  end;
  close(archTxt);
end;

var
  f:flor;
  arch:archivo;
  nomArch:string[20];
  opc:integer;
  archTxt:Text;

begin
  write('Ingrese el nombre del archivo: ');
  readln(nomArch);
  assign(arch,nomArch);
  assign(archTxt,'flores.txt');

  rewrite(arch);

  writeln;
  writeln('Se ingresa informacion de especies de flores: ');
  write('Nombre cientifico: ');
  readln(f.nomCientifico);
  if (f.nomCientifico <> fin) then leerFlor(f);

  while (f.nomCientifico <> fin) do begin
    write(arch,f);
    writeln;
    writeln('Se ingresa informacion de especies de flores: ');
    write('Nombre cientifico: ');
    readln(f.nomCientifico);
    if (f.nomCientifico <> fin) then leerFlor(f);
  end;

  writeln('Ingrese una opcion: ');
  writeln('1: Reportar la cantidad total de especies y la especie de menor y de mayor altura a alcanzar.');
  writeln('2: Listar todo el contenido del archivo de a una especie por línea.');
  writeln('3: Modificar el nombre científico de la especie flores cargada como: Victoria amazonia a: Victoria amazónica.');
  writeln('4: Añadir una o más especies al final del archivo.');
  writeln('5: Listar todo el contenido del archivo, en un archivo de texto.');
  writeln('0: salir del programa.');
  readln(opc);
  writeln;

  while (opc <> 0) do begin

    case opc of
      1: opc1(arch);
      2: opc2(arch);
      3: opc3(arch);
      4: opc4(arch);
      5: opc5(arch,archTxt);
    end;

    writeln('Ingrese una opcion: ');
    writeln('1: Reportar la cantidad total de especies y la especie de menor y de mayor altura a alcanzar.');
    writeln('2: Listar todo el contenido del archivo de a una especie por línea.');
    writeln('3: Modificar el nombre científico de la especie flores cargada como: Victoria amazonia a: Victoria amazónica.');
    writeln('4: Añadir una o más especies al final del archivo.');
    writeln('5: Listar todo el contenido del archivo, en un archivo de texto.');
    writeln('0: salir del programa.');
    readln(opc);

  end;

  close(arch);
end.

