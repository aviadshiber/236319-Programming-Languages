program B;
type
BCE=integer;
King= record
		name:array[0..11] of char;
		startYear:BCE;
		endYear:BCE;
end;
var
kingvar : King;
f:file of King;
maxBCE:BCE;
maxName:string;
diff:BCE;
BEGIN
 maxBCE:=0;
 diff:=0;
 maxName:='Unkown';
  assign(f, 'kings.dat');
  (* open a file for reading*)
   reset(f);
   while not eof(f) do
   begin
      read(f,kingvar);
      writeln('name',kingvar.name,' start',kingvar.startYear,' end',kingvar.endYear);  
	  diff:=kingvar.startYear-kingvar.endYear;
	  if( diff>maxBCE) then
	  begin
		maxBCE:=diff;
		maxName:= kingvar.name;
	  end;
   end;
   writeln('name of the longest kingsment is ', maxName);
   close(f);
END.
