#define Bort:%0(%1)                     BRT__%0(%1)
#define MAX_POLICE_BORTS                (16)
#define MAX_CREATE_BORTS                40

#define BORT_MOUSE_TYPE_EDIT            1
#define BORT_MOUSE_TYPE_REMOVE          2

#define GetBortInfo(%0,%1)              g_borts_info[%0][%1]

#define SetBortData(%0,%1,%2)           g_bort_data[%0][%1] = %2
#define GetBortData(%0,%1)              g_bort_data[%0][%1]


enum E_BORT_INFO
{
    BORT_OBJECT_ID,
    BORT_NAME[64],
    Float: BORT_RADIUS,
    Float: BORT_COORD_Z
};

enum E_BORT
{
    BORT_ID,
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
    -1,
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
