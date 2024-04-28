#define AttachEdit:%0(%1)				AttachEdit_%0(%1)

#define GetAttachEditInfo(%0,%1)		g_attachments_editor[%0][%1]
#define SetAttachEditInfo(%0,%1,%2)		g_attachments_editor[%0][%1] = %2

#define INVALID_ATTACHEDIT_INDEX		-1

enum E_ATTACHMENTS_EDITOR_STRUCT
{
	bool: E_IS_SHOW,
	E_INDEX,
	E_MODEL,
	E_EXTRA,
	E_BONE,
	Float: E_OFFSET_X,
	Float: E_OFFSET_Y,
	Float: E_OFFSET_Z,
	Float: E_ROT_X,
	Float: E_ROT_Y,
	Float: E_ROT_Z,
	Float: E_SCALE_X,
	Float: E_SCALE_Y,
	Float: E_SCALE_Z,
	Float: E_STEP,
	E_MATERIALCOLOR_1,
	E_MATERIALCOLOR_2
};

new g_attachments_editor[MAX_PLAYERS][E_ATTACHMENTS_EDITOR_STRUCT];

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

