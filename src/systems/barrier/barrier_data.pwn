#define Bort:%0(%1)                     BRT__%0(%1)
#define MAX_POLICE_BORTS                (16)
#define MAX_CREATE_BORTS                40

#define PVAR_BORT_TYPE_ACTION_CREATE    1

#define GetBortInfo(%0,%1)              g_borts_info[%0][%1]

#define SetBortData(%0,%1,%2)        g_bort_data[%0][%1] = %2
#define GetBortData(%0,%1)           g_bort_data[%0][%1]


enum E_BORT_INFO
{
    BORT_OBJECT_ID,
    BORT_NAME[64],
    Float: BORT_RADIUS,
    Float: BORT_COORD_Z
};

enum E_BORT
{
    BORT_PLAYER_NAME[32],
    Float: BORT_X,
    Float: BORT_Y,
    Float: BORT_Z,
    BORT_OBJECT_CREATE,
    BORT_SLOT_ID,
    Text3D: BORT_3DTEXT,
    Float: BORT_OBJECT_RADIUS
};

new g_bort_data_default[E_BORT] = {
    "",
    0.0,
    0.0,
    0.0,
    INVALID_OBJECT_ID,
    -1,
    Text3D:INVALID_3DTEXT_ID, 
    0.0
};

new g_bort_data[MAX_CREATE_BORTS][E_BORT];


new g_player_bort_count[MAX_PLAYERS][MAX_POLICE_BORTS];


new const g_borts_info[][E_BORT_INFO] = 
{
    {1427, "Дорожный барьер №1", 1.4, 0.5},
    {1422, "Дорожный барьер №2", 1.4, 0.5},
    {1434, "Дорожный барьер №3", 1.4, 0.5},
    {1459, "Дорожный барьер №4", 1.4, 0.5},
    {1228, "Дорожный барьер №5", 1.4, 0.5},
    {1423, "Дорожный барьер №6", 1.8, 0.3},
    {1424, "Дорожный барьер №7", 1.4, 0.5},
    {1282, "Дорожный барьер №8", 1.4, 0.5},
    {1435, "Дорожный барьер №9", 1.4, 0.5},
    {1238, "Дорожный конус", 1.4, 0.5},
    {1237, "Водный барьер", 1.3, 1.1},
    {979, "Отбойник", 1.4, 0.5},
    {1425, "Оранжевый дорожный барьер с надписью \"Detour\"", 1.4, 0.5},
    {3091, "Барьер с надписью \"LINE CLOSED\"", 2.9, 0.5},
    {981, "Большое ограждение \"WARNING! CLOSED TO TRAFFIC\"", 1.4, 0.5},
    {19834, "Полицейская лента", 1.4, 0.5}
};




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
        "{FFFFFF}Список ограждений", 
        FormatData_2048, 
        !"Выбрать", !"Закрыть"
    );
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

    switch(GetPVarInt(playerid, #BORT_TYPE_ACTION))
    {
        case PVAR_BORT_TYPE_ACTION_CREATE:
        {
            GetPlayerCameraPos(playerid, cam_x, cam_y, cam_z);
            GetPlayerPos(playerid, player_x, player_y, player_z);
            GetPlayerCameraFrontVector(playerid, vec_x, vec_y, vec_z);

            object_x = cam_x + floatmul(vec_x, 8.0);
            object_y = cam_y + floatmul(vec_y, 8.0);

            new object_id = CreateDynamicObject(GetBortInfo(listitem, BORT_OBJECT_ID), object_x, object_y, player_z - GetBortInfo(listitem, BORT_COORD_Z), 0.0, 0.0, 0.0);

            SendFormattedMessage(playerid, -1, "%d %d %f %f %f", slot_id, GetBortInfo(listitem, BORT_OBJECT_ID), object_x, object_y, player_z - GetBortInfo(listitem, BORT_OBJECT_ID));

            SetBortData(slot_id, BORT_OBJECT_CREATE, object_id); 

            SetBortData(slot_id, BORT_SLOT_ID, listitem);

            EditDynamicObject(playerid, object_id);

            SetPVarFloat(playerid, #BORT_POS_Z, player_z - GetBortInfo(listitem, BORT_COORD_Z));
            SetPVarInt(playerid, #BORT_CREATE_OBJECT_EDIT, true);
            SetPVarInt(playerid, #BORT_CREATE_SLOT_ID, slot_id);

            SendFormattedMessage(playerid, -1, "Вы начали установку ограждения %s", GetBortInfo(listitem, BORT_NAME));
        }
    }
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
        Dialog:D_BORT_LIST, 
        DIALOG_STYLE_TABLIST_HEADERS, 
        "{FFFFFF}Выберите ограждение", 
        FormatData_2048, 
        !"Выбрать", !"Закрыть"
    );
    return 1;
}

DialogResponse:D_EDIT_BORT(playerid, response, listitem, inputtext[])
{
    if(strfind(inputtext, "Поиск ограждения по ID") != -1)
    {
        Dialog_Show(playerid, Dialog: D_EDIT_BORT_SEARCH_ID);
    }
    else if(strfind(inputtext, "Выбрать ограждения мышкой") != -1)
    {
        SetPVarInt(playerid, #BORT_SELECT_OBJECT, 1);
        SelectObject(playerid);
    }
    else 
    {
        
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

    new search_value_id = strval(inputtext);

    if(!search_value_id) 
        return Dialog_Show(playerid, Dialog:D_EDIT_BORT_SEARCH_ID);

    for(new bort_id; bort_id < MAX_CREATE_BORTS; bort_id)
    {
        if(GetBortData(bort_id, BORT_SLOT_ID) != search_value_id)
            continue;
        
        SetPVarInt(playerid, #BORT_EDIT_POSITION, true);

        EditDynamicObject(playerid, GetBortData(bort_id, BORT_OBJECT_CREATE));

        return 1;

    }

    return 1;
}

DialogCreate:D_BORT_LIST(playerid)
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
    Dialog_Open
    (
        playerid, 
        Dialog:D_BORT_LIST, 
        DIALOG_STYLE_TABLIST_HEADERS, 
        "{FFFFFF}Список ограждений", 
        FormatData_2048, 
        !"Выбрать", !"Закрыть"
    );
    return 1;
}


CMD:bort(playerid, params[]) 
{
    new total = Bort:GetTotalCreated();
    
    if(!strcmp(params, "create"))
    {
        if(total > MAX_CREATE_BORTS)
            return SendFormattedMessage(playerid, -1, "Превышен лимит ограждений (%d/"#MAX_CREATE_BORTS").", total);

        if(IsPlayerInAnyVehicle(playerid))
            return SendClientMessage(playerid, -1, "Запрещено использовать в транспорте");

        SetPVarInt(playerid, #BORT_TYPE_ACTION, PVAR_BORT_TYPE_ACTION_CREATE);

        Dialog_Show(playerid, Dialog: D_BORT_CREATE);
        
    }
    else if(!strcmp(params, "edit")) 
    {
      Dialog_Show(playerid, Dialog: D_BORT_LIST);
    }
    else if(!strcmp(params, "remove"))
    {
        if(!total)
            return SendClientMessage(playerid, -1, "Список созданых ограждений пуст!");

        SetPVarInt(playerid, #BORT_SELECT_OBJECT, 2);

        SelectObject(playerid);
    }
    else if(!strcmp(params, "list"))
        return Dialog_Show(playerid, Dialog: D_BORT_CREATE);

    return 1;
}

public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(GetPVarInt(playerid, #BORT_CREATE_OBJECT_EDIT)) 
    {
        new
            bort_id = GetPVarInt(playerid, #BORT_CREATE_SLOT_ID),
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
                
                SetDynamicObjectPos(objectid, x, y, z);
                SetDynamicObjectRot(objectid, rx, ry, rz);

                format(GetBortData(bort_id, BORT_PLAYER_NAME), 32, GetPlayerData(playerid, PLAYER_NAME));

                SetBortData(bort_id, BORT_X, x);
                SetBortData(bort_id, BORT_Y, y);
                SetBortData(bort_id, BORT_Z , z);

                new bort_3D_label[64];
                format(bort_3D_label, sizeof bort_3D_label, "Ограждение №%d\nУстановил: %s", slot_id, GetPlayerData(playerid, PLAYER_NAME));
                SetBortData(bort_id, BORT_3DTEXT, CreateDynamic3DTextLabel(bort_3D_label, 0x80808077, x, y, z, 2.5));

                SendFormattedMessage(playerid, -1, "Вы установили ограждение %s под номером %d.", GetBortInfo(slot_id, BORT_NAME), slot_id);

                SendClientMessage(playerid, -1, !"Используйте команду /bort edit, чтобы изменить положение ограждения");

                DeletePVar(playerid, #BORT_CREATE_SLOT_ID);
                DeletePVar(playerid, #BORT_CREATE_OBJECT_EDIT);
                DeletePVar(playerid, #BORT_POS_Z);
            }
            case EDIT_RESPONSE_CANCEL:
            {
                SendFormattedMessage(playerid, -1, "Вы отменили установку ограждения %s", GetBortInfo(slot_id, BORT_NAME));

                DestroyDynamicObject(objectid);

                g_bort_data[bort_id] = g_bort_data_default;

                DeletePVar(playerid, #BORT_CREATE_SLOT_ID);
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
                    Float: position_z = GetPVarFloat(playerid, "EditBort:PositionZ");

                if(z > position_z + 0.5 || z < position_z - 0.2)
                {
                    SetDynamicObjectPos(objectid, x, y, position_z);
                    SetDynamicObjectRot(objectid, rx, ry, rz);

                    EditDynamicObject(playerid, objectid);

                    return SendClientMessage(playerid, -1, "установите барьер на уровне земли");
                }
                SendClientMessage(playerid, -1, !"Вы успешно изменили положение ограждения ");

                SetDynamicObjectPos(objectid, x, y, z);
                SetDynamicObjectRot(objectid, rx, ry, rz);

                new 
                    bort_id = GetPVarInt(playerid, "Bort:SlotID"),
                    slot_id = g_bort_data[bort_id][BORT_SLOT_ID];

                SetBortData(bort_id, BORT_X, x);
                SetBortData(bort_id, BORT_Y, y);
                SetBortData(bort_id, BORT_Z, z);


                if(IsValidDynamic3DTextLabel(GetBortData(bort_id, BORT_3DTEXT))) 
                    DestroyDynamic3DTextLabel(GetBortData(bort_id, BORT_3DTEXT));

                new bort_3D_label[64];
                format(bort_3D_label, sizeof bort_3D_label, "Ограждение №%d\nУстановил: %s", slot_id, GetPlayerData(playerid, PLAYER_NAME));
                SetBortData(bort_id, BORT_3DTEXT, CreateDynamic3DTextLabel(bort_3D_label, 0x80808077, x, y, z, 2.5));

                DeletePVar(playerid, "EditBort:PositionZ");
                DeletePVar(playerid, "Bort:EditPosition");
                DeletePVar(playerid, "Bort:SlotID");
            }
            case EDIT_RESPONSE_CANCEL:
            {
                SendClientMessage(playerid, -1, !"Вы отказались от изменения положения ограждения");

                DeletePVar(playerid, "EditBort:PositionZ");
                DeletePVar(playerid, "Bort:EditPosition");
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
    if(GetPVarInt(playerid, #BORT_SELECT_OBJECT))
    {
        for(new bort_id; bort_id < MAX_CREATE_BORTS; bort_id++)
        {
            if(GetBortData(bort_id, BORT_OBJECT_CREATE) != objectid)
                continue;

            DestroyDynamic3DTextLabel(GetBortData(bort_id, BORT_3DTEXT));

            g_bort_data[bort_id] = g_bort_data_default;
            
            SendFormattedMessage(playerid, -1, !"Вы успешно удалили %s", GetBortInfo(GetBortData(bort_id, BORT_SLOT_ID), BORT_NAME));

            DestroyDynamicObject(objectid);
            return 1;
        }
    }
    #if defined SelectBortDynamicObject
        return SelectBortDynamicObject(playerid, objectid, modelid, x, y, z);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerSelectDynamicObject
    #undef OnPlayerSelectDynamicObject
#else
    #define _ALS_OnPlayerSelectDynamicObject
#endif

#define OnPlayerSelectDynamicObject SelectBortDynamicObject
#if defined SelectBortDynamicObject
    forward SelectBortDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, modelid, Float:x, Float:y, Float:z);
#endif