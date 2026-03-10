{Realizar un programa que permita crear un archivo binario de strings conteniendo
información de nombres de materiales de construcción, el archivo no es ordenado.
Efectúe la declaración de tipos correspondiente y luego realice un programa que
permita la carga del archivo con datos ingresados por el usuario. El nombre del
archivo debe ser proporcionado por el usuario. La carga finaliza al procesar el
nombre ‘cemento’ que debe incorporarse al archivo.}

program ej1p1;

type
  archivo = file of string[20];

var
  arch:archivo;
  nomArchivo:string[20];
  material:string[20];

begin
  write('Ingrese el nombre del archivo: ');
  readln(nomArchivo);
  assign(arch,nomArchivo);

  rewrite(arch);

  writeln('');

  write('Ingrese el nombre de un material: ');
  readln(material);

  repeat
    write(arch,material);
    if (material <> 'cemento') do begin
      write('Ingrese el nombre de un material: ');
      readln(material);
    end;
  until material = 'cemento';

  close(arch);

end.

