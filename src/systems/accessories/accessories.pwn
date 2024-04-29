
stock SetPlayerAttachedObjectEx(playerid, a_index, a_modelid, a_boneid, Float: a_fOffsetX, Float: a_fOffsetY, Float: a_fOffsetZ, Float:a_fRotX, \
    Float: a_fRotY, Float: a_fRotZ, Float: a_fScaleX, Float: a_fScaleY, Float: a_fScaleZ, materialcolor1, materialcolor2, extra = INVALID_ACC_INDEX)
{
    new acc_slot = GetPVarInt(playerid, #ACC_TEMP_SLOT);
    

    SetPlayerAccSlot(playerid, acc_slot, E_PA_SLOT, a_index);
    SetPlayerAccSlot(playerid, acc_slot, E_PA_MODEL, a_modelid);
    SetPlayerAccSlot(playerid, acc_slot, E_PA_BONE, a_boneid);

    SetPlayerAccSlot(playerid, acc_slot, E_PA_OFFSET_X, a_fOffsetX);
    SetPlayerAccSlot(playerid, acc_slot, E_PA_OFFSET_Y, a_fOffsetY);
    SetPlayerAccSlot(playerid, acc_slot, E_PA_OFFSET_Z, a_fOffsetZ);

    SetPlayerAccSlot(playerid, acc_slot, E_PA_ROT_X, a_fRotX);
    SetPlayerAccSlot(playerid, acc_slot, E_PA_ROT_Y, a_fRotY);
    SetPlayerAccSlot(playerid, acc_slot, E_PA_ROT_Z, a_fRotZ);

    SetPlayerAccSlot(playerid, acc_slot, E_PA_SCALE_X, a_fScaleX);
    SetPlayerAccSlot(playerid, acc_slot, E_PA_SCALE_Y, a_fScaleY);
    SetPlayerAccSlot(playerid, acc_slot, E_PA_SCALE_Z, a_fScaleZ);

    SetPlayerAccSlot(playerid, acc_slot, E_PA_MATCOLOR_1, materialcolor1);
    SetPlayerAccSlot(playerid, acc_slot, E_PA_MATCOLOR_2, materialcolor2);

    

    SetPlayerAttachedObject
    (
        playerid,
        GetPlayerAccSlot(playerid, acc_slot, E_PA_SLOT),
        GetPlayerAccSlot(playerid, acc_slot, E_PA_MODEL),
        GetPlayerAccSlot(playerid, acc_slot, E_PA_BONE),
        GetPlayerAccSlot(playerid, acc_slot, E_PA_OFFSET_X),
        GetPlayerAccSlot(playerid, acc_slot, E_PA_OFFSET_Y),
        GetPlayerAccSlot(playerid, acc_slot, E_PA_OFFSET_Z),
        GetPlayerAccSlot(playerid, acc_slot, E_PA_ROT_X),
        GetPlayerAccSlot(playerid, acc_slot, E_PA_ROT_Y),
        GetPlayerAccSlot(playerid, acc_slot, E_PA_ROT_Z),
        GetPlayerAccSlot(playerid, acc_slot, E_PA_SCALE_X),
        GetPlayerAccSlot(playerid, acc_slot, E_PA_SCALE_Y),
        GetPlayerAccSlot(playerid, acc_slot, E_PA_SCALE_Z),
        GetPlayerAccSlot(playerid, acc_slot, E_PA_MATCOLOR_1),
        GetPlayerAccSlot(playerid, acc_slot, E_PA_MATCOLOR_2)
    );

    return 1;
}
stock Accessories:LoadDataInfo() {
    mysql_tquery
    (
        mysql, "SELECT \
        "DB_ACCESSORIES_DATA".*, \
        "DB_ACCESSORIES_DESCRIPTION".description \
        FROM "DB_ACCESSORIES_DATA" \
        JOIN "DB_ACCESSORIES_DESCRIPTION" \
        ON "DB_ACCESSORIES_DATA".description_id = "DB_ACCESSORIES_DESCRIPTION".id", 
        DatabaseText(Database:LoadAccessoriesData), ""
    );
    return 1;
}
    
public: Database:LoadAccessoriesData()
{  
    for(new row_id; row_id < cache_num_rows(); row_id++)
    {
        cache_get_value_name_int(row_id, "id", g_accessories_data[row_id][ACCESSORY_SQL_ID]);

        cache_get_value_name(row_id, "name",  g_accessories_data[row_id][ACCESSORY_NAME]);
        cache_get_value_name_int(row_id, "slot", g_accessories_data[row_id][ACCESSORY_SLOT]);

        cache_get_value_name_int(row_id, "model", g_accessories_data[row_id][ACCESSORY_MODEL]);
        cache_get_value_name_int(row_id, "bone", g_accessories_data[row_id][ACCESSORY_BONE]);

        cache_get_value_name_float(row_id, "offset_x", g_accessories_data[row_id][ACCESSORY_OFFSET_X]);
        cache_get_value_name_float(row_id, "offset_y", g_accessories_data[row_id][ACCESSORY_OFFSET_Y]);
        cache_get_value_name_float(row_id, "offset_z", g_accessories_data[row_id][ACCESSORY_OFFSET_Z]);

        cache_get_value_name_float(row_id, "rot_x", g_accessories_data[row_id][ACCESSORY_ROT_X]);
        cache_get_value_name_float(row_id, "rot_y", g_accessories_data[row_id][ACCESSORY_ROT_Y]);
        cache_get_value_name_float(row_id, "rot_z", g_accessories_data[row_id][ACCESSORY_ROT_Z]);

        cache_get_value_name_float(row_id, "scale_x", g_accessories_data[row_id][ACCESSORY_SCALE_X]);
        cache_get_value_name_float(row_id, "scale_y", g_accessories_data[row_id][ACCESSORY_SCALE_Y]);
        cache_get_value_name_float(row_id, "scale_z", g_accessories_data[row_id][ACCESSORY_SCALE_Z]);

        cache_get_value_name_int(row_id, "materialcolor1", g_accessories_data[row_id][ACCESSORY_MATERIAL_COLOR1]);
        cache_get_value_name_int(row_id, "materialcolor2", g_accessories_data[row_id][ACCESSORY_MATERIAL_COLOR2]);
    
        cache_get_value_name(row_id, "description",  g_accessories_data[row_id][ACCESSORY_DESCRIPTION]);

        g_quantity_accessories++;

        

       // printf("%s", g_accessories_data[row_id][ACCESSORY_DESCRIPTION]);
    }

    return 1;
}

stock Accessories:LoadPlayerData(playerid)
{
    
    new acs_query[600];
    
    format
    (
        acs_query, sizeof acs_query, "\
        SELECT "DB_ACCESSORIES_DATA".*, "DB_ACCESSORIES_DESCRIPTION".description, \
        "DB_ACCESSORIES".slot1, "DB_ACCESSORIES".slot2, "DB_ACCESSORIES".slot3, \
        "DB_ACCESSORIES".slot4, "DB_ACCESSORIES".slot5, "DB_ACCESSORIES".slot6, \
        "DB_ACCESSORIES".slot7, "DB_ACCESSORIES".slot8, "DB_ACCESSORIES".slot9, \
        "DB_ACCESSORIES".slot10 \
        FROM "DB_ACCESSORIES_DATA" JOIN "DB_ACCESSORIES" \
        ON "DB_ACCESSORIES_DATA".id = "DB_ACCESSORIES".slot1 \
        OR "DB_ACCESSORIES_DATA".id = "DB_ACCESSORIES".slot2 \
        OR "DB_ACCESSORIES_DATA".id = "DB_ACCESSORIES".slot3 \
        OR "DB_ACCESSORIES_DATA".id = "DB_ACCESSORIES".slot4 \
        OR "DB_ACCESSORIES_DATA".id = "DB_ACCESSORIES".slot5 \
        OR "DB_ACCESSORIES_DATA".id = "DB_ACCESSORIES".slot6 \
        OR "DB_ACCESSORIES_DATA".id = "DB_ACCESSORIES".slot7 \
        OR "DB_ACCESSORIES_DATA".id = "DB_ACCESSORIES".slot8 \
        OR "DB_ACCESSORIES_DATA".id = "DB_ACCESSORIES".slot9 \
        OR "DB_ACCESSORIES_DATA".id = "DB_ACCESSORIES".slot10 \
        JOIN "DB_ACCOUNT" ON "DB_ACCOUNT".id = "DB_ACCESSORIES".account_id \
        JOIN "DB_ACCESSORIES_DESCRIPTION" ON "DB_ACCESSORIES_DATA".description_id = "DB_ACCESSORIES_DESCRIPTION".id \
        WHERE "DB_ACCOUNT".id = %d", GetPlayerData(playerid, PLAYER_ID)
    );
    

    // format(acs_query, sizeof acs_query, "select * from "DB_ACCESSORIES" where `account_id` = '%d'", 
    // GetPlayerData(playerid, PLAYER_ID));

   // mysql_tquery(mysql, acs_query, DatabaseText(Database:LoadPlayerAccessory), "d", playerid);
    return 1;
}


public: Database:LoadPlayerAccessory(playerid)
{
    new rows = cache_num_rows();

    if(!rows)
        return 1;

    new acc_slot;

    for(new i; i < rows; i++)
    {
        cache_get_value_name_int(i, "slot", acc_slot);

        g_player_accessory[playerid][acc_slot][E_PA_USED] = true;
        g_player_accessory[playerid][acc_slot][E_PA_SLOT] = acc_slot;

        /*

        cache_get_value_name_int(i, "id", g_player_accessory[playerid][acc_slot][E_PA_SQL_ID]);
        cache_get_value_name_int(i, "model", g_player_accessory[playerid][acc_slot][E_PA_MODEL]);

        cache_get_value_name_float(i, "offset_x", g_player_accessory[playerid][acc_slot][E_PA_OFFSET_X]);
        cache_get_value_name_float(i, "offset_y", g_player_accessory[playerid][acc_slot][E_PA_OFFSET_Y]);
        cache_get_value_name_float(i, "offset_z", g_player_accessory[playerid][acc_slot][E_PA_OFFSET_Z]);

        cache_get_value_name_float(i, "rot_x", g_player_accessory[playerid][acc_slot][E_PA_ROT_X]);
        cache_get_value_name_float(i, "rot_y", g_player_accessory[playerid][acc_slot][E_PA_ROT_Y]);
        cache_get_value_name_float(i, "rot_z", g_player_accessory[playerid][acc_slot][E_PA_ROT_Z]);

        cache_get_value_name_float(i, "scale_x", g_player_accessory[playerid][acc_slot][E_PA_SCALE_X]);
        cache_get_value_name_float(i, "scale_y", g_player_accessory[playerid][acc_slot][E_PA_SCALE_Y]);
        cache_get_value_name_float(i, "scale_z", g_player_accessory[playerid][acc_slot][E_PA_SCALE_Z]);

        cache_get_value_name_int(i, "materialcolor1", g_player_accessory[playerid][acc_slot][E_PA_MATCOLOR_1]);
        cache_get_value_name_int(i, "materialcolor2", g_player_accessory[playerid][acc_slot][E_PA_MATCOLOR_2]);
    */
    }

	return 1;
}

stock Accessories:GetItemName(model)
{
    new name[20] = "";

    for(new i; i < g_quantity_accessories; i++)
    {
        if(g_accessories_data[i][ACCESSORY_MODEL] == model)
        {
            strcat(name, g_accessories_data[i][ACCESSORY_NAME]);
        }
    }

    return name;
}

stock Accessories:GetDescriptionText(model)
{
    new description[128] = "";

    for(new i; i < g_quantity_accessories; i++)
    {
        if(g_accessories_data[i][ACCESSORY_MODEL] == model)
        {
            strcat(description, g_accessories_data[i][ACCESSORY_DESCRIPTION]);
        }
    }

    return description;
}

stock Accessories:SetPlayerAttached(playerid, model)
{
    new attach_slot = -1;

    for(new i; i < MAX_PLAYER_ATTACHED_OBJECTS; i++)
    {
        if(IsPlayerAttachedObjectSlotUsed(playerid, i))
            continue;

        attach_slot = i;
        break;
    }

    if(attach_slot == -1)
        return 0;

    SetPVarInt(playerid, #ACC_TEMP_SLOT, attach_slot);

    new result = Accessories:AttachToPlayer(playerid, model, attach_slot);

    if(result == INVALID_ACC_INDEX)
        return SendClientMessage(playerid, -1, "Аксессуар не будет отображаться на этом скине!");
    else if(result == 0)
        return SendClientMessage(playerid, -1, "Ошибка использования аксессуара");

    return attach_slot;
}

stock Accessories:GetFreeSlotID(playerid) {
    
    for(new i; i < MAX_MY_ACCESSORIES; i++) {
        if(GetPlayerAccessoryUniqueID(playerid, i) != -1)
            continue;
        
        return i;
    }
    return -1;
}


stock Accessories:UnAttachAcc(playerid)
{
    new 
        accessory_index = GetPVarInt(playerid, #SELECT_ACCESSORY_INDEX),
        accessory_slot = g_temp_accessories_listitem[playerid][accessory_index];

    
    if(IsPlayerAttachedObjectSlotUsed(playerid, GetPlayerAccSlot(playerid, accessory_slot, E_PA_SLOT)))
        RemovePlayerAttachedObject(playerid, GetPlayerAccSlot(playerid, accessory_slot, E_PA_SLOT));


    new query[84];
    format
    (
        query, sizeof query,
        "UPDATE "#DB_ACCESSORIES" SET `slot1` = DEFAULT WHERE `account_id` = '%d'",
        GetPlayerData(playerid, PLAYER_ID)
    );
    mysql_tquery(mysql, query);

    g_player_accessory[playerid][accessory_slot] = g_player_accessory_default;

    Accessories:Update(playerid);
    
    return 1;
}


stock Accessories:Update(playerid)
{
    for(new i = 0;  i< MAX_MY_ACCESSORIES; i++)
    {
        if(IsPlayerAttachedObjectSlotUsed(playerid, i))
            RemovePlayerAttachedObject(playerid, i);
    }

	for(new idx = 0; idx < MAX_MY_ACCESSORIES; idx++)
	{
		if(GetPlayerAccSlot(playerid, idx, E_PA_USED))
		{
			SetPlayerAttachedObject
            (
                playerid, GetPlayerAccSlot(playerid, idx, E_PA_SLOT),
                g_accessories_data[idx][ACCESSORY_MODEL], g_accessories_data[idx][ACCESSORY_BONE],
                g_accessories_data[idx][ACCESSORY_OFFSET_X], g_accessories_data[idx][ACCESSORY_OFFSET_Y], g_accessories_data[idx][ACCESSORY_OFFSET_Z],
                g_accessories_data[idx][ACCESSORY_ROT_X], g_accessories_data[idx][ACCESSORY_ROT_Y], g_accessories_data[idx][ACCESSORY_ROT_Z],
                g_accessories_data[idx][ACCESSORY_SCALE_X], g_accessories_data[idx][ACCESSORY_SCALE_Y], g_accessories_data[idx][ACCESSORY_SCALE_Z], 
                g_accessories_data[idx][ACCESSORY_MATERIAL_COLOR1], g_accessories_data[idx][ACCESSORY_MATERIAL_COLOR2]
            );
		}
	}
	return 1;
}

stock Accessories:AttachToPlayer(playerid, model, attach_slot)
{
    if(attach_slot == -1)
        return 0;

    for(new idx; idx < g_quantity_accessories; idx++)
    {
      
        if(g_accessories_data[idx][ACCESSORY_MODEL] == model)
        {
            return SetPlayerAttachedObjectEx\
            (\
                playerid, attach_slot, \
                g_accessories_data[idx][ACCESSORY_MODEL], g_accessories_data[idx][ACCESSORY_BONE],\
                g_accessories_data[idx][ACCESSORY_OFFSET_X], g_accessories_data[idx][ACCESSORY_OFFSET_Y], g_accessories_data[idx][ACCESSORY_OFFSET_Z],\
                g_accessories_data[idx][ACCESSORY_ROT_X], g_accessories_data[idx][ACCESSORY_ROT_Y], g_accessories_data[idx][ACCESSORY_ROT_Z],\
                g_accessories_data[idx][ACCESSORY_SCALE_X], g_accessories_data[idx][ACCESSORY_SCALE_Y], g_accessories_data[idx][ACCESSORY_SCALE_Z], \
                g_accessories_data[idx][ACCESSORY_MATERIAL_COLOR1], g_accessories_data[idx][ACCESSORY_MATERIAL_COLOR2]
            );
        }
    }
    return 0;
}

DialogCreate:D_ACCESSORY_LIST(playerid)
{
    new page = GetPlayerPage(playerid);
	new count_elements = 0;

    for(new i = page * MAX_ELEMENTS_ON_PAGE; i < MAX_ACCESSORIES; i++)
    {
        format
        (
            FormatData_2048,
            sizeof FormatData_2048,
            "%s%i\t%s\n", FormatData_2048,
            g_accessories_data[i][ACCESSORY_MODEL], 
            g_accessories_data[i][ACCESSORY_NAME]
        );

        SetPlayerListItem(playerid, count_elements, i);
        count_elements++;

        if(count_elements > MAX_ELEMENTS_ON_PAGE)
            break;
    }

	if(count_elements == 0)
	{
		DeletePlayerPage(playerid);
		return 0;
	}

	new dialog_header[70];
	strcat(dialog_header, "Model\tName\n");

	if(count_elements > MAX_ELEMENTS_ON_PAGE) strcat(dialog_header, ""DIALOG_NEXT_PAGE_TEXT"\n");
	if(page > 0) strcat(dialog_header, ""DIALOG_PREVIOUS_PAGE_TEXT"\n");

	strins(FormatData_2048, dialog_header, 0);

    Dialog_Open
    (
        playerid, 
        Dialog: D_ACCESSORY_LIST, 
        DIALOG_STYLE_TABLIST_HEADERS,
        "Общий список аксессуаров",
        FormatData_2048,
        "Закрыть", ""
    );

    FormatData_2048="";
    return 1;
}

DialogResponse:D_ACCESSORY_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        if(GetPlayerPage(playerid))
            DeletePlayerPage(playerid);

        Dialog_Show(playerid, Dialog: D_ACCESSORY);
        return 1;
    }
    

    if(!strcmp(inputtext, DIALOG_NEXT_PAGE_TEXT))
    {
        SetPlayerPage(playerid, GetPlayerPage(playerid) + 1);
        Dialog_Show(playerid, Dialog: D_ACCESSORY_LIST);
    }
    else if(!strcmp(inputtext, DIALOG_PREVIOUS_PAGE_TEXT))
    {
        SetPlayerPage(playerid, GetPlayerPage(playerid) - 1);
        Dialog_Show(playerid, Dialog: D_ACCESSORY_LIST);
    }
    else 
    {
        SetPVarInt(playerid, #ACCESORY_INDEX, listitem);
        Dialog_Show(playerid, Dialog: D_ACCESSORY_EDIT);
    }

    return 1;
}

DialogCreate:D_ACCESSORY_EDIT(playerid)
{
  
    Dialog_Open
    (
        playerid, 
        Dialog: D_ACCESSORY_EDIT, DIALOG_STYLE_LIST,
        "Редактирования", "\
        Изменить модель аксессуара\n\
        Изменить часть тела для аксессуара\n\
        Изменить позицию аксессуара",
        "Выбрать", "Назад"
    );
    return 1;
}

DialogResponse:D_ACCESSORY_EDIT(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    switch(listitem)
    {
        case 0: Dialog_Show(playerid, Dialog: D_ACCESSORY_EDIT_MODEL);
        case 1: Dialog_Show(playerid, Dialog: D_ACCESSORY_EDIT_BONE);
        case 2: 
        {
            new 
                listitem_index = GetPVarInt(playerid, #ACCESORY_INDEX),
                index_accessory = GetPlayerListItem(playerid, listitem_index);

            CancelEdit(playerid);

            SetPVarInt(playerid, #ACCESSORY_EDIT, 2);

            EditAttachedObject(playerid, g_accessories_data[index_accessory][ACCESSORY_SLOT]);
        }
    }
    return 1;
}
DialogCreate:D_ACCESSORY_EDIT_MODEL(playerid)
{ 
    new 
        listitem_index = GetPVarInt(playerid, #ACCESORY_INDEX),
        index_accessory = GetPlayerListItem(playerid, listitem_index);

    format
    (
        FormatData_2048, sizeof FormatData_2048,"\
        Аксессуар: %s [SQL_ID: %d]\n\
        Текущая модель: %d\n\
        "c_white"Укажите параметры [модель] (Model)\n\n\
        Пример: 19308",
        g_accessories_data[index_accessory][ACCESSORY_NAME],
        g_accessories_data[index_accessory][ACCESSORY_SQL_ID],
        g_accessories_data[index_accessory][ACCESSORY_MODEL]
    );

    Dialog_Open
    (
        playerid, 
        Dialog: D_ACCESSORY_EDIT_MODEL, DIALOG_STYLE_INPUT,
        "Редактирование модели аксессуара", FormatData_2048,
        "Выбрать", "Назад"
    );

    FormatData_2048="";
    return 1;
}

DialogResponse:D_ACCESSORY_EDIT_MODEL(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    new 
        model,
        listitem_index = GetPVarInt(playerid, #ACCESORY_INDEX),
        index_accessory = GetPlayerListItem(playerid, listitem_index);

    if(sscanf(inputtext,"d", model))
        return Dialog_Show(playerid, Dialog: D_ACCESSORY_EDIT_MODEL);

    g_accessories_data[index_accessory][ACCESSORY_MODEL] = model;
    
    
    new update_query[128];

    format(update_query, sizeof update_query, "UPDATE "DB_ACCESSORIES_DATA" SET `model` = '%d' WHERE `id` = '%d'",
        model, g_accessories_data[index_accessory][ACCESSORY_SQL_ID]);

    mysql_tquery(mysql, update_query);

    for(new i; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && GetPlayerData(i, PLAYER_AUTHORIZED)) {
            Accessories:EditUpdateForPlayer(i);
        }
    }

    return 1;
}

DialogCreate:D_ACCESSORY_EDIT_BONE(playerid)
{ 
    new 
        listitem_index = GetPVarInt(playerid, #ACCESORY_INDEX),
        index_accessory = GetPlayerListItem(playerid, listitem_index);

    format
    (
        FormatData_2048, sizeof FormatData_2048,"\
        Аксессуар: %s [SQL_ID: %d]\n\
        Текущая часть тела: %d\n\
        "c_white"Укажите параметры [часть тела] (Bone)\n\n\
        1 - Торс\n\
        2 - Голова\n\
        3 - Левое плечо\n\
        4 - Правое плечо\n\
        5 - Левая рука\n\
        6 - Правая рука\n\
        7 - Левое бедро\n\
        8 - Правое бедро\n\
        9 - Левая нога\n\
        10 - Правая нога\n\
        11 - Правая голень\n\
        12 - Левая голень\n\
        13 - Левое предплечье\n\
        14 - Правое предплечье\n\
        15 - Левая ключица (плечо)\n\
	    16 - Правая ключица (плечо)\n\
	    17 - Шея\n\
	    18 - Челюсть\n\
        Пример: 1",
        g_accessories_data[index_accessory][ACCESSORY_NAME],
        g_accessories_data[index_accessory][ACCESSORY_SQL_ID],
        g_accessories_data[index_accessory][ACCESSORY_BONE]
    );

    Dialog_Open
    (
        playerid, 
        Dialog: D_ACCESSORY_EDIT_BONE, DIALOG_STYLE_INPUT,
        "Редактирование ч. тела аксессуара", FormatData_2048,
        "Выбрать", "Назад"
    );

    FormatData_2048="";
    return 1;
}

DialogResponse:D_ACCESSORY_EDIT_BONE(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    new 
        bone,
        listitem_index = GetPVarInt(playerid, #ACCESORY_INDEX),
        index_accessory = GetPlayerListItem(playerid, listitem_index);

    if(sscanf(inputtext,"d", bone))
        return Dialog_Show(playerid, Dialog: D_ACCESSORY_EDIT_BONE);
    
    if(!(1 <= bone <= 18))
        return Dialog_Show(playerid, Dialog: D_ACCESSORY_EDIT_BONE);

    g_accessories_data[index_accessory][ACCESSORY_BONE] = bone;

    new update_query[128];

    format(update_query, sizeof update_query, "UPDATE "DB_ACCESSORIES_DATA" SET `bone` = '%d' WHERE `id` = '%d'",
        bone, g_accessories_data[index_accessory][ACCESSORY_SQL_ID]);

    mysql_tquery(mysql, update_query);

    for(new i; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && GetPlayerData(i, PLAYER_AUTHORIZED)) {
            Accessories:EditUpdateForPlayer(i);
        }
    }

    return 1;
}

/*
DialogCreate:D_ACCESSORY_EDIT_POS(playerid)
{ 
    new 
        listitem_index = GetPVarInt(playerid, #ACCESORY_INDEX),
        index_accessory = GetPlayerListItem(playerid, listitem_index);

    format
    (
        FormatData_2048, sizeof FormatData_2048,"\
        Аксессуар: %s [SQL_ID: %d]\n\
        Текущая позиция: %f, %f, %f\n\
        "c_white"Укажите параметры [позиция] (Offset_X, Offeset_Y, Offset_Z)\n\n\
        Пример: 0.00, 0.00, 0.00 (через запятую)",
        g_accessories_data[index_accessory][ACCESSORY_NAME],
        g_accessories_data[index_accessory][ACCESSORY_SQL_ID],
        g_accessories_data[index_accessory][ACCESSORY_OFFSET_X],
        g_accessories_data[index_accessory][ACCESSORY_OFFSET_Y],
        g_accessories_data[index_accessory][ACCESSORY_OFFSET_Z]
    );

    Dialog_Open
    (
        playerid, 
        Dialog: D_ACCESSORY_EDIT_POS, DIALOG_STYLE_INPUT,
        "Редактирование позиции аксессуара", FormatData_2048,
        "Выбрать", "Назад"
    );

    FormatData_2048="";
    return 1;
}

DialogResponse:D_ACCESSORY_EDIT_POS(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    new 
        Float: Offset_X, Float: Offset_Y, Float: Offset_Z,
        listitem_index = GetPVarInt(playerid, #ACCESORY_INDEX),
        index_accessory = GetPlayerListItem(playerid, listitem_index);

    if(sscanf(inputtext,"p<,>fff", Offset_X, Offset_Y, Offset_Z)) 
        return Dialog_Show(playerid, Dialog: D_ACCESSORY_EDIT_POS);

    g_accessories_data[index_accessory][ACCESSORY_OFFSET_X] = Offset_X;
    g_accessories_data[index_accessory][ACCESSORY_OFFSET_Y] = Offset_Y;
    g_accessories_data[index_accessory][ACCESSORY_OFFSET_Z] = Offset_Z;

    new update_query[300];

    format(update_query, sizeof update_query, "UPDATE "DB_ACCESSORIES_DATA" SET \
    `offset_x` = '%f',`offset_y` = '%f',`offset_z` = '%f' WHERE `id` = '%d'",
        Offset_X, Offset_Y, Offset_Z, g_accessories_data[index_accessory][ACCESSORY_SQL_ID]);

    mysql_tquery(mysql, update_query);

   Accessories:EditUpdateForPlayer(playerid);

    return 1;
}*/

stock Accessories:EditUpdateForPlayer(playerid)
{
    new 
        listitem_index = GetPVarInt(playerid, #ACCESORY_INDEX),
        idx = GetPlayerListItem(playerid, listitem_index);
    
    for(new accessory_slot; accessory_slot < MAX_MY_ACCESSORIES; accessory_slot++)
    {
        printf("%d - %d ", g_player_accessory[playerid][accessory_slot][E_PA_SQL_ID], g_accessories_data[idx][ACCESSORY_SQL_ID]);
        if(g_player_accessory[playerid][accessory_slot][E_PA_SQL_ID] == 
                g_accessories_data[idx][ACCESSORY_SQL_ID]) {
            print("2");
            if(GetPlayerAccSlot(playerid, accessory_slot, E_PA_USED)) {

                if(IsPlayerAttachedObjectSlotUsed(playerid, accessory_slot))
                    RemovePlayerAttachedObject(playerid, accessory_slot);

                SetPlayerAttachedObject
                (
                    playerid, GetPlayerAccSlot(playerid, accessory_slot, E_PA_SLOT),
                    g_accessories_data[idx][ACCESSORY_MODEL], g_accessories_data[idx][ACCESSORY_BONE],
                    g_accessories_data[idx][ACCESSORY_OFFSET_X], g_accessories_data[idx][ACCESSORY_OFFSET_Y], g_accessories_data[idx][ACCESSORY_OFFSET_Z],
                    g_accessories_data[idx][ACCESSORY_ROT_X], g_accessories_data[idx][ACCESSORY_ROT_Y], g_accessories_data[idx][ACCESSORY_ROT_Z],
                    g_accessories_data[idx][ACCESSORY_SCALE_X], g_accessories_data[idx][ACCESSORY_SCALE_Y], g_accessories_data[idx][ACCESSORY_SCALE_Z], 
                    g_accessories_data[idx][ACCESSORY_MATERIAL_COLOR1], g_accessories_data[idx][ACCESSORY_MATERIAL_COLOR2]
                );
            }
        }
    }

    return 1;
}

DialogCreate:D_MY_ACCESSORIES(playerid)
{
    new accessories_count;
    for(new accessory_slot; accessory_slot < MAX_MY_ACCESSORIES; accessory_slot++)
    {
        new model = GetPlayerAccSlot(playerid, accessory_slot, E_PA_MODEL);

        if(model == 0)
            continue;

        format
        (
            FormatData_2048,
            sizeof FormatData_2048,
            "%s%d. %s [слот %d]\n", FormatData_2048,
            accessories_count + 1,
            Accessories:GetItemName(model),
            GetPlayerAccSlot(playerid, accessory_slot, E_PA_SLOT)
        );

        g_temp_accessories_listitem[playerid][accessories_count] = accessory_slot;

        accessories_count++;
    }

    if(!accessories_count)
        return SendClientMessage(playerid, -1, "У вас нет доступных аксессуаров.");

    Dialog_Open
    (
        playerid, 
        Dialog: D_MY_ACCESSORIES, DIALOG_STYLE_LIST,
        "Мои аксессуары", 
        FormatData_2048,
        "Выбрать", "Закрыть"
    );

    FormatData_2048="";

    return 1;
}

DialogResponse:D_MY_ACCESSORIES(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    SetPVarInt(playerid, #SELECT_ACCESSORY_INDEX, listitem);

    Dialog_Show(playerid, Dialog: D_MY_ACCESSORIES_ACTION);
    
    return 1;
}

DialogCreate:D_MY_ACCESSORIES_ACTION(playerid)
{
    new 
        accessory_index = GetPVarInt(playerid, #SELECT_ACCESSORY_INDEX),
        accessory_slot = g_temp_accessories_listitem[playerid][accessory_index],
        model = GetPlayerAccSlot(playerid, accessory_slot, E_PA_MODEL);

    format
    (
        FormatData_2048, sizeof FormatData_2048, "Аксессуар [%s]:\n\n\
        Посмотреть информацию об аксессуаре\n\
        Редактировать аксессуар",
        Accessories:GetItemName(model)     
    );

    Dialog_Open
    (
        playerid, 
        Dialog:D_MY_ACCESSORIES_ACTION, DIALOG_STYLE_LIST,
        "Выберите действие",
        FormatData_2048,
        "Выбрать", "Назад"
    );
    FormatData_2048="";
    return 1;
}

DialogResponse:D_MY_ACCESSORIES_ACTION(playerid, response, listitem, inputtext[])
{
    if(!response) 
    {
        Dialog_Show(playerid, Dialog: D_MY_ACCESSORIES);
        return 1;
    }

    if(strfind(inputtext, "Посмотреть информацию об аксессуаре") != -1) {
        Dialog_Show(playerid, Dialog: D_MY_ACCESSORIES_INFO);
    }
    if(strfind(inputtext, "Редактировать аксессуар") != -1) {
        Dialog_Show(playerid, Dialog: D_MY_ACCESSORIES_EDIT);
    }

    return 1;
}

DialogCreate:D_MY_ACCESSORIES_INFO(playerid)
{
    new 
        accessory_index = GetPVarInt(playerid, #SELECT_ACCESSORY_INDEX),
        accessory_slot = g_temp_accessories_listitem[playerid][accessory_index],
        model = GetPlayerAccSlot(playerid, accessory_slot, E_PA_MODEL);

    format
    (
        FormatData_2048, 
        sizeof FormatData_2048,"\
        Наименование аксессуара: %s\n\
        Описание аксессуара: %s",
        Accessories:GetItemName(model),
        Accessories:GetDescriptionText(model)
    );

    Dialog_Open
    (
        playerid, 
        Dialog:D_MY_ACCESSORIES_INFO, DIALOG_STYLE_MSGBOX,
        "Информация об аксессуаре",
        FormatData_2048,
        "Закрыть", "Назад"
    );

    FormatData_2048="";
    return 1;
}

DialogResponse:D_MY_ACCESSORIES_INFO(playerid, response, listitem, inputtext[])
{
    if(!response) 
        return Dialog_Show(playerid, Dialog: D_MY_ACCESSORIES_ACTION);

    DeletePVar(playerid, #SELECT_ACCESSORY_INDEX);

    return 1;
}

DialogCreate:D_MY_ACCESSORIES_EDIT(playerid)
{
    Dialog_Open
    (
        playerid, 
        Dialog: D_MY_ACCESSORIES_EDIT, DIALOG_STYLE_LIST,
        "Редактирование аксессуара","\
        Редактировать положение аксессуара\n\
        Удалить аксессуар",
        "Выбрать", "Назад"
    );
    return 1;
}

DialogResponse:D_MY_ACCESSORIES_EDIT(playerid, response, listitem, inputtext[])
{
    if(!response) 
    {
        Dialog_Show(playerid, Dialog: D_MY_ACCESSORIES_ACTION);
        return 1;
    }

    switch(listitem)
    {
        case 0:
        {
            new 
                accessory_index = GetPVarInt(playerid, #SELECT_ACCESSORY_INDEX),
                accessory_slot = g_temp_accessories_listitem[playerid][accessory_index];

            SetPVarInt(playerid, #ACCESSORY_EDIT, 1); 

            EditAttachedObject(playerid, GetPlayerAccSlot(playerid, accessory_slot, E_PA_SLOT));
        }
        case 1: Dialog_Show(playerid, Dialog: D_MY_ACCESSORIES_EDIT_DEL);
    }
    return 1;
}


DialogCreate:D_MY_ACCESSORIES_EDIT_DEL(playerid)
{
    new 
        accessory_index = GetPVarInt(playerid, #SELECT_ACCESSORY_INDEX),
        accessory_slot = g_temp_accessories_listitem[playerid][accessory_index],
        model = GetPlayerAccSlot(playerid, accessory_slot, E_PA_MODEL);

    format
    (
        FormatData_2048, sizeof FormatData_2048,
        ""c_white"Вы действительно хотите удалить данный аксессуар %s",
        Accessories:GetItemName(model)
    );
    Dialog_Open
    (
        playerid, 
        Dialog: D_MY_ACCESSORIES_EDIT_DEL, DIALOG_STYLE_MSGBOX,
        "Подтверждение удаления",
        FormatData_2048,
        "Да", "Нет"
    );

    FormatData_2048="";
    return 1;
}

DialogResponse:D_MY_ACCESSORIES_EDIT_DEL(playerid, response, listitem, inputtext[])
{
    if(!response) 
    {
        DeletePVar(playerid, #SELECT_ACCESSORY_INDEX);
        SendClientMessage(playerid, -1, "Вы отменили действие удаления аксессуара.");
        return 1;
    }

    Accessories:UnAttachAcc(playerid);

    SendClientMessage(playerid, -1, "Вы успешно удалили данный аксессуар.");
    
    return 1;
}

DialogCreate:D_GIVE_ACCESSORY(playerid)
{
    new page = GetPlayerPage(playerid);
	new count_elements = 0;

    for(new i = page * MAX_ELEMENTS_ON_PAGE; i < g_quantity_accessories; i++)
    {
        
        format
        (
            FormatData_2048,
            sizeof FormatData_2048,
            "%s%i\t%s\n", FormatData_2048,
            g_accessories_data[i][ACCESSORY_MODEL],
            g_accessories_data[i][ACCESSORY_NAME]
        );

        SetPlayerListItem(playerid, count_elements, i);
        count_elements++;

        if(count_elements > MAX_ELEMENTS_ON_PAGE)
            break;
    }

	if(count_elements == 0)
	{
		DeletePlayerPage(playerid);
		return 0;
	}

	new dialog_header[70];
	strcat(dialog_header, "Model\tName\n");

	if(count_elements > MAX_ELEMENTS_ON_PAGE) strcat(dialog_header, ""DIALOG_NEXT_PAGE_TEXT"\n");
	if(page > 0) strcat(dialog_header, ""DIALOG_PREVIOUS_PAGE_TEXT"\n");

	strins(FormatData_2048, dialog_header, 0);

    Dialog_Open
    (
        playerid, 
        Dialog: D_GIVE_ACCESSORY, 
        DIALOG_STYLE_TABLIST_HEADERS,
        "Список аксессуаров",
        FormatData_2048,
        "Выдать", "Закрыть"
    );

    FormatData_2048="";
    return 1;
}


DialogResponse:D_GIVE_ACCESSORY(playerid, response, listitem, inputtext[])
{
    if(!response) 
        return 1;

    new 
        to_player = GetPVarInt(playerid, #GIVE_ACCESSORY_PLAYER_ID),
        free_slot = Accessories:GetFreeSlotID(playerid),
        accessory_item_id = GetPlayerListItem(playerid, listitem),
        model = g_accessories_data[accessory_item_id][ACCESSORY_MODEL];

    if(free_slot == -1)
        return SendClientMessage(playerid, -1, "Все доступные места под аксессуары заняты");

    new acc_slot = Accessories:SetPlayerAttached(to_player, model);

    if(acc_slot != -1)
    {
        SetPlayerAccessoryUniqueID(playerid, free_slot, g_accessories_data[accessory_item_id][ACCESSORY_SQL_ID]);

        new update_query[128];
        format
        (
            update_query, sizeof update_query, 
            "update "DB_ACCESSORIES" set \
            `slot%d` = '%d' \
            where `account_id` = '%d'",
            free_slot + 1,
            GetPlayerAccessoryUniqueID(playerid, free_slot),
            GetPlayerData(playerid, PLAYER_ID)
        );

        mysql_tquery(mysql, update_query);

        g_player_accessory[playerid][acc_slot][E_PA_USED] = true;
        g_player_accessory[playerid][acc_slot][E_PA_SQL_ID] = GetPlayerAccessoryUniqueID(playerid, free_slot);

    }

    return 1;
}


CMD:a_list_accessory(playerid)
{
	SetPlayerPage(playerid, 0);
	Dialog_Show(playerid, Dialog: D_ACCESSORY_LIST);
	return 1;
}

CMD:my_accessories(playerid)
{
    Dialog_Show(playerid, Dialog: D_MY_ACCESSORIES);
    return 1;
}

CMD:give_accessory(playerid, params[])
{
    extract params -> new to_player; else 
        return SendClientMessage(playerid, -1, !"Введите: /give_accessory [ID]");

    SetPVarInt(playerid, #GIVE_ACCESSORY_PLAYER_ID, to_player);

    Dialog_Show(playerid, Dialog: D_GIVE_ACCESSORY);
    return 1;
}

stock Accessories:EditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    #pragma unused modelid, boneid, index 

    if(GetPVarInt(playerid, #ACCESSORY_EDIT) == 2)
    {
        new 
            listitem_index = GetPVarInt(playerid, #ACCESORY_INDEX),
            index_accessory = GetPlayerListItem(playerid, listitem_index);

        if(response) {
            g_accessories_data[index_accessory][ACCESSORY_OFFSET_X] = fOffsetX;
            g_accessories_data[index_accessory][ACCESSORY_OFFSET_Y] = fOffsetY;
            g_accessories_data[index_accessory][ACCESSORY_OFFSET_Z] = fOffsetZ;
            g_accessories_data[index_accessory][ACCESSORY_ROT_X] = fRotX;
            g_accessories_data[index_accessory][ACCESSORY_ROT_Y] = fRotY;
            g_accessories_data[index_accessory][ACCESSORY_ROT_Z] = fRotZ;
            g_accessories_data[index_accessory][ACCESSORY_SCALE_X] = fScaleX;
            g_accessories_data[index_accessory][ACCESSORY_SCALE_Y] = fScaleY;
            g_accessories_data[index_accessory][ACCESSORY_SCALE_Z] = fScaleZ;

            new update_query[400];

            format
            (
                update_query, sizeof update_query, 
                "UPDATE "DB_ACCESSORIES_DATA" SET \
                `offset_x` = '%f',\
                `offset_y` = '%f',\
                `offset_z` = '%f',\
                `rot_x` = '%f',\
                `rot_y` = '%f',\
                `rot_z` = '%f',\
                `scale_x` = '%f',\
                `scale_y` = '%f',\
                `scale_z` = '%f' WHERE `id` = '%d'",
                fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ, 
                g_accessories_data[index_accessory][ACCESSORY_SQL_ID]
            );

            mysql_tquery(mysql, update_query);

            for(new i; i < MAX_PLAYERS; i++) {
                if(!IsPlayerConnected(i))
                    continue;
                Accessories:EditUpdateForPlayer(i);
            }

            SendClientMessage(playerid, -1, "Вы успешно обновили параметры общего аксессуара!");
        }
        else
        {
            SetPlayerAttachedObject
            (
                playerid, 
                g_accessories_data[index_accessory][ACCESSORY_SLOT], 
                g_accessories_data[index_accessory][ACCESSORY_MODEL], 
                g_accessories_data[index_accessory][ACCESSORY_BONE], 
                g_accessories_data[index_accessory][ACCESSORY_OFFSET_X], 
                g_accessories_data[index_accessory][ACCESSORY_OFFSET_Y],
                g_accessories_data[index_accessory][ACCESSORY_OFFSET_Z],  
                g_accessories_data[index_accessory][ACCESSORY_ROT_X],
                g_accessories_data[index_accessory][ACCESSORY_ROT_Y],  
                g_accessories_data[index_accessory][ACCESSORY_ROT_Z], 
                g_accessories_data[index_accessory][ACCESSORY_SCALE_X], 
                g_accessories_data[index_accessory][ACCESSORY_SCALE_Y], 
                g_accessories_data[index_accessory][ACCESSORY_SCALE_Z], 
                g_accessories_data[index_accessory][ACCESSORY_MATERIAL_COLOR1],
                g_accessories_data[index_accessory][ACCESSORY_MATERIAL_COLOR2]
            );
            SendClientMessage(playerid, -1, "Вы отменили редактирование общего аксессуара!");
        }
    }

    if(GetPVarInt(playerid, #ACCESSORY_EDIT) == 1)
    {   // todo: убрать
        new 
            accessory_index = GetPVarInt(playerid, #SELECT_ACCESSORY_INDEX);
           // acc_slot = g_temp_accessories_listitem[playerid][accessory_index];

        if(response) 
        {
            SendClientMessage(playerid, -1, "Вы успешно обновили параметры аксессуара!");
        }
        else 
        {


            SendClientMessage(playerid, -1, "Вы отменили редактирование аксессуара!");
        }

        DeletePVar(playerid, #ACCESSORY_EDIT);
    }
    return 1;
}