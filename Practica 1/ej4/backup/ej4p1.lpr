program ej4p1;

type
  arch = file of integer;

procedure textoAbinario(var archBin:arch);
var
  archTxt:Text;
  nomArchTxt:string[20];
  num:integer;
begin
  writeln('Ingrese el nombre del archivo de texto: ');
  readln(nomArchTxt);
  assign(archTxt,nomArchTxt);
  rewrite(archTxt);

  reset(archBin);
  while (not eof(archBin)) do begin
    read(archBin,num);
    writeln(archTxt,num);
  end;

  close(archBin);
  close(archTxt);
end;

var
  archBin:arch;
  nomArchBin:string[20];

begin
  writeln('Ingrese el nombre del archivo binario: ');
  readln(nomArchBin);
  assign(archBin,nomArchBin);
  textoAbinario(archBin);
  readln;
end.

