{Desarrollar un programa que permita la apertura de un archivo binario de números
enteros no ordenados. La información del archivo corresponde a la cantidad de
votantes de cada ciudad de la Provincia de Buenos Aires en una elección
presidencial. Recorriendo el archivo una única vez, informe por pantalla la cantidad
mínima y máxima de votantes. Además durante el recorrido, el programa deberá
listar el contenido del archivo en pantalla. El nombre del archivo a procesar debe
ser proporcionado por el usuario.}

program ej2p1;

type
  archivo = file of integer;

var
  arch:archivo;
  nomArchivo:string[20];
  num,max,min:integer;

begin
  max := -1;
  min := 99999;
  write('Ingrese el nombre del archivo: ');
  readln(nomArchivo);
  assign(arch,nomArchivo);

  writeln('');

  rewrite(arch);

  write('Ingrese la cantidad de votantes: ');
  readln(num);

  while (num <> -1) do begin
    write(arch,num);
    write('Ingrese la cantidad de votantes: ');
    readln(num);
  end;

  close(arch);

  reset(arch);

  writeln('');

  writeln('Cantidad de votantes por ciudad: ');

  while (not eof(arch)) do begin
    read(arch,num);
    writeln(num);
    if (num < min) then min := num;
    if (num > max) then max := num;
  end;

  close(arch);

  writeln('');

  writeln('La cantidad maxima de votantes es: ', max);
  writeln('La cantidad minima de votantes es: ', min);

  readln();
end.

