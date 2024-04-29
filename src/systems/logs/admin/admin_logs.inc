#define AdminLogs:%0(%1)  AL_%0(%1)


#define DB_ADMIN_LOGS "`admin_logs`"

CMD:kick(playerid, params[])
{
    new
        to_player,
        description[64]
    ;
    if(sscanf(params, "ds[64]", to_player, description))
        return 1;
    
    
    new logs_query[150];
    format
    (
        logs_query, sizeof logs_query, 
        "INSERT INTO `admin_logs` (`account_id`, `description`) VALUES ('%d', '%s')",
        GetPlayerData(to_player, PLAYER_ID),
        description
    );
    mysql_tquery(mysql, logs_query);

    new chat_msg[144];
    SendClientMessage(to_player, -1, "[A] Вас кикнул администратор");
    format(chat_msg, sizeof chat_msg, "Причина: %s", description);
    SendClientMessage(to_player, -1, chat_msg);

    return 1;
}

CMD:ban(playerid, params[])
{
    new
        to_player,
        description[64]
    ;
    if(sscanf(params, "ds[64]", to_player, description))
        return 1;
    
    
    new logs_query[128];
    format
    (
        logs_query, sizeof logs_query, 
        "INSERT INTO "DB_ADMIN_LOGS" (`account_id`, `description`) VALUES ('%d, '%s')",
        GetPlayerData(to_player, PLAYER_ID),
        description
    );
    mysql_tquery(mysql, logs_query);

    new chat_msg[144];
    SendClientMessage(to_player, -1, "[A] Вы были заблокированы администратором.");
    format(chat_msg, sizeof chat_msg, "Причина: %s", description);
    SendClientMessage(to_player, -1, chat_msg);
    
    return 1;
}

CMD:admin_logs(playerid) 
{
    AdminLogs:ShowDialog(playerid);
    return 1;
}

stock AdminLogs:ShowDialog(playerid)
{

    mysql_tquery
    (
        mysql, "SELECT "DB_ACCOUNT".name, "DB_ADMIN_LOGS".description, "DB_ADMIN_LOGS".created_at \
        FROM "DB_ADMIN_LOGS" JOIN "DB_ACCOUNT" ON \
        "DB_ADMIN_LOGS".account_id = "DB_ACCOUNT".id ORDER BY created_at DESC LIMIT 25", 
        DatabaseText(Database:LoadAdminLogs), "d", playerid
    );

    return 1;
}

public: Database:LoadAdminLogs(playerid) 
{
    new rows = cache_num_rows();

    if(!rows)
        return 0;

    for(new row_id, count_elements; row_id < rows; row_id++) 
    {
        new 
            name[MAX_PLAYER_NAME],
            description[64],
            created_at[30]
        ;

        cache_get_value_name(row_id, "name", name);
        cache_get_value_name(row_id, "description", description);
        cache_get_value_name(row_id, "created_at", created_at);
        
        format
        (
            FormatData_2048, sizeof FormatData_2048,
            "%s%s\t%s\t%s\n",
            FormatData_2048, name, description, created_at
        );

        //SetPlayerListitem(playerid, count_elements, row_id);

        count_elements++;
    } 
    
    new dialog_header[70];
	strcat(dialog_header, "Ник\tПричина\tДата блокировки\n");

	//if(count_elements > MAX_ELEMENTS_ON_PAGE) strcat(dialog_header, ""DIALOG_NEXT_PAGE_TEXT"\n");
	//if(page > 0) strcat(dialog_header, ""DIALOG_PREVIOUS_PAGE_TEXT"\n");

	strins(FormatData_2048, dialog_header, 0);

    Dialog_Open
    (
        playerid, Dialog:D_ADMIN_LOGS, DIALOG_STYLE_TABLIST_HEADERS, 
        "Список админских логов", 
        FormatData_2048, 
        "Выбрать", "Закрыть"
    );
   
    FormatData_2048="";
    return 1;
}

DialogResponse:D_ADMIN_LOGS(playerid, response, listitem, inputtext[]) 
{
    if(!response)
        return 1;
    
    if(!strcmp(inputtext, DIALOG_NEXT_PAGE_TEXT))
    {
        SetPlayerPage(playerid, GetPlayerPage(playerid) + 1);
        Dialog_Show(playerid, Dialog: D_ADMIN_LOGS);
    }
    else if(!strcmp(inputtext, DIALOG_PREVIOUS_PAGE_TEXT))
    {
        SetPlayerPage(playerid, GetPlayerPage(playerid) - 1);
        Dialog_Show(playerid, Dialog: D_ADMIN_LOGS);
    }
    return 1;
}