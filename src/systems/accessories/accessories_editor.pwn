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
	A_OBJECT_BONE_SPINE = 1, 		// ����
	A_OBJECT_BONE_HEAD, 			// ������
	A_OBJECT_BONE_LEFT_ARM, 		// ����� �����
	A_OBJECT_BONE_RIGHT_ARM, 		// ������ �����
	A_OBJECT_BONE_LEFT_HAND, 		// ����� ����
	A_OBJECT_BONE_RIGHT_HAND, 		// ������ ����
	A_OBJECT_BONE_LEFT_THIGH, 		// ����� �����
 	A_OBJECT_BONE_RIGHT_THIGH,		// ������ �����
	A_OBJECT_BONE_LEFT_FOOT, 		// ����� ����
	A_OBJECT_BONE_RIGHT_FOOT, 		// ������ ����
	A_OBJECT_BONE_RIGHT_CALF, 		// ������ ������
	A_OBJECT_BONE_LEFT_CALF, 		// ����� ������
	A_OBJECT_BONE_LEFT_FOREARM, 	// ����� ����������
	A_OBJECT_BONE_RIGHT_FOREARM,	// ������ ����������
	A_OBJECT_BONE_LEFT_CLAVICLE,	// ����� ������� (�����)
	A_OBJECT_BONE_RIGHT_CLAVICLE,	// ������ ������� (�����)
	A_OBJECT_BONE_NECK, 			// ���
	A_OBJECT_BONE_JAW				// �������
};

