stock Bort:GetFreeSlotID()
{
    for(new slot_id; slot_id < MAX_CREATE_BORTS; slot_id++)
    {
        if(GetBortData(slot_id, BORT_OBJECT_CREATE) == INVALID_OBJECT_ID)
            return slot_id;
    }
    return -1;
}

stock Bort:GetTotalCreated()
{
    new value;

    for(new slot_id; slot_id < MAX_CREATE_BORTS; slot_id++)
    {
        if(GetBortData(slot_id, BORT_OBJECT_CREATE) == INVALID_OBJECT_ID)
            continue;

        value++;
    }
    return value;
}

DialogCreate:D_BORT_CREATE(playerid)
{
    strcat(FormatData_2048, "{FFFFFF}Название\t{FFFFFF}ID объекта\n");

    for(new bort_id; bort_id < MAX_POLICE_BORTS; bort_id++) {
        format
        (
            FormatData_2048, sizeof FormatData_2048, 
            "%s%s\t%d\n",
            FormatData_2048,
            GetBortInfo(bort_id, BORT_NAME),
            GetBortInfo(bort_id, BORT_OBJECT_ID)
        );
    }

    Dialog_Open
    (
        playerid, 
        Dialog:D_BORT_CREATE, 
        DIALOG_STYLE_TABLIST_HEADERS, 
        "{FFFFFF}Список ограждений | Создания", 
        FormatData_2048, 
        !"Выбрать", !"Закрыть"
    );

    FormatData_2048="";
    return 1;
}

DialogResponse:D_BORT_CREATE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new
        slot_id = Bort:GetFreeSlotID(),
        Float: player_x,
        Float: player_y,
        Float: player_z,
        Float: cam_x,
        Float: cam_y,
        Float: cam_z,
        Float: vec_x,
        Float: vec_y,
        Float: vec_z,
        Float: object_x,
        Float: object_y
    ;


    GetPlayerCameraPos(playerid, cam_x, cam_y, cam_z);
    GetPlayerPos(playerid, player_x, player_y, player_z);
    GetPlayerCameraFrontVector(playerid, vec_x, vec_y, vec_z);

    object_x = cam_x + floatmul(vec_x, 8.0);
    object_y = cam_y + floatmul(vec_y, 8.0);

    new object_id = 
        CreateDynamicObject
        (
            GetBortInfo(listitem, BORT_OBJECT_ID), 
            object_x, object_y, player_z - GetBortInfo(listitem, BORT_COORD_Z), 
            0.0, 0.0, 0.0
        )
    ;

    SetBortData(slot_id, BORT_ID, slot_id + 1); 

    SetBortData(slot_id, BORT_OBJECT_CREATE, object_id); 

    SetBortData(slot_id, BORT_SLOT_ID, listitem);

    EditDynamicObject(playerid, object_id);

    SetPVarFloat(playerid, #BORT_POS_Z, player_z - GetBortInfo(listitem, BORT_COORD_Z));
    SetPVarInt(playerid, #BORT_CREATE_OBJECT_EDIT, true);
    SetPVarInt(playerid, #BORT_SLOT_ID, slot_id);

    SendFormattedMessage(playerid, -1, "Вы начали установку ограждения %s", GetBortInfo(listitem, BORT_NAME));

    
    return 1;
}

DialogCreate:D_EDIT_BORT(playerid)
{
    FormatData_2048="";

    strcat(FormatData_2048, "{FFFFFF}Название\t{FFFFFF}ID объекта\t{FFFFFF}Никнейм\n");

    new 
        slot_id,
        bort_total_count;

    for(new bort_id; bort_id < MAX_CREATE_BORTS; bort_id++)
    {
        if(GetBortData(bort_id, BORT_OBJECT_CREATE) == INVALID_OBJECT_ID)
            continue;

        g_player_bort_count[playerid][bort_total_count] = bort_id;

        slot_id = GetBortData(bort_id, BORT_SLOT_ID);

        format
        (
            FormatData_2048, sizeof FormatData_2048, 
            "%s%s\t%d\t%s\n", 
            FormatData_2048,
            GetBortInfo(slot_id, BORT_NAME), 
            GetBortInfo(slot_id, BORT_OBJECT_ID),
            GetBortData(bort_id, BORT_PLAYER_NAME)
        );

        bort_total_count ++;
    }

    strcat
    (
        FormatData_2048, "\
        Поиск ограждения по ID\n\
        Выбрать ограждения мышкой"
    );

    Dialog_Open
    (
        playerid, 
        Dialog:D_EDIT_BORT, 
        DIALOG_STYLE_TABLIST_HEADERS, 
        "{FFFFFF}Выберите ограждение | Редактирования", 
        FormatData_2048, 
        !"Выбрать", !"Закрыть"
    );

    FormatData_2048="";
    return 1;
}

DialogResponse:D_EDIT_BORT(playerid, response, listitem, inputtext[])
{
    if(!response) 
        return 1;

    if(strfind(inputtext, "Поиск ограждения по ID") != -1)
    {
        Dialog_Show(playerid, Dialog: D_EDIT_BORT_SEARCH_ID);
    }
    else if(strfind(inputtext, "Выбрать ограждения мышкой") != -1)
    {
        SetPVarInt(playerid, #BORT_SELECT_MOUSE, BORT_MOUSE_TYPE_EDIT);
        SelectObject(playerid);
    }
    else 
    {
        new 
            bort_id = g_player_bort_count[playerid][listitem];

        Bort:Edit(playerid, bort_id);
    }
    return 1;
}

DialogCreate:D_EDIT_BORT_SEARCH_ID(playerid)
{
    Dialog_Open
    (
        playerid, 
        Dialog:D_EDIT_BORT_SEARCH_ID, DIALOG_STYLE_INPUT,
        "Поиск ограждения по ID","\
        {FFFFFF}Укажите индификатор (ID) ограждения\n\n\
        Примечание: индификатор (ID) отображается на ограждении",
        "Изменить","Закрыть"
    );
    return 1;
}

DialogResponse:D_EDIT_BORT_SEARCH_ID(playerid, response, listitem, inputtext[])
{
    if(!response) 
        return 1;

    new slot_id = strval(inputtext);

    if(!(1 <= slot_id <= MAX_CREATE_BORTS)) 
        return Dialog_Show(playerid, Dialog:D_EDIT_BORT_SEARCH_ID);

    for(new bort_id; bort_id < MAX_CREATE_BORTS; bort_id++)
    {
        if(GetBortData(bort_id, BORT_ID) != slot_id)
            continue;

        Bort:Edit(playerid, bort_id);

        return 1;
    }

    SendClientMessage(playerid, -1, "С таким ID в списке ограждений нет!");

    return 1;
}

DialogCreate:D_BORT_LIST(playerid)
{
    strcat(FormatData_2048, "{FFFFFF}Название\t{FFFFFF}ID объекта\t{FFFFFF}Никнейм\n");

    new 
        slot_id,
        bort_total_count;

    for(new bort_id; bort_id < MAX_CREATE_BORTS; bort_id++)
    {
        if(GetBortData(bort_id, BORT_OBJECT_CREATE) == INVALID_OBJECT_ID)
            continue;

        g_player_bort_count[playerid][bort_total_count] = bort_id;

        slot_id = GetBortData(bort_id, BORT_SLOT_ID);

        format
        (
            FormatData_2048, sizeof FormatData_2048, 
            "%s%s\t%d\t%s\n", 
            FormatData_2048,
            GetBortInfo(slot_id, BORT_NAME), 
            GetBortInfo(slot_id, BORT_OBJECT_ID),
            GetBortData(bort_id, BORT_PLAYER_NAME)
        );

        bort_total_count ++;
    }
    Dialog_Open
    (
        playerid, 
        Dialog:D_BORT_LIST, 
        DIALOG_STYLE_TABLIST_HEADERS, 
        "{FFFFFF}Список ограждений", 
        FormatData_2048, 
        !"Выбрать", !"Закрыть"
    );

    FormatData_2048="";
    return 1;
}

DialogCreate:D_REMOVE_BORT(playerid)
{
    FormatData_2048="";

    strcat(FormatData_2048, "{FFFFFF}Название\t{FFFFFF}ID объекта\t{FFFFFF}Никнейм\n");

    new 
        slot_id,
        bort_total_count;

    for(new bort_id; bort_id < MAX_CREATE_BORTS; bort_id++)
    {
        if(GetBortData(bort_id, BORT_OBJECT_CREATE) == INVALID_OBJECT_ID)
            continue;

        g_player_bort_count[playerid][bort_total_count] = bort_id;

        slot_id = GetBortData(bort_id, BORT_SLOT_ID);

        format
        (
            FormatData_2048, sizeof FormatData_2048, 
            "%s%s\t%d\t%s\n", 
            FormatData_2048,
            GetBortInfo(slot_id, BORT_NAME), 
            GetBortInfo(slot_id, BORT_OBJECT_ID),
            GetBortData(bort_id, BORT_PLAYER_NAME)
        );

        bort_total_count ++;
    }

    strcat
    (
        FormatData_2048, "\
        Поиск ограждения по ID\n\
        Выбрать ограждения мышкой"
    );

    Dialog_Open
    (
        playerid, 
        Dialog:D_REMOVE_BORT, 
        DIALOG_STYLE_TABLIST_HEADERS, 
        "{FFFFFF}Выберите ограждение | Удаления", 
        FormatData_2048, 
        !"Выбрать", !"Закрыть"
    );

    FormatData_2048="";
    return 1;
}

DialogResponse:D_REMOVE_BORT(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    if(strfind(inputtext, "Поиск ограждения по ID") != -1)
    {
        Dialog_Show(playerid, Dialog: D_REMOVE_BORT_SEARCH_ID);
    }
    else if(strfind(inputtext, "Выбрать ограждения мышкой") != -1)
    {
        SetPVarInt(playerid, #BORT_SELECT_MOUSE, BORT_MOUSE_TYPE_REMOVE);
        SelectObject(playerid);
    }
    else 
    {
        new 
            bort_id = g_player_bort_count[playerid][listitem];

        SendFormattedMessage(playerid, -1, "Вы успешно удалили ограждения %s (ID: %d)", GetBortInfo(GetBortData(bort_id, BORT_SLOT_ID), BORT_NAME), GetBortData(bort_id, BORT_ID));
    
        Bort:Remove(bort_id);
    }
    return 1;
}

DialogCreate:D_REMOVE_BORT_SEARCH_ID(playerid)
{
    Dialog_Open
    (
        playerid, 
        Dialog:D_REMOVE_BORT_SEARCH_ID, DIALOG_STYLE_INPUT,
        "Поиск ограждения по ID","\
        {FFFFFF}Укажите индификатор (ID) ограждения\n\n\
        Примечание: индификатор (ID) отображается на ограждении",
        "Удалить","Закрыть"
    );
    return 1;
}

DialogResponse:D_REMOVE_BORT_SEARCH_ID(playerid, response, listitem, inputtext[])
{
    if(!response) 
        return 1;

    new bortID = strval(inputtext);

    if(!(1 <= bortID <= MAX_CREATE_BORTS)) 
        return Dialog_Show(playerid, Dialog:D_REMOVE_BORT_SEARCH_ID);

    for(new bort_id; bort_id < MAX_CREATE_BORTS; bort_id++)
    {
        if(GetBortData(bort_id, BORT_ID) != bortID)
            continue;

        SendFormattedMessage(playerid, -1, "Вы успешно удалили ограждения %s (ID: %d)", GetBortInfo(GetBortData(bort_id, BORT_SLOT_ID), BORT_NAME), bortID);
    
        Bort:Remove(bort_id);

        return 1;
    }

    SendClientMessage(playerid, -1, "С таким ID в списке ограждений нет!");

    return 1;
}


CMD:bort(playerid, params[]) 
{
    if(sscanf(params, "s[10]", params[0]))
        return 1;
    
    new total = Bort:GetTotalCreated();

    if(!strcmp(params[0], "create"))
    {
        if(total > MAX_CREATE_BORTS)
            return SendFormattedMessage(playerid, -1, "Превышен лимит ограждений (%d/"#MAX_CREATE_BORTS").", total);

        if(IsPlayerInAnyVehicle(playerid))
            return SendClientMessage(playerid, -1, "Запрещено использовать в транспорте");

        Dialog_Show(playerid, Dialog: D_BORT_CREATE);
        
    }
    else if(!strcmp(params[0], "edit")) 
    {
        if(!total)
            return SendClientMessage(playerid, -1, "Список созданых ограждений пуст!");
            
        if(IsPlayerInAnyVehicle(playerid))
            return SendClientMessage(playerid, -1, "Запрещено использовать в транспорте");

        Dialog_Show(playerid, Dialog: D_EDIT_BORT);
    }
    else if(!strcmp(params[0], "remove"))
    {
        if(!total)
            return SendClientMessage(playerid, -1, "Список созданых ограждений пуст!");

        Dialog_Show(playerid, Dialog: D_REMOVE_BORT);
    }
    else if(!strcmp(params[0], "list"))
        return Dialog_Show(playerid, Dialog: D_BORT_LIST);

    return 1;
}

public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(GetPVarInt(playerid, #BORT_CREATE_OBJECT_EDIT)) 
    {
        new
            bort_id = GetPVarInt(playerid, #BORT_SLOT_ID),
            slot_id = GetBortData(bort_id, BORT_SLOT_ID),
            Float: position_z = GetPVarFloat(playerid, #BORT_POS_Z)
        ;
            
        switch(response)
        {
            case EDIT_RESPONSE_FINAL:
            {
                if(z > position_z + 0.5 || z < position_z - 0.2)
                {
                    SetDynamicObjectPos(objectid, x, y, position_z);
                    SetDynamicObjectRot(objectid, rx, ry, rz);

                    EditDynamicObject(playerid, objectid);

                    return SendClientMessage(playerid, -1, "установите барьер на уровне земли");
                }

                if(!IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
                    return SendClientMessage(playerid, -1, "Вы слишком далеко от ограждения");
                
                if(IsPlayerInRangeOfPoint(playerid, 1.0, x, y, z))
                    return SendClientMessage(playerid, -1, "Вы находитесь слишком близко к ограждению");
                
                SetDynamicObjectPos(objectid, x, y, z);
                SetDynamicObjectRot(objectid, rx, ry, rz);

                format(GetBortData(bort_id, BORT_PLAYER_NAME), 32, GetPlayerData(playerid, PLAYER_NAME));

                SetBortData(bort_id, BORT_X, x);
                SetBortData(bort_id, BORT_Y, y);
                SetBortData(bort_id, BORT_Z , z);

                new bort_3D_label[64];
                format(bort_3D_label, sizeof bort_3D_label, "Ограждение №%d\nУстановил: %s", GetBortData(bort_id, BORT_ID), GetPlayerData(playerid, PLAYER_NAME));
                SetBortData(bort_id, BORT_3DTEXT, CreateDynamic3DTextLabel(bort_3D_label, 0x80808077, x, y, z, 2.5));

                SendFormattedMessage(playerid, -1, "Вы установили ограждение %s под номером %d.", GetBortInfo(slot_id, BORT_NAME), GetBortData(bort_id, BORT_ID));

                SendClientMessage(playerid, -1, !"Используйте команду /bort edit, чтобы изменить положение ограждения");

                DeletePVar(playerid, #BORT_SLOT_ID);
                DeletePVar(playerid, #BORT_CREATE_OBJECT_EDIT);
                DeletePVar(playerid, #BORT_POS_Z);
            }
            case EDIT_RESPONSE_CANCEL:
            {
                SendFormattedMessage(playerid, -1, "Вы отменили установку ограждения %s", GetBortInfo(slot_id, BORT_NAME));

                DestroyDynamicObject(objectid);

                g_bort_data[bort_id] = g_bort_data_default;

                DeletePVar(playerid, #BORT_SLOT_ID);
                DeletePVar(playerid, #BORT_CREATE_OBJECT_EDIT);
                DeletePVar(playerid, #BORT_POS_Z);
            }
        }
    }
    if(GetPVarInt(playerid, #BORT_EDIT_POSITION))
    {
        switch(response)
        {
            case EDIT_RESPONSE_FINAL:
            {
                new
                    Float: position_z = GetPVarFloat(playerid, #BORT_EDIT_POSITION_Z);

                if(z > position_z + 0.5 || z < position_z - 0.2)
                {
                    SetDynamicObjectPos(objectid, x, y, position_z);
                    SetDynamicObjectRot(objectid, rx, ry, rz);

                    EditDynamicObject(playerid, objectid);

                    SendClientMessage(playerid, -1, "установите барьер на уровне земли");
                    return 1;
                }

                SetDynamicObjectPos(objectid, x, y, z);
                SetDynamicObjectRot(objectid, rx, ry, rz);

                new 
                    bort_id = GetPVarInt(playerid, #BORT_SLOT_ID);

                SendFormattedMessage(playerid, -1, !"Вы успешно изменили положение ограждения id %d", GetBortData(bort_id, BORT_ID));

                SetBortData(bort_id, BORT_X, x);
                SetBortData(bort_id, BORT_Y, y);
                SetBortData(bort_id, BORT_Z, z);


                if(IsValidDynamic3DTextLabel(GetBortData(bort_id, BORT_3DTEXT))) 
                    DestroyDynamic3DTextLabel(GetBortData(bort_id, BORT_3DTEXT));

                new bort_3D_label[64];
                format(bort_3D_label, sizeof bort_3D_label, "Ограждение №%d\nУстановил: %s", GetBortData(bort_id, BORT_ID), GetPlayerData(playerid, PLAYER_NAME));
                SetBortData(bort_id, BORT_3DTEXT, CreateDynamic3DTextLabel(bort_3D_label, 0x80808077, x, y, z, 2.5));

                DeletePVar(playerid, #BORT_EDIT_POSITION_Z);
                DeletePVar(playerid,  #BORT_EDIT_POSITION);
                DeletePVar(playerid, #BORT_SLOT_ID);
            }
            case EDIT_RESPONSE_CANCEL:
            {
                SendFormattedMessage(playerid, -1, "Вы отказались от изменения положения ограждения id %d", GetBortData(GetPVarInt(playerid, #BORT_SLOT_ID), BORT_ID));

                DeletePVar(playerid, #BORT_EDIT_POSITION_Z);
                DeletePVar(playerid,  #BORT_EDIT_POSITION);
            }
        }
    } 
    #if defined EditBortDynamicObject
        return EditBortDynamicObject(playerid, objectid, response, x, y, z, rx, ry, rz);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerEditDynamicObject
    #undef OnPlayerEditDynamicObject
#else
    #define _ALS_OnPlayerEditDynamicObject
#endif

#define OnPlayerEditDynamicObject EditBortDynamicObject
#if defined EditBortDynamicObject
    forward EditBortDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
#endif


public OnPlayerSelectDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, modelid, Float:x, Float:y, Float:z)
{
    if(GetPVarInt(playerid, #BORT_SELECT_MOUSE))
    {
        for(new bort_id; bort_id < MAX_CREATE_BORTS; bort_id++)
        {
            if(GetBortData(bort_id, BORT_OBJECT_CREATE) != objectid)
                continue;

            switch(GetPVarInt(playerid, #BORT_SELECT_MOUSE))
            {
                case BORT_MOUSE_TYPE_EDIT:
                {
                    Bort:Edit(playerid, bort_id);
                }
                case BORT_MOUSE_TYPE_REMOVE:
                {
                    SendFormattedMessage(playerid, -1, "Вы успешно удалили ограждения %s (ID: %d)", GetBortInfo(GetBortData(bort_id, BORT_SLOT_ID), BORT_NAME), GetBortData(bort_id, BORT_ID));
               
                    Bort:Remove(bort_id);
        
                }
            }

            CancelSelectTextDraw(playerid);

            DeletePVar(playerid, #BORT_SELECT_MOUSE);
            return 1;
        }
    }
    #if defined SelectBortDynamicObject
        return SelectBortDynamicObject(playerid, objectid, modelid, x, y, z);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerSelectDynamicObjec
    #undef OnPlayerSelectDynamicObject
#else
    #define _ALS_OnPlayerSelectDynamicObjec
#endif

#define OnPlayerSelectDynamicObject SelectBortDynamicObject
#if defined SelectBortDynamicObject
    forward SelectBortDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, modelid, Float:x, Float:y, Float:z);
#endif


stock Bort:Edit(playerid, bort_id)
{
    new
        Float: bort_x = GetBortData(bort_id, BORT_X),
        Float: bort_y = GetBortData(bort_id, BORT_Y),
        Float: bort_z = GetBortData(bort_id, BORT_Z);

    if(!IsPlayerInRangeOfPoint(playerid, 5.0, bort_x, bort_y, bort_z))
        return SendClientMessage(playerid, -1, "Вы слишком далеко от ограждения");
    
    if(IsPlayerInRangeOfPoint(playerid, 1.0, bort_x, bort_y, bort_z))
        return SendClientMessage(playerid, -1, "Вы находитесь слишком близко к ограждению");
    

    EditDynamicObject(playerid, GetBortData(bort_id, BORT_OBJECT_CREATE)); 

    DestroyDynamic3DTextLabel(GetBortData(bort_id, BORT_3DTEXT));

    SetPVarInt(playerid, #BORT_SLOT_ID, bort_id);
    SetPVarFloat(playerid, #BORT_EDIT_POSITION_Z, bort_z);
    SetPVarInt(playerid, #BORT_EDIT_POSITION, true);
    return 1;
}
stock Bort:Remove(bort_id)
{
    if(!(0 <= bort_id <= MAX_CREATE_BORTS - 1))
        return 1;
        
    if(IsValidDynamic3DTextLabel(GetBortData(bort_id, BORT_3DTEXT)))
        DestroyDynamic3DTextLabel(GetBortData(bort_id, BORT_3DTEXT));

    if(IsValidDynamicObject(GetBortData(bort_id, BORT_OBJECT_CREATE)))
        DestroyDynamicObject(GetBortData(bort_id, BORT_OBJECT_CREATE));
    
    g_bort_data[bort_id] = g_bort_data_default;

    return 1;
}

public OnGameModeInit()
{
    for(new bort_id; bort_id < MAX_CREATE_BORTS; bort_id++)
    {
        g_bort_data[bort_id] = g_bort_data_default;
    }
    #if defined Bort_OnGameModeInit
        return Bort_OnGameModeInit();
    #else
        return 1;
    #endif
}
#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif

#define OnGameModeInit Bort_OnGameModeInit
#if defined Bort_OnGameModeInit
    forward Bort_OnGameModeInit();
#endif