program TaxicabNumber;
	var count,k,a,temp : integer;
	function qube(num : integer) : integer;
		begin
			qube := num*num*num;
		end;
	function isTwoQubes(k,a : integer) : boolean;
		begin
			if round(exp(1/3*ln(k-qube(a))))- exp(1/3*ln(k-qube(a))) >= 0 then
				isTwoQubes := round(exp(1/3*ln(k-qube(a))))- exp(1/3*ln(k-qube(a))) <= 0.00000001
			else
				isTwoQubes := exp(1/3*ln(k-qube(a))) - round(exp(1/3*ln(k-qube(a)))) <= 0.00000001;
		end;
	function isTaxiNumber(var k,a,count : integer) : boolean;
		begin
			isTaxiNumber := false;
			while qube(a)<(k/2) do
				begin
					count := count+1;
					if isTwoQubes(k,a) then
						begin
							isTaxiNumber := true;
							break;
						end;	
					a := a+1;
				end;
		end;
	begin
		k := 3;
		count := 0;
		while true=true do
			begin
				count := count+1;
				a := 1;
				if isTaxiNumber(k,a,count) then
					begin
						temp := a;
						a := a+1;
						if isTaxiNumber(k,a,count) then
							begin
								if (qube(temp)+qube(a)) <> k then
									begin
										WriteLn('The taxicab number is ',k);
										WriteLn('The counter is ',count);
										WriteLn('The number of conditions are ',count);
										break;
									end;
							end;
					end;
				k := k+1;
			end;
	end.
