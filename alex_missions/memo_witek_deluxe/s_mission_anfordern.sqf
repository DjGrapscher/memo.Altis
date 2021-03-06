/*
  s_mission_anfordern.sqf (witteks dm deluxe)
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.02
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Necessary functions:
	Example: unnecessary

  Please give the author the necessary credits if you use this script or change it. The script was created in context to other functions
  of the author and guarantees no functionalities with other scripts and functions that were not developed by athor expilizit for it.
*/
params ["_remoteexecutedowner"];
// # leichen entfernen
{deletevehicle _x} foreach allDeadMen;
// # vehicle ausserhalb hq loeschen sofern hq-area vorhanden
if (!isnil "s_sys_area_hq") then {
  {
    if ((position _x) inarea s_sys_area_hq) then {
      if ((count(fullCrew [_x, "driver", true])) > 0) then {deletevehicle _x};// fahzeuge mit fahrerposition loeschen
    } else {
      deletevehicle _x;
    };
  } foreach vehicles;
};

// # spieler ausserhalb hq zurueckholen
[] call fnc_s_mission_spieler_zu_hq;


private _temp_dm_loc_params = [];




for "_i" from 1 to 50 do {
  _temp_dm_loc_params = selectrandom s_dmd_area_auswahl;
  if ((count(allunits inareaarray (_temp_dm_loc_params select 1))) == 0) exitwith {};
  _temp_dm_loc_params = [];
};


if ((count _temp_dm_loc_params) == 0) exitwith {
  [[format["<t color='#ff0000' size='2'>Die Missionsanforderung %1 ist fehlgeschlagen - Versuche es nochmal!",s_mission_params select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",_remoteexecutedowner];
};



//s_mission_params = s_mission_params_dm;
{s_mission_params set [_foreachindex,_x]} foreach s_mission_params_dmd;




if (!isnil "eo_hq_missionsteilnahme") then {
  {
    [eo_hq_missionsteilnahme,[0,format["%1teilnahmebild.jpg",s_mission_params select 2]]] remoteExec ["setObjectTexture", _x, true];
    [[format["<t color='#ff8400' size='2'>%1 angefordert - Standby fuer Missionserstellung!",s_mission_params select 1], "PLAIN", -1, true, true]] remoteExec ["cutText",_x];
  } foreach playableunits;
};

s_dmd_loc_params = _temp_dm_loc_params;
s_dmd_loc_params execvm "alex_missions\memo_witek_deluxe\s_dmd_generieren.sqf";
