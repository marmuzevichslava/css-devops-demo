#define DATA_TYPE_SHORT	0
#define	DATA_TYPE_LONG	1

#define FND_WIN32

// standard includes 
#include <windows.h>
#include <stdio.h>
#include <malloc.h>
#include <string.h>

/* includes for all */
#include "tcppipe.h"
#include "azgscmn.h"

SHORT ArchGsFormatMsgHdr( USHORT OrderType, MESSAGE_HDR *pMsgHeader );


