//----------------------------------------------------------
//
// OVERVIEW
// 
// This is the shell file for creating an Application Gateway 
// Server ( AGS ) client.  There are three main sections for 
// each function used by the AGS.  Commented in this file 
// are explanations of what each section functionally 
// accomplishes and code examples.  
//
// Following is a brief explanation of each section:
//		Section 1: manipulate collected data from source and 
//                 populate service input copybook
//		Section 2: make DS call
//		Section 3: collect service output copybook data and
//                 return to source
//
// References:
//		Application Gateway Server:
//			k:\tech\arch\client\word\ags.doc
//		AZGS03:
//			STD-DSGN 332-10  - ApplGsTag Design Overview
//			STD-TECH 332-102 - ApplGsTagInitTvList
//			STD-TECH 332-104 - ApplGsTagBuildTvList
//			STD-TECH 332-106 - ApplGsTagGetTvPair
//			STD-TECH 332-108 - ApplGsTagSetTvPair
//			STD-TECH 332-110 - ApplGsTagBuildTvStr
//
// REMOVE THIS COMMENT BLOCK WHEN FINISHED
//
//----------------------------------------------------------

#include "cug< ff >< nn >.h"
/**************************************************************************
/* FUNCTION:        CUG< ff >< desc >< version >
/*
/* DESCRIPTION:     this function supports <  >. it uses a
/*                  set of Tag-Value utility functions to input and output
/*                  data.  CUG< ff >< desc >< version > populates the input 
/*                  copybook and calls the < service type > service.  the 
/*                  tag-value function are then used to build an output tag-
/*                  value string from the output copybook. 
/*		    
/* INPUTS:          pInData
/*                      pointer to the input data.  the data has been
/*                      allocated in the Application Gateway Server (AGS).  
/*                  InLength
/*                      length of the input data.  the parameter is being 
/*                      passed from the Application Gateway Server < , but
/*                      this function does not use the value >.
/*
/* OUTPUTS:         ppOutData
/*                      pointer to the output data. the ppOutData points to 
/*                      the Tag-Value string build in ApplGsTagBuildTvList.  
/*                  pOutLength
/*                      pointer to the output length.  pOutLength is set to
/*                      1 + strlen of the tv string built in 
/*                      ApplGsTagBuildTvList.
/*
/* FUNCTION CALLS:  ApplGsTagInitTvList
/*                      initialize tvlist.
/*                  ApplGsTagBuildTvList
/*                      add initial tvpairs to tvlist from incoming data.
/*                  ApplGsTagGetTvPair
/*                      retrieve a value associated with a tag from a tvlist.
/*                  ApplGsTagSetTvPair
/*                      add a new tvpair to the tvlist.
/*                  BuildTvString
/*                      build output string from all tvpairs in the tvlist
/*                  ApplGsMsgDS
/*                      makes the actual service call.
/*                  ApplGsGetDsRc
/*                      return most serious error message from either message
/*                      parm block or error parm block
/*                  < ApplGsTagBuildTvString
/*                      changes (YYYY-MM-DD) to (MM-DD-YYYY) >
/*
/* AUTHOR:          < >
/*
/* DATE CREATED:    < >
/*
/* REVISION HISTORY
/*
/* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
/* --------  ----------  -----  -------------------------------------------
/* < >       < >                original code.
/*
/*************************************************************************/
int CUG< ff >< desc >< version >( void *pInData,    long InLength, 
                                  void **ppOutData, long *pOutLength )
{
	
	/* local variables */
	int		    rc = 0;	
	DS_PARMS	DsParms;
	TVLIST		TvList;
	< input copybook i.e. CUCR091I >
	< output copybook i.e. CUCR091O >
		
	/* init data structure */
	memset( &DsParms,  0, sizeof( DS_PARMS ));
	memset( &< input copybook >,  0, sizeof( < input copybook > ));
	memset( &< output copybook >, 0, sizeof( < output copybook > ));

	/* initialize tvlist */
	ApplGsTagInitTvList( &TvList );
		
	/* build tvlist from input data string */
	ApplGsTagBuildTvList(( char * )pInData, &TvList );
	
	//----------------------------------------------------------
	//
	// SHELL INSTRUCTIONS: SECTION 1
	// 
	// use ApplGsTagGetTvPair to populate the input copybook fields
	// needed to make the service call.  these fields are usually
	// the keys to the service.
	//
	// REMOVE THIS COMMENT BLOCK WHEN FINISHED
	//
	//----------------------------------------------------------
	
	//----------------------------------------------------------
	//
	// EXAMPLES for SECTION 1:
	//
	//	  /* set input copybook values */
	//    ApplGsTagGetTvPair( "KyBa",			  
	//	                      &CUCR091I.StandardHeader.StndrdHeadSubgrp.KyBa
	//	                      DATA_TYPE_DOUBLE, 
	//		                  &TvList ); 
	//
	//    ApplGsTagGetTvPair( "KySsn",          
    //                        &CUCR091I.HdrCUMRE001.KySsn,
    //                        DATA_TYPE_LONG,   
    //                        &TvList ); 
	//
	//    ApplGsTagGetTvPair( "TxHomeAcd",      
	//	                      CUCR091I.HdrCUMRE001.TxHomeAcd,
	//		                  DATA_TYPE_STRING, 
	//				          &TvList ); 
	//
	//    ApplGsTagGetTvPair( "TxHomePhnNo",    
	//	                      CUCR091I.HdrCUMRE001.TxHomePhnNo,
	//		                  DATA_TYPE_STRING, 
	//				          &TvList );
	//
	// REMOVE THIS COMMENT BLOCK WHEN FINISHED	
	//
	//---------------------------------------------------------


	//----------------------------------------------------------
	//
	// SHELL INSTRUCTIONS: SECTION 2
	// 
	// this section is used to set up Distribution Services to
	// make you service call.  All service specific information
	// is stored is the DsParms structure and passed into
	// ApplGsMsgDS.  This function will use DsParms to populate
	// the service-specific areas of MsgPB and will use default
	// information for the generic areas.
	//
	// REMOVE THIS COMMENT BLOCK WHEN FINISHED
	//
	//----------------------------------------------------------

	//----------------------------------------------------------
	//
	// EXAMPLES for SECTION 2:
	//
	//	/* setup DsParms */
	//	DsParms.appl = 1091;
	//  DsParms.srvc = 1091;
	//  DsParms.buffer_size = sizeof( _CUCR091I );
	//  DsParms.actual_length_send = sizeof( _CUCR091I );
	//  strcpy(	CUCR091I.StandardHeader.CdFuncId, "01" );
	//  strncpy( DsParms.service_ver, "01", _VER_LEN );
	//  strncpy( DsParms.map_version, "01", _VER_LEN );
	//  strncpy( DsParms.map_name, "CUCR091I",_FND_MAP_NAME_LEN );
	//
	// REMOVE THIS COMMENT BLOCK WHEN FINISHED
	//
	//----------------------------------------------------------
 	
	
	/* call ds */
	ApplGsMsgDS( &DsParms, &< input copybook >, &< output copybook > );

	//----------------------------------------------------------
	//
	// SHELL INSTRUCTIONS: SECTION 3
	// 
	// this section is used to pull data from the output copybook
	// into the tag-value list.  any special formatting required
	// by the front-end should also be done in this section.
	//
	// if you do not want the input data concatenated with the 
	// output data, call ApplGsTagInitTvList to reinitialize the
	// TvList.
	//
	// use ApplGsGetDsRc() to get the return code from the service.
	// you can include/exclude logic based on ApplGsGetDsRc's 
	// return code.
	//
	// REMOVE THIS COMMENT BLOCK WHEN FINISHED
	//
	//----------------------------------------------------------

	//----------------------------------------------------------
	//
	// EXAMPLES for SECTION 3:
	//
	//	/* reinitialize tvlist */
	//	ApplGsTagInitTvList( &TvList );
	//
	//	/* add return code to tag-value list */
	//  rc = ApplGsGetDsRc( &DsParms );
	//  ApplGsTagSetTvPair( "rc",           
    //                      &rc,
    //                      DATA_TYPE_SHORT,  
    //                      &TvList );
	//  if( !rc )
	//  {
	//		/* use ApplGsTagSetTvPair to build tvpair structures */
	//		ApplGsTagSetTvPair( "AtPmt",
	//			                &CUCR091O.HdrCU0205F.AtPmt,
	//				            DATA_TYPE_DOUBLE, 
	//							&TvList );
	//
	//		ApplGsTagSetTvPair( "CdCo",
	//						    &CUCR091O.HdrCUMRE001.CdCo,
	//							DATA_TYPE_SHORT,  
	//							&TvList );
	//
	//		ApplGsDateWeb( DateWrk, CUCR091O.HdrCU0205F.DtCash ); 
	//		ApplGsTagSetTvPair( "DtCash",
	//			                DateWrk,
	//				            DATA_TYPE_STRING, 
	//							&TvList );
	//	}
	//
	// REMOVE THIS COMMENT BLOCK WHEN FINISHED
	//
	//----------------------------------------------------------

	/* build tag-value string from tag-value list */
	ApplGsTagBuildTvString( &TvList, 
		                    ppOutData, 
							pOutLength );

	return rc;
}

