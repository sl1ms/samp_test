#define Accessories:%0(%1)                   ACS_%0(%1)

#define MAX_ACCESSORIES                     8
#define MAX_MY_ACCESSORIES                  MAX_PLAYER_ATTACHED_OBJECTS



#define DB_ACCESSORIES                      "`accessories`"
#define DB_ACCESSORIES_DATA                 "`accessories_data`"
#define DB_ACCESSORIES_DESCRIPTION          "`accessories_descriptions`"

#define GetPlayerAccSlot(%0,%1,%2)          g_player_accessory[%0][%1][%2]
#define SetPlayerAccSlot(%0,%1,%2,%3)       g_player_accessory[%0][%1][%2] = %3

#define INVALID_ACC_INDEX                   -1

enum E_PLAYER_ACC_STRUCT
{
    bool: E_PA_USED,
    E_PA_SQL_ID,
    E_PA_TYPE,
    E_PA_MODEL,
    E_PA_EXTRA,
    E_PA_SLOT,
    E_PA_BONE,
    Float: E_PA_OFFSET_X,
	Float: E_PA_OFFSET_Y,
	Float: E_PA_OFFSET_Z,
	Float: E_PA_ROT_X,
	Float: E_PA_ROT_Y,
	Float: E_PA_ROT_Z,
	Float: E_PA_SCALE_X,
	Float: E_PA_SCALE_Y,
	Float: E_PA_SCALE_Z,
    E_PA_MATCOLOR_1,
    E_PA_MATCOLOR_2
};

new g_player_accessory[MAX_PLAYERS][MAX_PLAYER_ATTACHED_OBJECTS][E_PLAYER_ACC_STRUCT],
    g_player_accessory_default[E_PLAYER_ACC_STRUCT] =
{
    false,              // E_PA_USED
    INVALID_ACC_INDEX,  // E_PA_SQL_ID
    0,                  // E_PA_TYPE
    0,                  // E_PA_MODEL
    0,                  // E_PA_EXTRA
    INVALID_ACC_INDEX,  // E_PA_SLOT
    INVALID_ACC_INDEX,  // E_PA_BONE
    0.0,                // E_PA_OFFSET_X
    0.0,                // E_PA_OFFSET_Y
    0.0,                // E_PA_OFFSET_Z
    0.0,                // E_PA_ROT_X
    0.0,                // E_PA_ROT_Y
    0.0,                // E_PA_ROT_Z
    0.0,                // E_PA_SCALE_X
    0.0,                // E_PA_SCALE_Y
    0.0                 // E_PA_SCALE_Z
};

enum E_ACCESSORIES_DATA 
{
    ACCESSORY_SQL_ID,
    ACCESSORY_NAME[24],
    ACCESSORY_SLOT, 
    ACCESSORY_CATEGORY,
    ACCESSORY_MODEL, 
    ACCESSORY_BONE, 

    Float: ACCESSORY_OFFSET_X,
    Float: ACCESSORY_OFFSET_Y,
    Float: ACCESSORY_OFFSET_Z,
    Float: ACCESSORY_ROT_X,
    Float: ACCESSORY_ROT_Y,
    Float: ACCESSORY_ROT_Z,
    Float: ACCESSORY_SCALE_X,
    Float: ACCESSORY_SCALE_Y,
    Float: ACCESSORY_SCALE_Z,
    
    ACCESSORY_MATERIAL_COLOR1,
    ACCESSORY_MATERIAL_COLOR2,

    ACCESSORY_DESCRIPTION[128]
}

 
new g_accessories_data[MAX_ACCESSORIES][E_ACCESSORIES_DATA];


new g_temp_accessories_listitem[MAX_PLAYERS][MAX_MY_ACCESSORIES];

new g_quantity_accessories;