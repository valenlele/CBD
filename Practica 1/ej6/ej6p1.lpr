program ej6p1;

type
  libro = record
    isbn:integer;
    titulo:string[20];
    genero:string[20];
    editorial:string[20];
    anio:integer;
  end;

  archivo = file of libro;

var
  arch:archivo;
  archTxt:Text;
  l:libro;

begin
  assign(arch, 'binarioLibros');
  rewrite(arch);
  assign(archTxt, 'libros.txt');
  reset(archTxt);

  while (not eof(archTxt)) do begin
    readln(archTxt, l.isbn);
    readln(archTxt, l.titulo);
    readln(archTxt, l.genero);
    readln(archTxt, l.editorial);
    readln(archTxt, l.anio);
    write(arch, l);
  end;


end.

