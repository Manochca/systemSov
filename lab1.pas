const nn=6; mm=6;

type matrix=array[0..nn,0..mm] of real;
  vector=array[1..nn] of real;

var a: matrix;
  c: array[1..mm] of string = ('1','x1','x2','x3','x4','x5');
  d: array[1..nn] of string = ('0','0','0','0','0','0');
  n,m: integer;
  k,s: integer;
  t: integer;
  
procedure enter(n,m: integer);
var i,j: integer;
begin
  writeln('введите матрицу');
  for i:= 1 to n do
    for j:= 2 to m do
    begin
        read(a[i,j]);
    end;
  writeln('введите столбец свободных членов');
  for i:=1 to n do
    read(a[i,1]);
end;

procedure print(n,m: integer);
var i,j: integer;
begin
  writeln('вывод матрицы');
  for i:=0 to n do
  begin
    for j:=0 to m do
    begin
      if ((j=0) and (i>0)) then
        write(d[i]);
      if ((i=0) and (j>0)) then
        write(c[j]:5);
      if ((i>0) and (j>0)) then
        write(a[i,j]:5:1);
    end;
    writeln;
  end;
end;

procedure jordan(k,s: integer);
var i,j: integer;
  b: matrix;
  tmp: string;
begin
  for i:= 1 to n do
    for j:= 1 to m do
    begin   
      if ((i<>k) and (j<>s)) then
        b[i,j]:=(a[i,j]*a[k,s]-a[i,s]*a[k,j])/a[k,s]
      else
      begin
        if ((i<>k) and (j=s)) then
          b[i,j]:=a[i,j]/a[k,s]*(-1);
        if ((i=k) and (j<>s)) then
          b[i,j]:=a[i,j]/a[k,s];
        if ((i=k) and (j=s)) then
          b[i,j]:=1/a[k,s];
      end;
    end;
    
  tmp:=c[s];
  c[s]:=d[k];
  d[k]:=tmp;
  
  for i:=1 to n do
    for j:=s to m do
      b[i,j]:=b[i,j+1];
      
  for j:=s to m do
    c[j]:=c[j+1];
  
  m:=m-1;
    
  for i:=1 to n do
    for j:=1 to m do
      a[i,j]:=b[i,j];
  print(n,m);
end;

procedure Answer(n,m: integer);
var i,j: integer;
  l: vector;
  t: integer;
begin  
  t:=0;
  if (m=1) then
    writeln('система совместна')
  else
  begin
    for i:=1 to n do
      l[i]:=0;
    for i:=1 to n do
      for j:=1 to m do
        l[i]:=l[i]+a[i,j];
    for i:=1 to n do
      if ((d[i]='0') and (l[i]=0)) then
        t:=t+1
      else
        t:=t-1;            
    if (t=(-1)*n) then
      writeln('система несовместна, решения нет')
    else
    begin
      writeln('система совместна');
      
    end;
  end;
end;
  
begin
  writeln('введите размерность матрицы');
  readln(n,m);
  m:=m+1;
  enter(n,m);
  print(n,m);
  t:=1;
  repeat
    writeln('выберите элемент не равный нулю и не из первого столбца');
    readln(k,s);    
    while ((a[k,s]=0) or (s=1)) do
    begin
      writeln('выбран неверный элемент');
      writeln('выберите элемент не равный нулю и не из первого столбца');
      readln(k,s);
    end;
    writeln('выбран элемент a[',k,',',s,']=',a[k,s]);
    jordan(k,s);
    writeln('хотите продолжить? 1-да, 0-нет');
    readln(t);
  until (t=0);
  Answer(n,m);
end.