#define DB_ACCOUNT                          "`accounts`"

#define Player:%0(%1)	                    PL__%0(%1)

#define SetPlayerData(%0,%1,%2)             g_player_data[%0][%1] = %2
#define GetPlayerData(%0,%1)                g_player_data[%0][%1]

#define MAX_LENGTH_PASSWORD                 (64)


enum E_PLAYER_DATA 
{
    PLAYER_ID, 
    PLAYER_NAME[MAX_PLAYER_NAME],
    PLAYER_PASSWORD[MAX_LENGTH_PASSWORD],
    bool: PLAYER_AUTHORIZED,
};

new g_player_data[MAX_PLAYERS][E_PLAYER_DATA];

new g_player_data_default[E_PLAYER_DATA] = {
    -1, // PLAYER_ID
    "", // PLAYER_NAME
    "", // PLAYER_PASSWORD 
    false
};

