/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/*************************************************************************
**
**	FILENAME:		AZDI0207.H
**
**	DESCRIPTION:	This is the header file AZDI0207.c
**
**  CREATED:
**
**  REVISION HISTORY
**
**    DATE      REVISED BY  SIR #   DESCRIPTION OF CHANGE
**  --------    ----------  ------  ---------------------------------------
*************************************************************************/

#include <windows.h>
#include <winperf.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <tchar.h>
#include <conio.h>


/*************************************************************************
**
**	typdefs
**
*************************************************************************/
typedef PERF_DATA_BLOCK             PERF_DATA,      *PPERF_DATA;
typedef PERF_OBJECT_TYPE            PERF_OBJECT,    *PPERF_OBJECT;
typedef PERF_INSTANCE_DEFINITION    PERF_INSTANCE,  *PPERF_INSTANCE;
typedef PERF_COUNTER_DEFINITION     PERF_COUNTER,   *PPERF_COUNTER;

LPTSTR      *gPerfTitleSz;
LPTSTR      TitleData;

#define NODATA  TEXT("--------")

#define INDEX_STR_LEN       10
#define MACHINE_NAME_LEN    MAX_COMPUTERNAME_LENGTH+2
#define MACHINE_NAME_SIZE   MACHINE_NAME_LEN+1

/*************************************************************************
**
**	Function Prototypes
**
*************************************************************************/
void    GetPerfIndex       (void); 
void    RefreshProcessList (PPERF_OBJECT pObject);
WORD    ProcessPriority    (PPERF_OBJECT pObject, PPERF_INSTANCE  pInstance);
void    SetProcessListText (PPERF_INSTANCE pInst, LPTSTR str);
DWORD   GetTitleIdx        (LPTSTR TitleSz[], DWORD LastIndex, LPTSTR Name);
void    GetProcessList     ( PPERF_OBJECT pObject, _ACTIVEPROCS_HDR *pActiveProcsHdr );

PPERF_OBJECT    FirstObject (PPERF_DATA pData);
PPERF_OBJECT    NextObject (PPERF_OBJECT pObject);
PPERF_OBJECT    FindObject (PPERF_DATA pData, DWORD TitleIndex);
PPERF_OBJECT    FindObjectN (PPERF_DATA pData, DWORD N);

PPERF_INSTANCE  FirstInstance (PPERF_OBJECT pObject);
PPERF_INSTANCE  NextInstance (PPERF_INSTANCE pInst);
PPERF_INSTANCE  FindInstanceN (PPERF_OBJECT pObject, DWORD N);
PPERF_INSTANCE  FindInstanceParent (PPERF_INSTANCE pInst, PPERF_DATA pData);
LPTSTR          InstanceName (PPERF_INSTANCE pInst);

PPERF_COUNTER   FirstCounter (PPERF_OBJECT pObject);
PPERF_COUNTER   NextCounter (PPERF_COUNTER pCounter);
PPERF_COUNTER   FindCounter (PPERF_OBJECT pObject, DWORD TitleIndex);
PVOID           CounterData (PPERF_INSTANCE pInst, PPERF_COUNTER pCount);

DWORD   GetPerfData 	   (HKEY			hPerfKey,
                     		LPTSTR			szObjectIndex,
                     		PPERF_DATA		*ppData, 
                     		DWORD			*pDataSize);

DWORD   GetPerfTitleSz	   (HKEY			hKeyMachine,
	                        HKEY			hKeyPerf, 
                         	LPTSTR			*TitleBuffer, 
                         	LPTSTR			*TitleSz[], 
                        	DWORD			*TitleLastIdx);

PPERF_DATA RefreshPerfData (HKEY            hPerfKey,
            				LPTSTR          szObjectIndex,
            				PPERF_DATA      pData,
            				DWORD           *pDataSize);

DWORD   PutCounterDWKB	   (DWORD           dwItemID,
                			PPERF_INSTANCE  pInst,
                			PPERF_OBJECT    pObj,
                			DWORD           dwCounterIdx);




#define Li2Double(x) ((double)((x).HighPart) * 4.294967296E9 + (double)((x).LowPart))


/* Globals */

TCHAR           INDEX_PROCTHRD_OBJ[2*INDEX_STR_LEN];
TCHAR           INDEX_COSTLY_OBJ[3*INDEX_STR_LEN];

TCHAR           gszMachineName[MACHINE_NAME_SIZE];
TCHAR           gszCurrentMachine[MACHINE_NAME_SIZE];

DWORD           gPerfDataSize = 50*1024;            // start with 50K
PPERF_DATA      gpPerfData;

PPERF_OBJECT    gpProcessObject;                       // pointer to process objects

HKEY            ghPerfKey    = HKEY_PERFORMANCE_DATA;  // get perf data from this key
HKEY            ghMachineKey = HKEY_LOCAL_MACHINE;     // get title index from this key

HCURSOR         ghCursor[2];                           // 0 = arrow, 1 = hourglass


#define PN_PROCESS                          TEXT("Process")
#define PN_PROCESS_CPU                      TEXT("% Processor Time")
#define PN_PROCESS_PRIV                     TEXT("% Privileged Time")
#define PN_PROCESS_USER                     TEXT("% User Time")
#define PN_PROCESS_WORKING_SET              TEXT("Working Set")
#define PN_PROCESS_PEAK_WS                  TEXT("Working Set Peak")
#define PN_PROCESS_PRIO                     TEXT("Priority Base")
#define PN_PROCESS_ELAPSE                   TEXT("Elapsed Time")
#define PN_PROCESS_ID                       TEXT("ID Process")
#define PN_PROCESS_PRIVATE_PAGE             TEXT("Private Bytes")
#define PN_PROCESS_VIRTUAL_SIZE             TEXT("Virtual Bytes")
#define PN_PROCESS_PEAK_VS                  TEXT("Virtual Bytes Peak")
#define PN_PROCESS_FAULT_COUNT              TEXT("Page Faults/sec")


#define PN_THREAD                           TEXT("Thread")
#define PN_THREAD_CPU                       TEXT("% Processor Time")
#define PN_THREAD_PRIV                      TEXT("% Privileged Time")
#define PN_THREAD_USER                      TEXT("% User Time")
#define PN_THREAD_START                     TEXT("Start Address")
#define PN_THREAD_SWITCHES                  TEXT("Context Switches/sec")
#define PN_THREAD_PRIO                      TEXT("Priority Current")
#define PN_THREAD_BASE_PRIO                 TEXT("Priority Base")
#define PN_THREAD_ELAPSE                    TEXT("Elapsed Time")

#define PN_THREAD_DETAILS                   TEXT("Thread Details")
#define PN_THREAD_PC                        TEXT("User PC")

#define PN_IMAGE                            TEXT("Image")
#define PN_IMAGE_NOACCESS                   TEXT("No Access")
#define PN_IMAGE_READONLY                   TEXT("Read Only")
#define PN_IMAGE_READWRITE                  TEXT("Read/Write")
#define PN_IMAGE_WRITECOPY                  TEXT("Write Copy")
#define PN_IMAGE_EXECUTABLE                 TEXT("Executable")
#define PN_IMAGE_EXE_READONLY               TEXT("Exec Read Only")
#define PN_IMAGE_EXE_READWRITE              TEXT("Exec Read/Write")
#define PN_IMAGE_EXE_WRITECOPY              TEXT("Exec Write Copy")


#define PN_PROCESS_ADDRESS_SPACE            TEXT("Process Address Space")
#define PN_PROCESS_PRIVATE_NOACCESS         TEXT("Reserved Space No Access")
#define PN_PROCESS_PRIVATE_READONLY         TEXT("Reserved Space Read Only")
#define PN_PROCESS_PRIVATE_READWRITE        TEXT("Reserved Space Read/Write")
#define PN_PROCESS_PRIVATE_WRITECOPY        TEXT("Reserved Space Write Copy")
#define PN_PROCESS_PRIVATE_EXECUTABLE       TEXT("Reserved Space Executable")
#define PN_PROCESS_PRIVATE_EXE_READONLY     TEXT("Reserved Space Exec Read Only")
#define PN_PROCESS_PRIVATE_EXE_READWRITE    TEXT("Reserved Space Exec Read/Write")
#define PN_PROCESS_PRIVATE_EXE_WRITECOPY    TEXT("Reserved Space Exec Write Copy")


#define PN_PROCESS_MAPPED_NOACCESS          TEXT("Mapped Space No Access")
#define PN_PROCESS_MAPPED_READONLY          TEXT("Mapped Space Read Only")
#define PN_PROCESS_MAPPED_READWRITE         TEXT("Mapped Space Read/Write")
#define PN_PROCESS_MAPPED_WRITECOPY         TEXT("Mapped Space Write Copy")
#define PN_PROCESS_MAPPED_EXECUTABLE        TEXT("Mapped Space Executable")
#define PN_PROCESS_MAPPED_EXE_READONLY      TEXT("Mapped Space Exec Read Only")
#define PN_PROCESS_MAPPED_EXE_READWRITE     TEXT("Mapped Space Exec Read/Write")
#define PN_PROCESS_MAPPED_EXE_WRITECOPY     TEXT("Mapped Space Exec Write Copy")


#define PN_PROCESS_IMAGE_NOACCESS           TEXT("Image Space No Access")
#define PN_PROCESS_IMAGE_READONLY           TEXT("Image Space Read Only")
#define PN_PROCESS_IMAGE_READWRITE          TEXT("Image Space Read/Write")
#define PN_PROCESS_IMAGE_WRITECOPY          TEXT("Image Space Write Copy")
#define PN_PROCESS_IMAGE_EXECUTABLE         TEXT("Image Space Executable")
#define PN_PROCESS_IMAGE_EXE_READONLY       TEXT("Image Space Exec Read Only")
#define PN_PROCESS_IMAGE_EXE_READWRITE      TEXT("Image Space Exec Read/Write")
#define PN_PROCESS_IMAGE_EXE_WRITECOPY      TEXT("Image Space Exec Write Copy")


DWORD   PX_PROCESS;
DWORD   PX_PROCESS_CPU;
DWORD   PX_PROCESS_PRIV;
DWORD   PX_PROCESS_USER;
DWORD   PX_PROCESS_WORKING_SET;
DWORD   PX_PROCESS_PEAK_WS;
DWORD   PX_PROCESS_PRIO;
DWORD   PX_PROCESS_ELAPSE;
DWORD   PX_PROCESS_ID;
DWORD   PX_PROCESS_PRIVATE_PAGE;
DWORD   PX_PROCESS_VIRTUAL_SIZE;
DWORD   PX_PROCESS_PEAK_VS;
DWORD   PX_PROCESS_FAULT_COUNT;
DWORD   PX_PROCESS_PAGED_POOL_QUOTA;
DWORD   PX_PROCESS_PEAK_PAGED_POOL_QUOTA;
DWORD   PX_PROCESS_NONPAGED_POOL_QUOTA;
DWORD   PX_PROCESS_PEAK_PAGED_POOL;
DWORD   PX_PROCESS_PEAK_NONPAGED_POOL;
DWORD   PX_PROCESS_CUR_PAGED_POOL;
DWORD   PX_PROCESS_CUR_NONPAGED_POOL;
DWORD   PX_PROCESS_PAGED_POOL_LIMIT;
DWORD   PX_PROCESS_NONPAGED_POOL_LIMIT;


DWORD   PX_THREAD;
DWORD   PX_THREAD_CPU;
DWORD   PX_THREAD_PRIV;
DWORD   PX_THREAD_USER;
DWORD   PX_THREAD_START;
DWORD   PX_THREAD_SWITCHES;
DWORD   PX_THREAD_PRIO;
DWORD   PX_THREAD_BASE_PRIO;
DWORD   PX_THREAD_ELAPSE;

DWORD   PX_THREAD_DETAILS;
DWORD   PX_THREAD_PC;

DWORD   PX_IMAGE;
DWORD   PX_IMAGE_NOACCESS;
DWORD   PX_IMAGE_READONLY;
DWORD   PX_IMAGE_READWRITE;
DWORD   PX_IMAGE_WRITECOPY;
DWORD   PX_IMAGE_EXECUTABLE;
DWORD   PX_IMAGE_EXE_READONLY;
DWORD   PX_IMAGE_EXE_READWRITE;
DWORD   PX_IMAGE_EXE_WRITECOPY;


DWORD   PX_PROCESS_ADDRESS_SPACE;
DWORD   PX_PROCESS_PRIVATE_NOACCESS;
DWORD   PX_PROCESS_PRIVATE_READONLY;
DWORD   PX_PROCESS_PRIVATE_READWRITE;
DWORD   PX_PROCESS_PRIVATE_WRITECOPY;
DWORD   PX_PROCESS_PRIVATE_EXECUTABLE;
DWORD   PX_PROCESS_PRIVATE_EXE_READONLY;
DWORD   PX_PROCESS_PRIVATE_EXE_READWRITE;
DWORD   PX_PROCESS_PRIVATE_EXE_WRITECOPY;


DWORD   PX_PROCESS_MAPPED_NOACCESS;
DWORD   PX_PROCESS_MAPPED_READONLY;
DWORD   PX_PROCESS_MAPPED_READWRITE;
DWORD   PX_PROCESS_MAPPED_WRITECOPY;
DWORD   PX_PROCESS_MAPPED_EXECUTABLE;
DWORD   PX_PROCESS_MAPPED_EXE_READONLY;
DWORD   PX_PROCESS_MAPPED_EXE_READWRITE;
DWORD   PX_PROCESS_MAPPED_EXE_WRITECOPY;


DWORD   PX_PROCESS_IMAGE_NOACCESS;
DWORD   PX_PROCESS_IMAGE_READONLY;
DWORD   PX_PROCESS_IMAGE_READWRITE;
DWORD   PX_PROCESS_IMAGE_WRITECOPY;
DWORD   PX_PROCESS_IMAGE_EXECUTABLE;
DWORD   PX_PROCESS_IMAGE_EXE_READONLY;
DWORD   PX_PROCESS_IMAGE_EXE_READWRITE;
DWORD   PX_PROCESS_IMAGE_EXE_WRITECOPY;


