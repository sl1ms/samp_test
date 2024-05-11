
stock Accessories:LoadData()
{
    mysql_tquery(mysql, "SELECT * FROM "DB_ACCESSORIES_DATA" WHERE 1", DatabaseText(Database:LoadAccessoryData), "");
    return 1;
}

public: Database:LoadAccessoryData()
{   // Загрузка общей информации об аксессуаров.
    if(!cache_num_rows())
        return 0;

    new tick = GetTickCount();

    for(new row_id = 0; row_id < cache_num_rows(); row_id++, TOTAL_ACCESSORIES++)
    {
        cache_get_value_name_int(row_id, "id", GetAccessoryData(row_id, ACCESSORY_SQL_ID));

        cache_get_value_name(row_id, "name", GetAccessoryData(row_id, ACCESSORY_NAME));

        cache_get_value_name_int(row_id, "model", GetAccessoryData(row_id, ACCESSORY_MODEL));
        cache_get_value_name_int(row_id, "bone", GetAccessoryData(row_id, ACCESSORY_BONE));

        cache_get_value_name_float(row_id, "offset_x", GetAccessoryData(row_id, ACCESSORY_OFFSET_X));
        cache_get_value_name_float(row_id, "offset_y", GetAccessoryData(row_id, ACCESSORY_OFFSET_Y));
        cache_get_value_name_float(row_id, "offset_x", GetAccessoryData(row_id, ACCESSORY_OFFSET_Z));

        cache_get_value_name_float(row_id, "rot_x", GetAccessoryData(row_id, ACCESSORY_ROT_X));
        cache_get_value_name_float(row_id, "rot_y", GetAccessoryData(row_id, ACCESSORY_ROT_Y));
        cache_get_value_name_float(row_id, "rot_z", GetAccessoryData(row_id, ACCESSORY_ROT_Z));

        cache_get_value_name_float(row_id, "scale_x", GetAccessoryData(row_id, ACCESSORY_SCALE_X));
        cache_get_value_name_float(row_id, "scale_y", GetAccessoryData(row_id, ACCESSORY_SCALE_Y));
        cache_get_value_name_float(row_id, "scale_z", GetAccessoryData(row_id, ACCESSORY_SCALE_Z));

        cache_get_value_name_int(row_id, "materialcolor1", GetAccessoryData(row_id, ACCESSORY_MATERIAL_COLOR1));
        cache_get_value_name_int(row_id, "materialcolor2", GetAccessoryData(row_id, ACCESSORY_MATERIAL_COLOR2));
    }

    printf("[Accessories] table loaded %d. (tick: %d ms)", TOTAL_ACCESSORIES, GetTickCount() - tick);
   
    return 1;
}

stock Accessories:LoadPlayerData(playerid) 
{
    new accessory_query[128];

    return 1;
}



stock Accessories:SetPlayerAttachedObjectEx(playerid, index, modelid, bone, Float:fOffsetX = 0.0, Float:fOffsetY = 0.0, Float:fOffsetZ = 0.0, Float:fRotX = 0.0, Float:fRotY = 0.0, Float:fRotZ = 0.0, Float:fScaleX = 1.0, Float:fScaleY = 1.0, Float:fScaleZ = 1.0, materialcolor1 = 0, materialcolor2 = 0) 
{
    new accessory_slot = GetPVarInt(playerid, #ACCESSORY_TEMP_SLOT);

    SetPlayerAccessoryData(playerid, P_ACCESSORY_MODEL, modelid, accessory_slot);
    SetPlayerAccessoryData(playerid, P_ACCESSORY_BONE, bone, accessory_slot);
    SetPlayerAccessoryData(playerid, P_ACCESSORY_OFFSET_X, fOffsetX, accessory_slot);
    SetPlayerAccessoryData(playerid, P_ACCESSORY_OFFSET_Y, fOffsetY, accessory_slot);
    SetPlayerAccessoryData(playerid, P_ACCESSORY_OFFSET_Z, fOffsetZ, accessory_slot);
    SetPlayerAccessoryData(playerid, P_ACCESSORY_ROT_X, fRotX, accessory_slot);
    SetPlayerAccessoryData(playerid, P_ACCESSORY_ROT_Y, fRotY, accessory_slot);
    SetPlayerAccessoryData(playerid, P_ACCESSORY_ROT_Z, fRotZ, accessory_slot);
    SetPlayerAccessoryData(playerid, P_ACCESSORY_SCALE_X, fScaleX, accessory_slot);
    SetPlayerAccessoryData(playerid, P_ACCESSORY_SCALE_Y, fScaleY, accessory_slot);
    SetPlayerAccessoryData(playerid, P_ACCESSORY_SCALE_Z, fScaleZ, accessory_slot);
    SetPlayerAccessoryData(playerid, P_ACCESSORY_MATERIAL_COLOR1, materialcolor1, accessory_slot);
    SetPlayerAccessoryData(playerid, P_ACCESSORY_MATERIAL_COLOR2, materialcolor2, accessory_slot);

    SetPlayerAttachedObject
    (
        playerid, 
        index, 
        modelid, 
        bone, 
        fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ, 
        materialcolor1, 
        materialcolor2
    );

    return 1;
}

CMD:give_accessory(playerid, params[]) 
{
    extract params -> new to_player; else 
        return SendClientMessage(playerid, -1, !"Введите команду: /give_accessory [ID]");

    if(!IsPlayerConnected(to_player))
        return SendClientMessage(playerid, -1, !"Данный игрок не подключен к серверу.");

    if(!GetPlayerData(to_player, PLAYER_AUTHORIZED))
        return SendClientMessage(playerid, -1, !"Данный игрок не авторизирован.");

    SetPVarInt(playerid, #ACCESSORY_PLAYER_ID, to_player);

    Dialog_Show(playerid, Dialog: D_GIVE_ACCESSORY_LIST);

    return 1;
}

DialogCreate:D_GIVE_ACCESSORY_LIST(playerid)
{
    new 
        count_elements = 0,
        page = GetPlayerPage(playerid);

    FormatData_2048 = "Model\tName\tCategory\n";

    for(new accessory_index = 0; accessory_index < TOTAL_ACCESSORIES; accessory_index++)
    {
        format
        (
            FormatData_2048, sizeof FormatData_2048, "\
            %s%d\t%s\t-\n",
            FormatData_2048,
            GetAccessoryData(accessory_index, ACCESSORY_MODEL),
            GetAccessoryData(accessory_index, ACCESSORY_NAME)
        );

        SetPlayerListItem(playerid, count_elements, accessory_index);
        count_elements++;

        if(count_elements > MAX_ELEMENTS_ON_PAGE)
            break;
    }

	if(count_elements == 0)
	{
		DeletePlayerPage(playerid);
		return 0;
	}

    if(count_elements > MAX_ELEMENTS_ON_PAGE) strcat(FormatData_2048, ""DIALOG_NEXT_PAGE_TEXT"\n");
	if(page > 0) strcat(FormatData_2048, ""DIALOG_PREVIOUS_PAGE_TEXT"\n");

    Dialog_Open
    (
        playerid, 
        Dialog: D_GIVE_ACCESSORY_LIST, DIALOG_STYLE_TABLIST_HEADERS,
        "Общий список аксессуаров", FormatData_2048, 
        "Выбрать", "Закрыть"
    );

    return 1;
}

DialogResponse:D_GIVE_ACCESSORY_LIST(playerid, response, listitem, inputtext[])
{
    if(!response) 
    {
        if(GetPlayerPage(playerid)) 
        {
            DeletePlayerPage(playerid);
        }
    }

    if(!strcmp(inputtext, DIALOG_NEXT_PAGE_TEXT))
    {
        SetPlayerPage(playerid, GetPlayerPage(playerid) + 1);
        Dialog_Show(playerid, Dialog: D_GIVE_ACCESSORY_LIST);
    }
    else if(!strcmp(inputtext, DIALOG_PREVIOUS_PAGE_TEXT))
    {
        SetPlayerPage(playerid, GetPlayerPage(playerid) - 1);
        Dialog_Show(playerid, Dialog: D_GIVE_ACCESSORY_LIST);
    }
    else 
    {
        SetPVarInt(playerid, #SELECT_ACCESSORY_INDEX, listitem);
        Dialog_Show(playerid, Dialog: D_GIVE_ACCESSORY_SELECT);
    }

    return 1;
}

DialogCreate:D_GIVE_ACCESSORY_SELECT(playerid)
{
    new 
        to_player = GetPVarInt(playerid, #ACCESSORY_PLAYER_ID),
        select_index = GetPVarInt(playerid, #SELECT_ACCESSORY_INDEX),
        accessory_index = GetPlayerListItem(playerid, select_index);

    format
    (
        FormatData_2048, sizeof FormatData_2048,"\
        Наименование аксессуара: %s\n\
        Вы действительно хотите выдать аксессуар %s(%d)?",
        GetAccessoryData(accessory_index, ACCESSORY_NAME),
        GetPlayerData(to_player, PLAYER_NAME),
        to_player
    );

    Dialog_Open
    (
        playerid, 
        Dialog: D_GIVE_ACCESSORY_SELECT, DIALOG_STYLE_MSGBOX,
        "Подтверждение", FormatData_2048, 
        "Выбрать", "Закрыть"
    );
    return 1;
}

DialogResponse:D_GIVE_ACCESSORY_SELECT(playerid, response, listitem, inputtext[])
{
    new 
        to_player = GetPVarInt(playerid, #ACCESSORY_PLAYER_ID),
        select_index = GetPVarInt(playerid, #SELECT_ACCESSORY_INDEX),
        accessory_index = GetPlayerListItem(playerid, select_index);
    
    DeletePlayerPage(playerid);
    DeletePVar(playerid, #ACCESSORY_PLAYER_ID);
    DeletePVar(playerid, #SELECT_ACCESSORY_INDEX);

    if(!response)
        return 1;

    

    return 1;
}