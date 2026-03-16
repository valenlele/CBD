program ej7p1;

type
  alumno = record
    dni:integer;
    legajo:string[15];
    nomYap:string[20];
    direccion:string[20];
    anio:integer;
    fechaNacimiento:longInt;
  end;

  archivo = file of alumno;

procedure leerOpciones;
begin
  writeln('Ingrese una opcion: ');
  writeln('1: Crear un archivo de registros con la informacion correspondiente a los alumnos de la facultad de ingenieria.');
  writeln('2: Listar toda la informacion de los alumnos cuyos nombres comiencen con un caracter proporcionado por el usuario.');
  writeln('3: Listar en un archivo de texto denominado todos los registros del archivo de alumnos que cursen 5to anio.');
  writeln('4: Aniadir uno o mas alumnos al final del archivo.');
  writeln('5: Modificar el anio que cursa un alumno dado. Las busquedas son por legajo del alumno.');
  writeln('0: salir del programa.');
  writeln;
end;

procedure opc1(var arch:archivo);
var
  archTxt:Text;
  a:alumno;
begin
  assign(arch, 'aluBinario');
  assign(archTxt, 'alumnos.txt');

  rewrite(arch);
  reset(archTxt);

  while (not eof(archTxt)) do begin
    readln(archTxt, a.dni);
    readln(archTxt, a.legajo);
    readln(archTxt, a.nomYap);
    readln(archTxt, a.direccion);
    readln(archTxt, a.anio);
    readln(archTxt, a.fechaNacimiento);
    write(arch, a);
  end;

  close(arch);
  close(archTxt);
end;

procedure opc2(var arch:archivo);
var
  letra:char;
  a:alumno;
begin
  reset(arch);

  write('Ingrese la letra por la que quiere buscar alumnos: ');
  readln(letra);
  while (not eof(arch)) do begin
    read(arch, a);
    if (a.nomYap[1] = letra) then begin
      writeln('DNI: ', a.dni);
      writeln('Legajo: ', a.legajo);
      writeln('Nombre y apellido: ', a.nomYap);
      writeln('Direccion: ', a.direccion);
      writeln('Anio que cursa: ', a.anio);
      writeln('Fecha de nacimiento: ', a.fechaNacimiento);
      writeln;
    end;
  end;

  close(arch);
end;

procedure opc3(var arch:archivo);
var
  archTxt:Text;
  a:alumno;
begin
  reset(arch);
  assign(archTxt, 'alumnosAEgresar.txt');
  rewrite(archTxt);

  while (not eof(arch)) do begin
    read(arch, a);
    if (a.anio = 5) then begin
      writeln(archTxt, a.DNI);
      writeln(archTxt, a.legajo);
      writeln(archTxt, a.nomYap);
      writeln(archTxt, a.direccion);
      writeln(archTxt, a.anio);
      writeln(archTxt, a.fechaNacimiento);
    end;
  end;

  close(arch);
  close(archTxt);
end;

procedure opc4(var arch:archivo);
var
  a:alumno;
begin
  reset(arch);
  seek(arch, filesize(arch));

  write('DNI: ');
  readln(a.dni);
  while (a.dni <> -1) do begin
    write('Legajo: ');
    readln(a.legajo);
    write('Nombre y apellido: ');
    readln(a.nomYap);
    write('Direccion: ');
    readln(a.direccion);
    write('Anio que cursa: ');
    readln(a.anio);
    write('Fecha de nacimiento: ');
    readln(a.fechaNacimiento);
    writeln;

    write(arch, a);

    write('DNI: ');
    readln(a.dni);
  end;

  close(arch);
end;

procedure opc5(var arch:archivo);
var
  legajo:string[15];
  a:alumno;
  anio:integer;
begin
  write('Ingrese el legajo del alumno para modificar su anio de cursada: ');
  readln(legajo);

  reset(arch);

  while (not eof(arch)) do begin
    read(arch, a);
    if (a.legajo = legajo) then begin
      seek(arch, filepos(arch)-1);
      write('Ingrese el nuevo anio de cursada del alumno: ');
      readln(anio);
      a.anio:= anio;
      write(arch, a);
    end;
  end;
  writeln;

  close(arch);
end;

var
  opc:integer;
  arch:archivo;

begin

  leerOpciones;
  readln(opc);
  writeln;

  while (opc <> 0) do begin
    case opc of
      1: opc1(arch);
      2: opc2(arch);
      3: opc3(arch);
      4: opc4(arch);
      5: opc5(arch);
    end;

    leerOpciones;
    readln(opc);
  end;
end.

