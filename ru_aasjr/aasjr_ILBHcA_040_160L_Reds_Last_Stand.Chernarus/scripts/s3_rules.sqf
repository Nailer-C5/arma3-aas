

_rules= "Light.sqf";
if (PjrAAS_rules isEqualto 0) then
{
	_rules= "Light.sqf";
}
else
{
	_rules= "Heavy.sqf";
};

S3InitRulesPP= compile preprocessFile ("Rules\"+_rules);
call S3InitRulesPP;