
#define __defSize 0.5
#define __defTime 0.5
#define __defPeriod 0.05
#define __defParticle "\ca\data\cl_water.p3d"

private ["_unit","_color","_colorB","_attach","_particleSource","_particle"];
_unit = _this select 0;
_color = _this select 1;

if (!(alive _unit)) exitWith {diag_log "null";};

_attach = vehicle _unit;
_particleSource = _unit getVariable "AAS_PS";
if (isNil "_particleSource") then
{
	_particleSource = "#particlesource" createVehicleLocal (getpos _unit);
	_unit setVariable ["AAS_PS",_particleSource];
};

// Leaving this open for possible changes
_particle = __defParticle;
_size = __defSize;

if (alive _unit) then
{
	_colorB = [_color select 0,_color select 1,_color select 2,0];
	_particleSource setParticleParams [_particle,"","billboard",1,__defTime,[0,0,2],[0,0,0],1,1,0.784,0.1,[_size,_size * 0.66],[_color,_color,_color,_color,_colorB],[1],10.0,0.0,"","",_attach];
	_particleSource setDropInterval __defPeriod;
}
else
{
	_particleSource setDropInterval 0;
};
_particleSource;