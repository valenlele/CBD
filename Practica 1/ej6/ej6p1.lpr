program ej6p1;

type
  libro = record
    isbn:int64;
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
  isbn:int64;
  encontre:boolean;

begin
  assign(arch, 'binarioLibros');
  rewrite(arch);
  assign(archTxt, 'libros.txt');
  reset(archTxt);

  while (not eof(archTxt)) do begin
    readln(archTxt, l.isbn, l.titulo);
    readln(archTxt, l.anio, l.editorial);
    readln(archTxt, l.genero);
    write(arch, l);
  end;

  close(arch);
  close(archTxt);

  reset(arch);
  writeln('Se ingresa informacion de un nuevo libro: ');
  write('ISBN: ');
  readln(l.isbn);
  write('Titulo: ');
  readln(l.titulo);
  write('Anio: ');
  readln(l.anio);
  write('Editorial: ');
  readln(l.editorial);
  write('Genero: ');
  readln(l.genero);
  seek(arch, filesize(arch));
  write(arch, l);

  seek(arch, 0);

  encontre:= false;
  write('Ingrese el ISBN del libro a modificar: ');
  readln(isbn);
  while ((not eof(arch)) and (not encontre)) do begin
    read(arch, l);
    if (l.isbn = isbn) then begin
     encontre:= true;
     writeln('Libro encontrado. ');
     write('ISBN: ');
     readln(l.isbn);
     write('Titulo: ');
     readln(l.titulo);
     write('Anio: ');
     readln(l.anio);
     write('Editorial: ');
     readln(l.editorial);
     write('Genero: ');
     readln(l.genero);
     seek(arch, filepos(arch)-1);
     write(arch, l);
    end;
  end;
  readln;
end.

