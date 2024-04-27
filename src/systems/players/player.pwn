stock Player:Save(playerid) 
{
    if(!GetPlayerData(playerid, PLAYER_AUTHORIZED))
        return 0;

    new 
        save_player_query[128];

    for(new i, accessory_string[20]; i < MAX_MY_ACCESSORIES; i++)
    {
		format(accessory_string, sizeof accessory_string, "%d%s", _:player_battle_pass_data[playerid][P_BATTLE_PASS_PRIZE_STATUS][i], (i == BATTLE_PASS_MAX_PRIZE - 1) ? "" : ",");
		strcat(save_player_query, accessory_string);
	}

    format
    (
        save_player_query, sizeof save_player_query, "UPDATE "DB_ACCOUNT" SET \
        `"
        
    )


    return 1;
}