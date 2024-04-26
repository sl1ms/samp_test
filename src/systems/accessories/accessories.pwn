

stock SetPlayerAttachedObjectEx(playerid, a_index, a_modelid, a_boneid, Float: a_fOffsetX, Float: a_fOffsetY, Float: a_fOffsetZ, Float:a_fRotX, \
    Float: a_fRotY, Float: a_fRotZ, Float: a_fScaleX, Float: a_fScaleY, Float: a_fScaleZ, materialcolor1, materialcolor2, extra = INVALID_ACC_INDEX)
{
    new acc_slot = GetPVarInt(playerid, #ACC_TEMP_SLOT);
    
    SetAttachEditInfo(playerid, E_INDEX, a_index);
    SetAttachEditInfo(playerid, E_MODEL, a_modelid);
    SetAttachEditInfo(playerid, E_BONE, a_boneid);
    SetAttachEditInfo(playerid, E_EXTRA, extra);

    SetAttachEditInfo(playerid, E_OFFSET_X, a_fOffsetX);
    SetAttachEditInfo(playerid, E_OFFSET_Y, a_fOffsetY);
    SetAttachEditInfo(playerid, E_OFFSET_Z, a_fOffsetZ);

    SetAttachEditInfo(playerid, E_ROT_X, a_fRotX);
    SetAttachEditInfo(playerid, E_ROT_Y, a_fRotY);
    SetAttachEditInfo(playerid, E_ROT_Z, a_fRotZ);

    SetAttachEditInfo(playerid, E_SCALE_X, a_fScaleX);
    SetAttachEditInfo(playerid, E_SCALE_Y, a_fScaleY);
    SetAttachEditInfo(playerid, E_SCALE_Z, a_fScaleZ);

    SetAttachEditInfo(playerid, E_MATERIALCOLOR_1, materialcolor1);
    SetAttachEditInfo(playerid, E_MATERIALCOLOR_2, materialcolor2);



    if(acc_slot >= 0)
    {
        SetPlayerAccSlot(playerid, acc_slot, E_PA_SLOT, GetAttachEditInfo(playerid, E_INDEX));
        SetPlayerAccSlot(playerid, acc_slot, E_PA_MODEL, GetAttachEditInfo(playerid, E_MODEL));
        SetPlayerAccSlot(playerid, acc_slot, E_PA_EXTRA, GetAttachEditInfo(playerid, E_EXTRA));
        SetPlayerAccSlot(playerid, acc_slot, E_PA_BONE, GetAttachEditInfo(playerid, E_BONE));

        SetPlayerAccSlot(playerid, acc_slot, E_PA_OFFSET_X, GetAttachEditInfo(playerid, E_OFFSET_X));
        SetPlayerAccSlot(playerid, acc_slot, E_PA_OFFSET_Y, GetAttachEditInfo(playerid, E_OFFSET_Y));
        SetPlayerAccSlot(playerid, acc_slot, E_PA_OFFSET_Z, GetAttachEditInfo(playerid, E_OFFSET_Z));

        SetPlayerAccSlot(playerid, acc_slot, E_PA_ROT_X, GetAttachEditInfo(playerid, E_ROT_X));
        SetPlayerAccSlot(playerid, acc_slot, E_PA_ROT_Y, GetAttachEditInfo(playerid, E_ROT_Y));
        SetPlayerAccSlot(playerid, acc_slot, E_PA_ROT_Z, GetAttachEditInfo(playerid, E_ROT_Z));

        SetPlayerAccSlot(playerid, acc_slot, E_PA_SCALE_X, GetAttachEditInfo(playerid, E_SCALE_X));
        SetPlayerAccSlot(playerid, acc_slot, E_PA_SCALE_Y, GetAttachEditInfo(playerid, E_SCALE_Y));
        SetPlayerAccSlot(playerid, acc_slot, E_PA_SCALE_Z, GetAttachEditInfo(playerid, E_SCALE_Z));

        SetPlayerAccSlot(playerid, acc_slot, E_PA_MATCOLOR_1, GetAttachEditInfo(playerid, E_MATERIALCOLOR_1));
        SetPlayerAccSlot(playerid, acc_slot, E_PA_MATCOLOR_2, GetAttachEditInfo(playerid, E_MATERIALCOLOR_2));
    }
    

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

    printf("%d %d %d %f %f %f %f %f %f %f %f %f %d %d",         GetPlayerAccSlot(playerid, acc_slot, E_PA_SLOT),
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
        GetPlayerAccSlot(playerid, acc_slot, E_PA_MATCOLOR_2));
    return 1;
}

stock Accessories:LoadPlayerData(playerid)
{
    new acs_query[128];

    mysql_format(mysql, acs_query, sizeof acs_query, "SELECT * FROM `accessories` WHERE `account_id` = '%d'", GetPlayerData(playerid, PLAYER_ID));

    mysql_tquery(mysql, acs_query, DatabaseText(Database:LoadPlayerAccessory), "d", playerid);
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

        cache_get_value_name_int(i, "id", g_player_accessory[playerid][acc_slot][E_PA_SQL_ID]);
        cache_get_value_name_int(i, "model", g_player_accessory[playerid][acc_slot][E_PA_MODEL]);
        cache_get_value_name_int(i, "extra", g_player_accessory[playerid][acc_slot][E_PA_EXTRA]);
        cache_get_value_name_int(i, "bone", g_player_accessory[playerid][acc_slot][E_PA_BONE]);
        cache_get_value_name_int(i, "category", g_player_accessory[playerid][acc_slot][E_PA_TYPE]);
        cache_get_value_name_int(i, "w_slot", g_player_accessory[playerid][acc_slot][E_PA_W_SLOT]);

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
    }

	return 1;
}

stock Accessories:GetItemType(model)
{
    for(new i; i < MAX_ACCESSORIES; i++)
    {
        if(g_accessories[i][E_ACC_MODEL] == model)
            return g_accessories[i][E_ACC_TYPE];
    }

    return INVALID_ACC_INDEX;
}

stock Accessories:GetItemName(model)
{
    new name[20] = "";

    for(new i; i < MAX_ACCESSORIES; i++)
    {
        if(g_accessories[i][E_ACC_MODEL] == model)
        {
            strcat(name, g_accessories[i][E_ACC_NAME]);
        }
    }

    return name;
}

stock Accessories:GetItemSlotByType(type)
{
    for(new i; i < MAX_ACCESSORIES; i++)
    {
        if(g_accessories[i][E_ACC_TYPE] == type)
            return g_accessories[i][E_ACC_TYPE_SLOT];
    }

    return INVALID_ACC_INDEX;
}

stock Accessories:SetPlayerAttached(playerid, model, accessory_slot = INVALID_ACC_INDEX, extra = INVALID_ACC_INDEX)
{
    new type = Accessories:GetItemType(model);
    if(type == INVALID_ACC_INDEX)
        return 0;

    new slot = Accessories:GetItemSlotByType(type);
    if(INVALID_ACC_INDEX == slot)
        return 0;

    SetPVarInt(playerid, #ACC_TEMP_SLOT, slot);
    SetPVarInt(playerid, #ACC_TEMP_ACCESSORY_SLOT, accessory_slot);

    if(IsPlayerAttachedObjectSlotUsed(playerid, slot))
        RemovePlayerAttachedObject(playerid, slot);

    new result = Accessories:AttachToPlayer(playerid, type, model, slot, extra);

    if(result == INVALID_ACC_INDEX)
        return SendClientMessage(playerid, -1, "Аксессуар не будет отображаться на этом скине!");
    else if(result == 0)
        return SendClientMessage(playerid, -1, "Ошибка использования аксессуара");

    return slot;
}

public: Accessories:InsertData(playerid, accessory_slot, inventory_slot)
{
    new sql_id = cache_insert_id();

    if(sql_id != INVALID_ACC_INDEX)
    {
        g_player_accessory[playerid][accessory_slot][E_PA_USED] = true;
        g_player_accessory[playerid][accessory_slot][E_PA_SQL_ID] = sql_id;


        SendClientMessage(playerid, -1, "Вы успешно надели аксессуар.");
        Accessories:Update(playerid);

    }
    return 1;
}

stock Accessories:UnAttachAcc(playerid, accessory_slot)
{
    new model = GetPlayerAccSlot(playerid, accessory_slot, E_PA_MODEL);

    if(model == 0)
        return 0;


    if(IsPlayerAttachedObjectSlotUsed(playerid, accessory_slot))
        RemovePlayerAttachedObject(playerid, accessory_slot);

    new query[84];
    format
    (
        query, sizeof query,
        "DELETE FROM `accessories` WHERE `account_id` = '%i' AND `id` = '%i'",
        GetPlayerData(playerid, PLAYER_ID), GetPlayerAccSlot(playerid, accessory_slot, E_PA_SQL_ID)
    );
    mysql_tquery(mysql, query);

    g_player_accessory[playerid][accessory_slot] = g_player_accessory_default;

    Accessories:Update(playerid);
    
    return 1;
}


stock Accessories:Save(playerid, bool: is_disconnect = false)
{
    new query[1024];

    for(new i = 0; i < MAX_MY_ACCESSORIES; i++)
    {
        if(GetPlayerAccSlot(playerid, i, E_PA_MODEL) == 0)
            continue;

        format
        (
            query, sizeof(query),
            "UPDATE `accessories` SET \
            `slot` = '%i',\
            `model` = '%i',\
            `extra` = '%i',\
            `bone` = '%i',\
            `category` = '%i',\
            `w_slot` = '%i',\
            `offset_x` = '%f',\
            `offset_y` = '%f',\
            `offset_z` = '%f',\
            `rot_x` = '%f',\
            `rot_y` = '%f',\
            `rot_z` = '%f',\
            `scale_x` = '%f',\
            `scale_y` = '%f',\
            `scale_z` = '%f',\
            `materialcolor1` = '%i',\n\
            `materialcolor2` = '%i' WHERE `owner_idx` = '%i' AND `id` = '%i'",
            GetPlayerAccSlot(playerid, i, E_PA_SLOT),
            GetPlayerAccSlot(playerid, i, E_PA_MODEL),
            GetPlayerAccSlot(playerid, i, E_PA_EXTRA),
            GetPlayerAccSlot(playerid, i, E_PA_BONE),
            GetPlayerAccSlot(playerid, i, E_PA_TYPE),
            GetPlayerAccSlot(playerid, i, E_PA_W_SLOT),
            GetPlayerAccSlot(playerid, i, E_PA_OFFSET_X),
            GetPlayerAccSlot(playerid, i, E_PA_OFFSET_Y),
            GetPlayerAccSlot(playerid, i, E_PA_OFFSET_Z),
            GetPlayerAccSlot(playerid, i, E_PA_ROT_X),
            GetPlayerAccSlot(playerid, i, E_PA_ROT_Y),
            GetPlayerAccSlot(playerid, i, E_PA_ROT_Z),
            GetPlayerAccSlot(playerid, i, E_PA_SCALE_X),
            GetPlayerAccSlot(playerid, i, E_PA_SCALE_Y),
            GetPlayerAccSlot(playerid, i, E_PA_SCALE_Z),
            GetPlayerAccSlot(playerid, i, E_PA_MATCOLOR_1),
            GetPlayerAccSlot(playerid, i, E_PA_MATCOLOR_2),
            GetPlayerData(playerid, PLAYER_ID), GetPlayerAccSlot(playerid, i, E_PA_SQL_ID)
        );
        mysql_tquery(mysql, query);

        if(is_disconnect)
        {
            if(IsPlayerAttachedObjectSlotUsed(playerid, i))
                RemovePlayerAttachedObject(playerid, i);

            g_player_accessory[playerid][i] = g_player_accessory_default;
        }
    }
    return 1;
}

stock Accessories:IsAttachType(playerid, model)
{
    new type = Accessories:GetItemType(model);
    if(type == INVALID_ACC_INDEX)
        return 0;

    new slot = Accessories:GetItemSlotByType(type);
    if(INVALID_ACC_INDEX == slot)
        return 0;

    for(new i; i < MAX_PLAYER_ATTACHED_OBJECTS; i++)
    {
        if(IsPlayerAttachedObjectSlotUsed(playerid, slot))
            return true;
    }

    return false;
}

stock Accessories:Update(playerid)
{
    for(new i = 0;  i< MAX_MY_ACCESSORIES; i++)
    {
        if(IsPlayerAttachedObjectSlotUsed(playerid, i))
            RemovePlayerAttachedObject(playerid, i);
    }

	for(new i = 0; i < MAX_MY_ACCESSORIES; i++)
	{
		if(GetPlayerAccSlot(playerid, i, E_PA_USED))
		{
			SetPlayerAttachedObject
            (
                playerid,
			    GetPlayerAccSlot(playerid, i, E_PA_SLOT),
			    GetPlayerAccSlot(playerid, i, E_PA_MODEL),
			    GetPlayerAccSlot(playerid, i, E_PA_BONE),
			    GetPlayerAccSlot(playerid, i, E_PA_OFFSET_X),
			    GetPlayerAccSlot(playerid, i, E_PA_OFFSET_Y),
			    GetPlayerAccSlot(playerid, i, E_PA_OFFSET_Z),
			    GetPlayerAccSlot(playerid, i, E_PA_ROT_X),
			    GetPlayerAccSlot(playerid, i, E_PA_ROT_Y),
			    GetPlayerAccSlot(playerid, i, E_PA_ROT_Z),
			    GetPlayerAccSlot(playerid, i, E_PA_SCALE_X),
			    GetPlayerAccSlot(playerid, i, E_PA_SCALE_Y),
			    GetPlayerAccSlot(playerid, i, E_PA_SCALE_Z),
			    GetPlayerAccSlot(playerid, i, E_PA_MATCOLOR_1),
			    GetPlayerAccSlot(playerid, i, E_PA_MATCOLOR_2)
            );
		}
	}
	return 1;
}

stock Accessories:AttachToPlayer(playerid, type, model, slot, extra = INVALID_ACC_INDEX)
{
    if(type == INVALID_ACC_INDEX)
        return 0;

    for(new idx; idx < MAX_ACCESSORIES; idx++)
    {
      
        if(g_accessories[idx][E_ACC_TYPE_SLOT] == slot && g_accessories[idx][E_ACC_TYPE] == type && g_accessories[idx][E_ACC_MODEL] == model)
        {
            return SetPlayerAttachedObjectEx\
            (\
                playerid, g_accessories[idx][E_ACC_TYPE_SLOT], \
                g_accessories[idx][E_ACC_MODEL], g_accessories[idx][E_ACC_BONE],\
                g_accessories[idx][E_ACC_OFFSET_X], g_accessories[idx][E_ACC_OFFSET_Y], g_accessories[idx][E_ACC_OFFSET_Z],\
                g_accessories[idx][E_ACC_ROT_X], g_accessories[idx][E_ACC_ROT_Y], g_accessories[idx][E_ACC_ROT_Z],\
                g_accessories[idx][E_ACC_SCALE_X], g_accessories[idx][E_ACC_SCALE_Y], g_accessories[idx][E_ACC_SCALE_Z], \
                g_accessories[idx][E_ACC_MATERIALCOLOR_1], g_accessories[idx][E_ACC_MATERIALCOLOR_2], extra
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
            "%s%i\t%s\t%s\n", FormatData_2048,
            g_accessories[i][E_ACC_MODEL], g_accessories[i][E_ACC_NAME], g_accessory_category_name[g_accessories[i][E_ACC_TYPE] - 1]
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
	strcat(dialog_header, "Model\tName\tCategory\n");

	if(count_elements > MAX_ELEMENTS_ON_PAGE) strcat(dialog_header, ""DIALOG_NEXT_PAGE_TEXT"\n");
	if(page > 0) strcat(dialog_header, ""DIALOG_PREVIOUS_PAGE_TEXT"\n");

	strins(FormatData_2048, dialog_header, 0);

    Dialog_Open
    (
        playerid, 
        Dialog: D_ACCESSORY_LIST, 
        DIALOG_STYLE_TABLIST_HEADERS,
        "Список аксессуаров",
        FormatData_2048,
        "Закрыть", ""
    );
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
    return 1;
}

DialogCreate:D_MY_ACCESSORIES(playerid)
{

    for(new accessory_slot; accessory_slot < MAX_MY_ACCESSORIES; accessory_slot++)
    {
        new model = GetPlayerAccSlot(playerid, accessory_slot, E_PA_MODEL);

        format
        (
            FormatData_2048,
            sizeof FormatData_2048,
            "%s%d\t%s\n", FormatData_2048,
            accessory_slot,
            Accessories:GetItemName(model)
        );
    }

    new dialog_header[70];

	strcat(dialog_header, ""c_white"Номер слота\tНаиманование аксессуара\n");

    Dialog_Open
    (
        playerid, 
        Dialog: D_MY_ACCESSORIES, DIALOG_STYLE_TABLIST_HEADERS,
        "Мои аксессуары", 
        FormatData_2048,
        "Выбрать", "Закрыть"
    );

    return 1;
}

DialogResponse:D_MY_ACCESSORIES(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    
    

    return 1;
}

DialogCreate:D_MY_ACCESSORIES_ACTION(playerid)
{
    Dialog_Open
    (
        playerid, 
        Dialog:D_MY_ACCESSORIES_ACTION, DIALOG_STYLE_LIST,
        "Выберите действие","\
        Посмотреть информацию об аксессуаре\n\
        Редактировать аксессуар",
        "Выбрать", "Назад"
    );
    return 1;
}

DialogResponse:D_MY_ACCESSORIES_ACTION(playerid, response, listitem, inputtext[])
{
    if(!response) 
    {
        Dialog_Show(playerid, Dialog: D_MY_ACCESSORIES);
        return 1;
    }

    switch(listitem)
    {
        case 0: Dialog_Show(playerid, Dialog: D_MY_ACCESSORIES_INFO);
        case 1: Dialog_Show(playerid, Dialog: D_MY_ACCESSORIES_EDIT);
    }

    return 1;
}

DialogCreate:D_MY_ACCESSORIES_INFO(playerid)
{
    format
    (
        FormatData_2048, 
        sizeof FormatData_2048,"\
        Наименование аксессуара: %s\n\
        Описание аксессуара: %s"
    );

    Dialog_Open
    (
        playerid, 
        Dialog:D_MY_ACCESSORIES_INFO, DIALOG_STYLE_MSGBOX,
        "Информация об аксессуаре",
        FormatData_2048,
        "Закрыть", "Назад"
    );
    return 1;
}

DialogResponse:D_MY_ACCESSORIES_INFO(playerid, response, listitem, inputtext[])
{
    if(!response) 
    {
        return 1;
    }
    Dialog_Show(playerid, Dialog: D_MY_ACCESSORIES_ACTION);
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
        case 0: Dialog_Show(playerid, Dialog: D_MY_ACCESSORIES_EDIT_POS);
        case 1: Dialog_Show(playerid, Dialog: D_MY_ACCESSORIES_EDIT_DEL);
    }
    return 1;
}

DialogCreate:D_GIVE_ACCESSORY(playerid)
{
    new page = GetPlayerPage(playerid);
	new count_elements = 0;

    for(new i = page * MAX_ELEMENTS_ON_PAGE; i < MAX_ACCESSORIES; i++)
    {

        format
        (
            FormatData_2048,
            sizeof FormatData_2048,
            "%s%i\t%s\t%s\n", FormatData_2048,
            g_accessories[i][E_ACC_MODEL], g_accessories[i][E_ACC_NAME], g_accessory_category_name[g_accessories[i][E_ACC_TYPE] - 1]
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
	strcat(dialog_header, "Model\tName\tCategory\n");

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

stock Accessories:GetFreeSlot(playerid) 
{
    for(new i; i < MAX_MY_ACCESSORIES; i++) {
        if(g_player_data[playerid][PLAYER_ACCESSORY][i])
            continue;
        return i;
    }
    return -1;
}

DialogResponse:D_GIVE_ACCESSORY(playerid, response, listitem, inputtext[])
{
    if(!response) 
    {
        return 1;
    }

    new 
        to_player = GetPVarInt(playerid, #GIVE_ACCESSORY_PLAYER_ID),
        slot_index = Accessories:GetFreeSlot(to_player);

    if(slot_index == -1)
        return SendClientMessage(playerid, -1, "Все доступные места под аксессуары заняты!");
        
    new   
        accessory_item_id = GetPlayerListItem(playerid, listitem),
        model = g_accessories[accessory_item_id][E_ACC_MODEL];
    
    g_player_data[to_player][PLAYER_ACCESSORY][slot_index] = model;

    printf("slot_index %d", slot_index);
    
    Accessories:SetPlayerAttached(to_player, model, slot_index);

    EditAttachedObject(to_player, g_accessories[accessory_item_id][E_ACC_TYPE_SLOT]);

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

    if(response) 
    {

        SetAttachEditInfo(playerid, E_OFFSET_X, fOffsetX);
        SetAttachEditInfo(playerid, E_OFFSET_Y, fOffsetY);
        SetAttachEditInfo(playerid, E_OFFSET_Z, fOffsetZ);

        SetAttachEditInfo(playerid, E_ROT_X, fRotX);
        SetAttachEditInfo(playerid, E_ROT_Y, fRotY);
        SetAttachEditInfo(playerid, E_ROT_Z, fRotZ);
        SetAttachEditInfo(playerid, E_SCALE_X, fScaleX);
        SetAttachEditInfo(playerid, E_SCALE_Y, fScaleY);
        SetAttachEditInfo(playerid, E_SCALE_Z, fScaleZ);


       // Accesories:Save(playerid);
    }
    else 
    {
    
    }
    return 1;
}