#define Accessories:%0(%1)                   ACS_%0(%1)

#define MAX_ACCESSORIES                     sizeof g_accessories
#define MAX_MY_ACCESSORIES                  MAX_PLAYER_ATTACHED_OBJECTS

#define DB_ACCESSORIES                      "`accessories`"

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
    E_PA_W_SLOT,
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
    INVALID_ACC_INDEX, // E_PA_W_SLOT
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


enum
{
    A_TYPE_HATS_RED             = 1,        // Красные шапки
    A_TYPE_HATS_BANDANA         = 2,       // Бандана на голову
    A_TYPE_GLASSES              = 3,       // Очки
    A_TYPE_HEADPHONES           = 4,       // Наушники
    A_TYPE_MUSTACHE             = 5,       // Усы
    A_TYPE_BANDAGE              = 6,       // Повязка
    A_TYPE_WATCHES              = 7,       // Часы
    A_TYPE_BACKPACK             = 8,       // Рюкзак
    //
    A_TYPE_COUNT                = 9
};

new const g_accessory_category_name[A_TYPE_COUNT - 1][25] =
{
	"Красные шапки",
    "Банданы на голову",
    "Очки",
    "Наушники",
    "Усы",
    "Повязка",
    "Часы",
    "Рюкзаки"
};

enum
{
    A_SLOT_HAT,         // Первый слот это акссесуары на голову (нимб, шапки, цилиндры)
    A_SLOT_GLASSES,     // Второй слот это акссесуары на глаза (очки, пнв)
    A_SLOT_HANDS,       // Третий слот это акссесуары на руку (различные трости, машинки на р/у)
    A_SLOT_BODY,        // Четвертый слот это акссесуары на грудь (сердце на грудь, доллар на грудь, респиратор)
    A_SLOT_SHOULDER,    // Пятый слот это акссесуары на плечо (воздушный шар, олень на плечо и т д)
    A_SLOT_BACK         // Шестой слот это акссесуары на спину (щит, катана, миниган)
};

enum
{
	A_OBJECT_BONE_SPINE = 1, 		// Торс
	A_OBJECT_BONE_HEAD, 			// Голова
	A_OBJECT_BONE_LEFT_ARM, 		// Левое плечо
	A_OBJECT_BONE_RIGHT_ARM, 		// Правое плечо
	A_OBJECT_BONE_LEFT_HAND, 		// Левая рука
	A_OBJECT_BONE_RIGHT_HAND, 		// Правая рука
	A_OBJECT_BONE_LEFT_THIGH, 		// Левое бедро
 	A_OBJECT_BONE_RIGHT_THIGH,		// Правое бедро
	A_OBJECT_BONE_LEFT_FOOT, 		// Левая нога
	A_OBJECT_BONE_RIGHT_FOOT, 		// Правая нога
	A_OBJECT_BONE_RIGHT_CALF, 		// Правая голень
	A_OBJECT_BONE_LEFT_CALF, 		// Левая голень
	A_OBJECT_BONE_LEFT_FOREARM, 	// Левое предплечье
	A_OBJECT_BONE_RIGHT_FOREARM,	// Правое предплечье
	A_OBJECT_BONE_LEFT_CLAVICLE,	// Левая ключица (плечо)
	A_OBJECT_BONE_RIGHT_CLAVICLE,	// Правая ключица (плечо)
	A_OBJECT_BONE_NECK, 			// Шея
	A_OBJECT_BONE_JAW				// Челюсть
};

enum E_ACCESSORIES_STRUCT
{
    E_ACC_TYPE_SLOT,
    E_ACC_TYPE,
    E_ACC_NAME[24],
    E_ACC_MODEL,
    E_ACC_BONE,
    Float: E_ACC_OFFSET_X,
    Float: E_ACC_OFFSET_Y,
    Float: E_ACC_OFFSET_Z,
    Float: E_ACC_ROT_X,
    Float: E_ACC_ROT_Y,
    Float: E_ACC_ROT_Z,
    Float: E_ACC_SCALE_X,
    Float: E_ACC_SCALE_Y,
    Float: E_ACC_SCALE_Z,
    E_ACC_MATERIALCOLOR_1,
    E_ACC_MATERIALCOLOR_2
};

new g_accessories[][E_ACCESSORIES_STRUCT] =
{
    {A_SLOT_HAT,        A_TYPE_HATS_RED,   "Красная шапка",            19067, A_OBJECT_BONE_HEAD, 0.118998,0.003000,-0.004000, 0.000000,90.000000,96.400009, 1.058999,1.159999,1.000000},
    {A_SLOT_HAT,        A_TYPE_HATS_BANDANA,  "Бандана",        18910, A_OBJECT_BONE_HEAD, 0.120000,-0.001000,0.000000, -92.499984,-7.199993,-98.099990, 1.114999,1.000000,0.901000},
    {A_SLOT_GLASSES,    A_TYPE_GLASSES,  "Очки",             19140, A_OBJECT_BONE_HEAD, 0.102998,0.030999,-0.001001, 0.000000,90.000000,90.500007, 1.000000,1.058000,1.000000},
    {A_SLOT_GLASSES,    A_TYPE_HEADPHONES,  "Наушники",          19421, A_OBJECT_BONE_HEAD, 0.286000,0.089000,-0.006000, -90.599975,-121.999969,92.599967, 1.000000,1.000000,1.000000},
    {A_SLOT_GLASSES,    A_TYPE_MUSTACHE,  "Усы",            19350, A_OBJECT_BONE_HEAD, 0.025999,0.108000,0.003000, 0.000000,0.000000,-81.399993, 1.000000,1.000000,1.000000},
    {A_SLOT_GLASSES,    A_TYPE_BANDAGE,  "Повязка на глаз",             19085, A_OBJECT_BONE_HEAD, 0.102999,0.020000,-0.003999, -2.900000,91.700050,94.000015, 0.911999,1.068999,1.000000},
    {A_SLOT_HANDS,      A_TYPE_WATCHES,  "Часы",             19039, A_OBJECT_BONE_RIGHT_HAND, -0.018999,-0.003998,-0.001999, 51.200016,53.199977,142.800018, 0.963999,0.916999,1.000000},
    {A_SLOT_BODY,       A_TYPE_BACKPACK,  "Рюкзак",            19559, A_OBJECT_BONE_SPINE, -0.204000,-0.064999,-0.002999 ,  -0.600000,-1.100000,0.000000 ,  1.075999,0.918998,0.905000}
};

