private ["_passArray","_objHDiff","_isOk","_zheightchanged","_zheightdirection","_rotate","_dir","_object","_position","_isAllowedUnderGround","_location2","_cancel","_reason","_lastDir"];

_object = _this select 0;
_isAllowedUnderGround = _this select 1;
_location1 = _this select 2;
_position = _this select 3;

_passArray = [];

_objHDiff = 0;
_isOk = true;
_cancel = false;
_reason = "";
_dir = getDir player; //required to pass direction when building

cutText [(localize "str_epoch_player_45"), "PLAIN DOWN"];

while {_isOk} do { //if everything checks out, start while loop that is broken from within

	_zheightchanged = false;
	_zheightdirection = "";
	_rotate = false;

	if (DZE_Q) then {
		DZE_Q = false;
		_zheightdirection = "up";
		_zheightchanged = true;
	};
	if (DZE_Z) then {
		DZE_Z = false;
		_zheightdirection = "down";
		_zheightchanged = true;
	};
	if (DZE_Q_alt) then {
		DZE_Q_alt = false;
		_zheightdirection = "up_alt";
		_zheightchanged = true;
	};
	if (DZE_Z_alt) then {
		DZE_Z_alt = false;
		_zheightdirection = "down_alt";
		_zheightchanged = true;
	};
	if (DZE_Q_ctrl) then {
		DZE_Q_ctrl = false;
		_zheightdirection = "up_ctrl";
		_zheightchanged = true;
	};
	if (DZE_Z_ctrl) then {
		DZE_Z_ctrl = false;
		_zheightdirection = "down_ctrl";
		_zheightchanged = true;
	};
	if (DZE_4) then {
		_rotate = true;
		DZE_4 = false;
		_dir = 180;
	};
	if (DZE_6) then {
		_rotate = true;
		DZE_6 = false;
		_dir = 0;
	};

	if(_rotate) then {
		_object setDir _dir;
		_object setPosATL _position;
		//diag_log format["DEBUG Rotate BUILDING POS: %1", _position];
	};
	
	//attached objects can not change position (altitude in this case), so we need to detach it, reposition and attach to player again
	if(_zheightchanged) then {
		detach _object;

		_position = getPosATL _object;

		if(_zheightdirection == "up") then {
			_position set [2,((_position select 2)+0.1)];
			_objHDiff = _objHDiff + 0.1;
		};
		if(_zheightdirection == "down") then {
			_position set [2,((_position select 2)-0.1)];
			_objHDiff = _objHDiff - 0.1;
		};

		if(_zheightdirection == "up_alt") then {
			_position set [2,((_position select 2)+1)];
			_objHDiff = _objHDiff + 1;
		};
		if(_zheightdirection == "down_alt") then {
			_position set [2,((_position select 2)-1)];
			_objHDiff = _objHDiff - 1;
		};

		if(_zheightdirection == "up_ctrl") then {
			_position set [2,((_position select 2)+0.01)];
			_objHDiff = _objHDiff + 0.01;
		};
		if(_zheightdirection == "down_ctrl") then {
			_position set [2,((_position select 2)-0.01)];
			_objHDiff = _objHDiff - 0.01;
		};

		_object setDir (getDir _object);

		if((_isAllowedUnderGround == 0) && ((_position select 2) < 0)) then {
			_position set [2,0];
		};

		_object setPosATL _position;

		//diag_log format["DEBUG Change BUILDING POS: %1", _position];

		_object attachTo [player];

	};

	sleep 0.5; // slow down while loop, this is used for performance optimizations

	_location2 = getPosATL player; //find out how far player has traveled since beginning of object creation

	if(DZE_5) exitWith { //if spacebar is pressed, break while loop, detach and delete temporary preview, continue with building actual object
		_isOk = false;
		detach _object;
		_dir = getDir _object;
		_position = getPosATL _object;
		deleteVehicle _object;
	};

	if(_location1 distance _location2 > 5) exitWith {
		_isOk = false;
		_cancel = true;
		_reason = "You've moved to far away from where you started building (within 5 meters)";
		detach _object;
		deleteVehicle _object;
	};

	if(abs(_objHDiff) > 5) exitWith {
		_isOk = false;
		_cancel = true;
		_reason = "Cannot move up or down more than 5 meters";
		detach _object;
		deleteVehicle _object;
	};

	if (player getVariable["combattimeout", 0] >= time) exitWith { //combat check
		_isOk = false;
		_cancel = true;
		_reason = (localize "str_epoch_player_43");
		detach _object;
		deleteVehicle _object;
	};

	if (DZE_cancelBuilding) exitWith { //used to cancel building phase externally 
		_isOk = false;
		_cancel = true;
		_reason = "Cancelled building.";
		detach _object;
		deleteVehicle _object;
	};
};

_passArray = [_cancel,_reason,_position,_dir];
_passArray //[bool,string,array,int]