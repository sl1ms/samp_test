/*stock Player:Save(playerid) 
{
    if(!GetPlayerData(playerid, PLAYER_AUTHORIZED))
        return 0;

    new 
        save_player_query[150],
        accessory_string[40];

    strcat(save_player_query, "UPDATE "DB_ACCOUNT" SET ");

    for(new i; i < MAX_MY_ACCESSORIES; i++)
    {
		format
        (
            accessory_string, sizeof accessory_string, "%s%d%s", 
            accessory_string, g_player_data[playerid][PLAYER_ACCESSORY][i], 
            (i == MAX_MY_ACCESSORIES - 1) ? "" : ","
        );
	}

    format
    (
        save_player_query, sizeof save_player_query, "\
        `accessories` = '%s' WHERE `id` = '%d'",
        accessory_string,
        GetPlayerData(playerid, PLAYER_ID)
    );

    mysql_tquery(mysql, save_player_query);

    return 1;
}*/