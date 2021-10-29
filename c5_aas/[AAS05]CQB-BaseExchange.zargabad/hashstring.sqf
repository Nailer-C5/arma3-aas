#include "globalDefines.hpp"
string _inputString = _this;
array _inputArray = toArray( _inputString );
array _roundArray = [];
array _offArray = [  0 , 1 ,23 ,20 ,13 , 6 , 5 , 7 ,
                     9 ,10 ,31 ,12 , 4 ,24 ,30 ,16 ,
					 8 ,27 ,18 ,19 , 3 ,21 ,26 ,2  ,
					14 ,25 ,22 ,17 ,28 ,29 ,15 ,11    ];
_inputArray set [count _inputArray,0];
while{ count _roundArray < 32 } do
	{
	int _idx=count _roundArray;
	_roundArray set [count _roundArray,_inputArray select (_idx % (count _inputArray))];
	};
int _iterCtr=0;
for "_iterctr" from 0 to 31 do
	{
	_newRoundArray = [];
	int _rctr=0;
	for "_rctr" from 0 to 31 do
		{
		int _num = (_roundArray select ((_rctr+_iterCtr) % 32));
		int _selidx=( ((_roundArray select _iterCtr) * (_roundArray select _rctr)) % 32 );
		_num = _num + (_roundArray select _selidx);
		_selidx=( (_iterCtr * (_roundArray select _rctr)) % 32 );
		_num = _num + (_roundArray select _selidx);
		_num = _num + ((_roundArray select ( _offArray select _rctr )) * (_offArray select _rctr));				  
		_num = _num + (_rctr*4);
		_num=_num % 256;
		_newRoundArray set [count _newRoundArray,_num];
		};
	_roundArray=_newRoundArray;
	};
array _hexString = [ "0" , "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8" , "9" , "A" , "B" , "C" , "D" , "E" , "F" ];
string _output="";
for "_arrctr" from 0 to 31 do
	{
	int _numbig=(_roundArray select _arrCtr) % 16;
	int _numsmall=floor ((_roundArray select _arrCtr) / 16);
	_output = _output + (_hexString select _numbig);
	_output = _output + (_hexString select _numsmall);
	};
_output