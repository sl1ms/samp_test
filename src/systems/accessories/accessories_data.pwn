#define Accessories:%0(%1)                    ACS__%0(%1)

#define DB_ACCESSORIES_DATA                 "`accessories_data`"
#define DB_ACCOUNTS_ACCESSORIES             "`account_accessories`"
#define DB_ACCOUNT_ACCESSORY                "`account_accessory`"

#define MAX_ACCESSORIES                     (10)
#define MAX_PLAYER_ACCESSORIES              MAX_PLAYER_ATTACHED_OBJECTS        

#define SetAccessoryData(%0,%1,%2)          g_accessory_data[%0][%1] = %2
#define GetAccessoryData(%0,%1)             g_accessory_data[%0][%1]
#define SetPlayerAccessoryData(%0,%2,%3,%1) g_player_accessory_data[%0][%1][%2] = %3
#define GetPlayerAccessoryData(%0,%2,%1)    g_player_accessory_data[%0][%1][%2]

enum E_ACCESSORY
{
    ACCESSORY_SQL_ID,
    ACCESSORY_NAME[24],
    ACCESSORY_MODEL,
    ACCESSORY_BONE,
    
    Float:ACCESSORY_OFFSET_X,
    Float:ACCESSORY_OFFSET_Y,
    Float:ACCESSORY_OFFSET_Z,
    Float:ACCESSORY_ROT_X,
    Float:ACCESSORY_ROT_Y,
    Float:ACCESSORY_ROT_Z,
    Float:ACCESSORY_SCALE_X,
    Float:ACCESSORY_SCALE_Y,
    Float:ACCESSORY_SCALE_Z,

    ACCESSORY_MATERIAL_COLOR1,
    ACCESSORY_MATERIAL_COLOR2
};

new g_accessory_data[MAX_ACCESSORIES][E_ACCESSORY];


enum E_PLAYER_ACCESSORY 
{
    P_ACCESSORY_SQL_ID, 
    P_ACCESSORY_MODEL,
    P_ACCESSORY_BONE,

    Float:P_ACCESSORY_OFFSET_X,
    Float:P_ACCESSORY_OFFSET_Y,
    Float:P_ACCESSORY_OFFSET_Z,
    Float:P_ACCESSORY_ROT_X,
    Float:P_ACCESSORY_ROT_Y,
    Float:P_ACCESSORY_ROT_Z,
    Float:P_ACCESSORY_SCALE_X,
    Float:P_ACCESSORY_SCALE_Y,
    Float:P_ACCESSORY_SCALE_Z,
    
    P_ACCESSORY_MATERIAL_COLOR1,
    P_ACCESSORY_MATERIAL_COLOR2
};

new g_player_accessory_data[MAX_PLAYERS][MAX_PLAYER_ACCESSORIES][E_PLAYER_ACCESSORY];

#define GetPlayerAccessoryUniqueID(%0,%1) g_player_accessory_sql_id[%0][%1]
#define SetPlayerAccessoryUniqueID(%0,%1,%2) g_player_accessory_sql_id[%0][%1] = %2

new g_player_accessory_sql_id[MAX_PLAYERS][MAX_PLAYER_ACCESSORIES];

new TOTAL_ACCESSORIES = 0;
