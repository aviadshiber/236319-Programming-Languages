fun shortOrNot() =	let
						exception notShort;
						fun isNotShort() = raise notShort;
					in
						if 1>0 orelse isNotShort() then 1 else 0
					end handle notShort => 0;