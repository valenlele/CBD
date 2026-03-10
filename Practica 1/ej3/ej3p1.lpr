{Realizar un programa que permita crear un archivo de texto. El archivo se debe
cargar con la información ingresada mediante teclado. La información a cargar
representa los tipos de dinosaurios que habitaron en Sudamérica. La carga finaliza
al procesar el nombre ‘zzz’ que no debe incorporarse al archivo.}

program ej3p1;

var
  arch:Text;
  nomArch:string[20];
  especie:string[20];

begin
  write('Ingrese el nombre del archivo: ');
  readln(nomArch);

  assign(arch,nomArch);

  rewrite(arch);

  writeln('');

  write('Ingrese la especie: ');
  readln(especie);

  while (especie <> 'zzz') do begin
    write(arch,especie);

    write('Ingrese la especie: ');
    readln(especie);
  end;

  close(arch);
end.

