/*
  fnc_s_uhrzeit_setzen
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.13
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Example: unnecessary

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
systemchat format["fnc_s_uhrzeit_setzen: %1",_this];
call compile format["[%1] remoteExec [""setDate""];",_this select 0];
