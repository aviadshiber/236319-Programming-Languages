
true xor true;
true xor false;
false xor true;
false xor false;

isLegalString(fn c:char => c=(#"R") orelse c=(#"A") orelse c=(#"S") orelse c=(#"L"), "LASR");
isLegalString(fn c:char => ord(c)>=ord(#"0") andalso ord(c)<=ord(#"9"), "452130259742365896541236.0");

reverseString("");
reverseString("ABBA");
reverseString("1234567890");
reverseString("!@#$%^&*()");

adderForNumbersOfBase(0,("12","9"));
adderForNumbersOfBase(7,("12",""));
adderForNumbersOfBase(~5,("12","9"));
adderForNumbersOfBase(5,("666","3"));
adderForNumbersOfBase(14,("FFF","FA"));
adderForNumbersOfBase(14,("CAC","7D5"));
adderForNumbersOfBase(1,("0","0"));
adderForNumbersOfBase(10, ("020", "0002"));
adderForNumbersOfBase(16, ("DEAD", "BEEF"));
adderForNumbersOfBase(15, ("DEAD", "BEEF"));
adderForNumbersOfBase(17, ("1", "2"));