/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***********************************************************************
**
**         CUSTOMER SERVICE SYSTEM CSR MAP GENERATOR MODULE
**
**
**  FILENAME          : VERSION.C
**
**  DESCRIPTION       : CSR Map Generator Function CsrMapReadMapFile
**
**  DATE CREATED      : 08/11/94
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  08/11/94    C. Crampton                Baseline
**  11/15/96    cwoods                     PTF-A - Added check for DteIntUsage='V'
***********************************************************************/
#define  INCL_WIN
#define  INCL_DOS
#define CMN_ERR_ARCH_WRAP_FUNC FALSE

#ifdef FND_WIN32
#define WINDOWMOD
#include <windows.h>
#endif
#ifdef FND_OS2
#include <os2.h>
#endif
#include <string.h>
#include <stdio.h>
#include <float.h>
#include <limits.h>
#include <stdlib.h>
#include <malloc.h>
#include <ctype.h>
#include <stdarg.h>
#include <time.h>


#define  FND_FE_INCL
#define  FND_IM_INCL
#define  FND_EH_INCL
#define  FND_PS_INCL
#define  FND_CF_INCL
#define  FND_CTCONV_INCL
/*mdc not in others
#define  FND_VERSION2
*/

#ifdef FND_OS2
#include <kglzk000.h>
#endif
#ifdef FND_WIN32
#include <kglxk000.h>
#endif


#include "version.h"
/*mdc 01-11-96 - Already included in version.h
#include <azrp001m.h>
*/
/*mdc 03/25/96 Already included in azcs01b.gnb
#include "csrcmn.h"
#include "mapgen.h"
*/
#include "azcs01b.gnb"
#include "AZCS003.GNH"

#include <C1CEAB.H>
#define INCL_C1CBASE
#include <c1c.h>



SHORT BuildVersionNumber (_ENTITYDATA *pEntityData, USHORT nRows,
                     double *pVersion)
{
    USHORT   i, j, nTypeVal;
	ULONG  nLenPrecisOcc;
    LONG    nCharSum;
    double  dSubTotal, dLineTotal;

    for (i=0, dSubTotal=0; i<nRows; i++)
    {
        /*
        |   Cleanup datafields being used
        */
        StrTrimTrailBlanks ((pEntityData+i)->EntityCobolName,
                            sizeof ((pEntityData+i)->EntityCobolName));

		StrTrimTrailBlanks ((pEntityData+i)->EntityType,
                            sizeof ((pEntityData+i)->EntityType));

        StrTrimTrailBlanks ((pEntityData+i)->DteIntUsage,
                            sizeof ((pEntityData+i)->DteIntUsage));

        /*
        |   Determine the total character value of the COBOL name
        */
        for (j=0, nCharSum=0;
             j<strlen((pEntityData+i)->EntityCobolName);
             j++)
        {
            nCharSum += (pEntityData+i)->EntityCobolName[j];
        }

        /*
        |   Dependent upon the entity type, get either the ocurrances
        |       of the entity or the length and precision.
        |       Also determine the element type if an element
        */
        if ((strcmp ((pEntityData+i)->EntityType, "DERECORD") == 0)
             ||
            (strcmp ((pEntityData+i)->EntityType, "DEGROUP") == 0))
        {
            nTypeVal = AZVS01_USAGE_GROUP;
            if ((!strcmp ((pEntityData+i)->EntityType, "DERECORD"))
                ||
                ((pEntityData+i)->RelatOccFact < 1))
            {
                nLenPrecisOcc = 1;
            }
            else
            {
                nLenPrecisOcc = (pEntityData+i)->RelatOccFact;
            }
        }
        else
        {
            nLenPrecisOcc =
             (((pEntityData+i)->RelatOccFact < 1)
                    ? 1 : (pEntityData+i)->RelatOccFact)
                          + (pEntityData+i)->DteIntLength
                          + (pEntityData+i)->DteIntPrecision;

            if (!strcmp ((pEntityData+i)->DteIntUsage, ""))
            {
                nTypeVal = AZVS01_USAGE_GROUP;
            }
            else if (!strcmp ((pEntityData+i)->DteIntUsage, "D"))
            {
                nTypeVal = AZVS01_USAGE_DISPLAY;
            }
            else if (!strcmp ((pEntityData+i)->DteIntUsage, "C"))
            {
                nTypeVal = AZVS01_USAGE_COMP;
            }
            else if (!strcmp ((pEntityData+i)->DteIntUsage, "C3"))
            {
                nTypeVal = AZVS01_USAGE_COMP3;
            }
            /* CWOODS 11/15/96:  PTF-A Rollout.  Added check for DteIntUsage = "V" */
            else if ((!strcmp ((pEntityData+i)->DteIntUsage, "DT")) ||

                     ( ((pEntityData+i)->DteTypeCode == 'D') &&
                       (!strcmp ((pEntityData+i)->DteIntUsage, "V")) 
                     )
                    )
            {
                nTypeVal = AZVS01_USAGE_DATE;
            }
            else if (!strcmp ((pEntityData+i)->DteIntUsage, "TM"))
            {
                nTypeVal = AZVS01_USAGE_TIME;
            }
            else if (!strcmp ((pEntityData+i)->DteIntUsage, "DS"))
            {
                nTypeVal = AZVS01_USAGE_DISP_SIGNED;
            }
            else if (!strcmp ((pEntityData+i)->DteIntUsage, "F2"))
            {
                nTypeVal = AZVS01_USAGE_DBL_PRECIS;
            }
            else if (!strcmp ((pEntityData+i)->DteIntUsage, "FL"))
            {
                nTypeVal = AZVS01_USAGE_FLOAT_PT;
            }
            else if (!strcmp ((pEntityData+i)->DteIntUsage, "TS"))
            {
                nTypeVal = AZVS01_USAGE_TIME_STAMP;
            }
            else if (!strcmp ((pEntityData+i)->DteIntUsage, "V"))
            {
                nTypeVal = AZVS01_USAGE_VARIABLE;
            }
            else
            {
                nTypeVal = 99;
            }
        }

        /*
        |   Create Line total.
        */
        dLineTotal = ((i + 1)
                         *
                     (nCharSum % 1000)
                         *
                     (nLenPrecisOcc)
                         *
                     (nTypeVal));

        /*
        |   Add the subtotal
        */
        dSubTotal += dLineTotal;
    }

    /*
    |   return the version number
    */
    *pVersion = dSubTotal;

    return (0);
}



SHORT StrTrimTrailBlanks (char *Target, USHORT nSize)
{
    SHORT i;
	/*char *s;*/

    /*
    |   Set the last position of the target to null
    */
    Target[nSize - 1] = 0;
	/*s = Target;

	while ((! isspace(*s)) && (*s != '\0')) ++s; 
	*s = '\0';*/

    
    /*   Scan backwards replacing spaces with nulls until the first
    |       non-null character is encountered.
    */
    for (i = (nSize - 2);
         ((i >= 0)
           &&
          ((Target[i] == ' ')
            ||
           (Target[i] == 0)));
         i--)
    {
        if (Target [i] == ' ')
        {
            Target [i] = 0;
        }
    } 

    return (0);
}
