/***********************************************************************
**
**                  CUSTOMER SERVICE SYSTEM CSR MODULE
**
**
**  FILENAME          : TABLOAD.C
**
**  DESCRIPTION       : LOADS MESSAGE FILES WITH SPUFI DATA FOR TAB
**
**  FUNCTIONS         :
**
**  DATE CREATED      : 08/19/94
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  08/19/94    ERIC RAS                   Original File.
**
**  08/25/94    ABURDEN                    Added Starting Message Number
**                                         & Logic for Checking Function
**                                         CODE of Input Message
**
************************************************************************/  

        	                /************************************************
				            **
				            **   CUCL005I - CUCC01
				            **
				            *************************************************/
                            #include "CUCL005I.H"

                            if ( strncmp( MsgPB.translation.map_name, "CUCL005I", 8 ) == 0 )
				            {
					            _CUSTCNTCLUWINPUT *pCUCL005I;
					            pCUCL005I = (_CUSTCNTCLUWINPUT * ) pMessage;

					            sscanf( Value, "%ld", 
					            &((_CUSTCNTCLUWINPUT * )pMessage)->
                                StandardHeader.StndrdHeadSubgrp.KyCustNo);

					            ((_CUSTCNTCLUWINPUT * )pMessage)->KCu03Tb18.KyCustNo=
					            ((_CUSTCNTCLUWINPUT * )pMessage)->
                                StandardHeader.StndrdHeadSubgrp.KyCustNo;

					            ((_CUSTCNTCLUWINPUT * )pMessage)->KCu03Tb06.KyCustNo=
					            ((_CUSTCNTCLUWINPUT * )pMessage)->
                                StandardHeader.StndrdHeadSubgrp.KyCustNo;

                            
                            }

        	                /************************************************
				            **
				            **   CUCR031C - CUCL11
				            **
				            *************************************************/
                            #include "CUCR031C.H"

                            if ( strncmp( MsgPB.translation.map_name, "CUCR031C", 8 ) == 0 )
				            {
					            _CUCR031C *pCUCR031C;
					            pCUCR031C = (_CUCR031C * ) pMessage;

					            sscanf( Value, "%d %s", 
					            &((_CUCR031C * )pMessage)->
                                MainCollectionGroup.HdrCollection.HdrCU0246C.CdCo,

					            &((_CUCR031C * )pMessage)->
                                MainCollectionGroup.HdrCollection.HdrCU0246C.CdOperCntr);
                            
                            }
        	               
                            /************************************************
				            **
				            **   CUCR031A - CUCL11
				            **
				            *************************************************/
                            #include "CUCR031A.H"

                            if ( strncmp( MsgPB.translation.map_name, "CUCR031A", 8 ) == 0 )
				            {
					            _CUCR031A *pCUCR031A;
					            pCUCR031A = (_CUCR031A * ) pMessage;

					            sscanf( Value, "%d %s", 
					            &((_CUCR031A * )pMessage)->
                                MainCutlistGroup.HdrCutlist.HdrCu0246A.CdCo,

					            &((_CUCR031A * )pMessage)->
                                MainCutlistGroup.HdrCutlist.HdrCu0246A.CdOperCntr);
                            
                            }

                            /**************************************************************
				            **
				            **   CUCL009I - CUBI43 - Update Duplicate Bill
				            **
				            **************************************************************/
                            #include "CUCL009I.H"

                            if ( strncmp( MsgPB.translation.map_name, "CUCL009I", 8 ) == 0 )
				            {
					            _CUCL009X *pCUCL009X;
					            pCUCL009X = (_CUCL009X * ) pMessage;

					            sscanf( Value, "%lf %ld %s %s %l %c",
					            &((_CUCL009X * )pMessage)->HdrCUBI01A.KyBa,
					            &((_CUCL009X * )pMessage)->HdrCU0201U.KyCustNo,
					            &((_CUCL009X * )pMessage)->HdrCU1403X.CdBillType,
					            &((_CUCL009X * )pMessage)->HdrCU1403X.DtBill,
					            &((_CUCL009X * )pMessage)->HdrCU1403X.QyBillSeqNo,
					            &((_CUCL009X * )pMessage)->HdrCU1403X.QyRunSeqNo);

					            strcpy(((_CUCL009X * )pMessage)->HdrCUBI01A.DtBill,
					            ((_CUCL009X * )pMessage)->HdrCU1403X.DtBill);

					            strcpy(((_CUCL009X * )pMessage)->HdrCUBI01A.DtBill,
					            ((_CUCL009X * )pMessage)->HdrCU1201A.DtBill);

					            ((_CUCL009X * )pMessage)->HdrCU0201X.KyBa=
					            ((_CUCL009X * )pMessage)->HdrCUBI01A.KyBa;

					            ((_CUCL009X * )pMessage)->HdrCU0201U.KyBa=
					            ((_CUCL009X * )pMessage)->HdrCUBI01A.KyBa;

					            ((_CUCL009X * )pMessage)->HdrCU1403X.KyBa=
					            ((_CUCL009X * )pMessage)->HdrCUBI01A.KyBa;

					            ((_CUCL009X * )pMessage)->HdrCU1201A.KyBa=
					            ((_CUCL009X * )pMessage)->HdrCUBI01A.KyBa;

					            strcpy(((_CUCL009X * )pMessage)->HdrCU1403X.CdBillType,
					            ((_CUCL009X * )pMessage)->HdrCU1201A.CdBillType);

					            ((_CUCL009X * )pMessage)->HdrCU1202B.KyBa=
					            ((_CUCL009X * )pMessage)->HdrCUBI01A.KyBa;

					            ((_CUCL009X * )pMessage)->HdrCU0301B.KyCustNo=
					            ((_CUCL009X * )pMessage)->HdrCU0201U.KyCustNo;

					            ((_CUCL009X * )pMessage)->HdrCU1201A.QyBillSeqNo=
					            ((_CUCL009X * )pMessage)->HdrCU1403X.QyBillSeqNo;

					            ((_CUCL009X * )pMessage)->HdrCU1201A.QyRunSeqNo=
					            ((_CUCL009X * )pMessage)->HdrCU1403X.QyRunSeqNo;
                       }


                            /**************************************************************
				            **
				            **   CUCR023I - CUAR02 - View Outstanding Money
				            **
				            **************************************************************/
                            #include "CUCR023I.H"

                            if ( strncmp( MsgPB.translation.map_name, "CUCR023I", 8 ) == 0 )
				            {
					            _CUCR023I *pCUCR023I;
					            pCUCR023I = (_CUCR023I * ) pMessage;

					            sscanf( Value, "%lf %ld %ld",
					            &((_CUCR023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
					            &((_CUCR023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo,
					            &((_CUCR023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo);
                           }

        		            
                            /**************************************************************
				            **
				            **   CUCR001I - CUAR02 - View Outstanding Money
				            **
				            **************************************************************/
                            #include "CUCR001I.H"

                            if ( strncmp( MsgPB.translation.map_name, "CUCR001I", 8 ) == 0 )
				            {
					            _CUCR001I *pCUCR001I;
					            pCUCR001I = (_CUCR001I * ) pMessage;

					            sscanf( Value, "%lf",
					            &((_CUCR001I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa);
                           }

    			            /************************************************
				            **
				            **   CUCR001 - RETRIEVAL (CURE01) (ABURDEN)
				            **
				            *************************************************/
                
                            #include "CUCR001I.H"
                    
                            if ( strncmp( MsgPB.translation.map_name, "CUCR001I", 8 ) == 0 )
				            {
                                _CUCR001I *pCUCR001I;
				                pCUCR001I = (_CUCR001I * ) pMessage;
					            
                                // Bill Account Retrieval (Uncomment to activate)
					            /* 
                                ** The sscanf function did not work due to a runtime error
                                ** dealing with floating points. Use TempKyBa instead.
                                **/
                                ////sscanf( Value, "%lf", &((_CUCR001I * )pMessage)->RetrKeys1.KyBa );
                    
                                //CurrentKyBa = atof(Value);

                                //((_CUCR001I * )pMessage)->RetrKeys1.KyBa = CurrentKyBa;

                                // Retrieval by Phone Number (Uncomment to activate)
					            sscanf( Value, "%s %s", &((_CUCR001I * )pMessage)->RetrKeys1.TxHomeAcd,
                                                        &((_CUCR001I * )pMessage)->RetrKeys1.TxHomePhnNo);

					            
                                // CUCR001 Retrieval for CUEL01 ISSUE ELECTRIC OUTAGE (UNCOMMENT TO ACTIVATE)
			  		            //if ( strncmp (lfunctioncode, "02", 8) == 0 )
			    	            //{
			     	            //	sscanf( Value, "%ld %ld",
			     	            //	&((_CUCR001I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
			     	            //	&((_CUCR001I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremCust);
                	            //}

					            // Name Retrieval (Uncomment to Activate)
                                i = 0;
                                j = 0;

                                memset(Name, 0, sizeof(Name));
                                memset(FinalName, 0, sizeof(FinalName));

					            token = strtok( Value, " ," );

                                while( token != NULL )
                                {
                                    strcpy(Name[i], token);
                                    
                                        /* Get next token: */
					                token = strtok( NULL, " ," );
                                
                                    i++;

                                } /* end while loop */

                                for(j = 0; j < (i-1); j++)
                                {
                                    strcat(FinalName, Name[j]);
                                    strcat(FinalName, " ");
                                }

                                FinalName[(strlen(FinalName) - 1)] = 0;
					            
                                strcpy(((_CUCR001I * )pMessage)->RetrKeys1.NmCompressed, FinalName);
                                ((_CUCR001I * )pMessage)->RetrKeys1.CdCo = atoi(Name[i-1]);
                                // end of retrieval by name

					            // Address Retrieval (Uncomment to Activate)
					            //sscanf( Value, "%s %s %s %ld",
                                //    AddressStr1, AddressStr2, AddressStr3,
                                //    &((_CUCR001I * )pMessage)->RetrKeys1.CdCo);

                                //sprintf(Address, "%s %s %s", AddressStr1, AddressStr2, AddressStr3);
                                
                                //strcpy(((_CUCR001I * )pMessage)->RetrKeys1.AdCompressed, Address);
				            }


    			            /************************************************
				            **
				            **   CUCR001 - RETRIEVAL (CUMR05,) 
				            **
				            *************************************************/
                
                            #include "CUCR001I.H"
                
                            if ( strncmp( MsgPB.translation.map_name, "CUCR001I", 8 ) == 0 )
				            {
                                _CUCR001I *pCUCR001I;
				                pCUCR001I = (_CUCR001I * ) pMessage;
					            
			     	            sscanf( Value, "%ld", &((_CUCR001I * )pMessage)->StandardHeader.
                                                                     StndrdHeadSubgrp.KyCustNo );

				            }

    			            /************************************************
				            **
				            **   CUCR068 - RETRIEVAL (CUOB54) 
				            **
				            *************************************************/
                
                            #include "CUCR068I.H"
                
                            if ( strncmp( MsgPB.translation.map_name, "CUCR068I", 8 ) == 0 )
				            {
                                _CUCR068I *pCUCR068I;
				                pCUCR068I = (_CUCR068I * ) pMessage;
					            
			     	            sscanf( Value, "%s %s", 
                                &((_CUCR068I * )pMessage)->HdrCUOB54.CdLocationType,
                                &((_CUCR068I * )pMessage)->HdrCUOB54.KyLocationId );

				            }

    			            /************************************************
				            **
				            **   CUCR038 - RETRIEVAL (CUOB62) 
				            **
				            *************************************************/
                
                            #include "CUCR038I.H"
                
                            if ( strncmp( MsgPB.translation.map_name, "CUCR038I", 8 ) == 0 )
				            {
                                _CUCR038I *pCUCR038I;
				                pCUCR038I = (_CUCR038I * ) pMessage;
					            
			     	            sscanf( Value, "%ld %ld %ld %s %s %s %ld %s", 
                                &((_CUCR038I * )pMessage)->HdrCU0449A.KyPremNo,
                                &((_CUCR038I * )pMessage)->HdrCU0449A.KySpt,
                                &((_CUCR038I * )pMessage)->HdrCU0449A.KyMptNo,
                                &((_CUCR038I * )pMessage)->HdrCU0449A.KyMtrEquipNo,
                                &((_CUCR038I * )pMessage)->HdrCU0449A.CdMtrEquipMfgr,
                                &((_CUCR038I * )pMessage)->HdrCU0449A.DtEff,
                                &((_CUCR038I * )pMessage)->HdrCU0448A.KyRdg,
                                &((_CUCR038I * )pMessage)->HdrCU0448A.FlAltRdgs );

                                ((_CUCR038I * )pMessage)->HdrCU0448A.KyPremNo = 
                                ((_CUCR038I * )pMessage)->HdrCU0449A.KyPremNo;

                                ((_CUCR038I * )pMessage)->HdrCU0448A.KySpt =
                                ((_CUCR038I * )pMessage)->HdrCU0449A.KySpt;
                                
                                ((_CUCR038I * )pMessage)->HdrCU0448A.KyMptNo =
                                ((_CUCR038I * )pMessage)->HdrCU0449A.KyMptNo;
                                
                                strcpy (((_CUCR038I * )pMessage)->HdrCU0448A.KyMtrEquipNo,
                                ((_CUCR038I * )pMessage)->HdrCU0449A.KyMtrEquipNo);
                                
                                strcpy(((_CUCR038I * )pMessage)->HdrCU0448A.DtEff =
                                ((_CUCR038I * )pMessage)->HdrCU0449A.DtEff);
                                
                                ((_CUCR038I * )pMessage)->HdrCU0408G.KyRdg =
                                ((_CUCR038I * )pMessage)->HdrCU0448A.KyRdg;
                               

				            }


    			            /************************************************
				            **
				            **   CUCR001 -  (CUMC15) 
				            **
				            *************************************************/
                
                            #include "CUCR001I.H"
                
                            if ( strncmp( MsgPB.translation.map_name, "CUCR001I", 8 ) == 0 )
				            {
                                _CUCR001I *pCUCR001I;
				                pCUCR001I = (_CUCR001I * ) pMessage;
					            
			     	            sscanf( Value, "%lf %ld", 
                                    &((_CUCR001I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
                                    &((_CUCR001I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo );

				            }


    			            /************************************************
        		            **
        		            **   CUCR004I - CUBB04 - View Budget Bill History
        		            **
        		            *************************************************/
                            #include "CUCR004I.H"

				            if ( strncmp( MsgPB.translation.map_name, "CUCR004I", 8 ) == 0 )
           		            {

				                _CUCR004I *pCUCR004I;
				                pCUCR004I = (_CUCR004I * ) pMessage;

                                sscanf( Value, "%lf %ld",&((_CUCR004I * )pMessage)->HdrCU1201Q.KyBa,
            								             &((_CUCR004I * )pMessage)->HdrCU0454A.KyPremNo );
            
            		            ((_CUCR004I * )pMessage)->HdrCU0502B.KyBa =
            		            ((_CUCR004I * )pMessage)->HdrCU1201Q.KyBa;

            		            ((_CUCR004I * )pMessage)->HdrCU0524A.KyBa =
            		            ((_CUCR004I * )pMessage)->HdrCU1201Q.KyBa;

            		            ((_CUCR004I * )pMessage)->HdrCU0548D.KyBa =
            		            ((_CUCR004I * )pMessage)->HdrCU1201Q.KyBa;

            		            ((_CUCR004I * )pMessage)->HdrCU0550B.KyBa =
            		            ((_CUCR004I * )pMessage)->HdrCU1201Q.KyBa;

            		            ((_CUCR004I * )pMessage)->HdrCU0403O.KyPremNo =
            		            ((_CUCR004I * )pMessage)->HdrCU0454A.KyPremNo;
				            }


        		            /************************************************
        		            **
        		            **   CUCR001I - CUCC01
        		            **
        		            *************************************************/
                            #include "CUCR001I.H"

         		            if ( strncmp( MsgPB.translation.map_name, "CUCR001I", 8 ) == 0 )
           		            {
				                _CUCR001I *pCUCR001I;
				                pCUCR001I = (_CUCR001I * ) pMessage;
                    
			     		        sscanf( Value, "%ld", &((_CUCR001I * )pMessage)->StandardHeader.
                                                                    StndrdHeadSubgrp.KyCustNo );                	                                           

                            }

        		            /************************************************
        		            **
        		            **   CUCR008I - CUOB36, CUCC01
        		            **
        		            *************************************************/
                            #include "CUCR008I.H"

         		            if ( strncmp( MsgPB.translation.map_name, "CUCR008I", 8 ) == 0 )
           		            {
				                _CUCR008I *pCUCR008I;
				                pCUCR008I = (_CUCR008I * ) pMessage;
                    
                                /* Adding a customer contact */
                                if ( strncmp (lfunctioncode, "01", 8) == 0 )
			    	            {
			     		            sscanf( Value, "%ld", &((_CUCR008I * )pMessage)->StandardHeader.
                                                                        StndrdHeadSubgrp.KyCustNo );                	                                           
                    
                                }
              		            if ( strncmp (lfunctioncode, "07", 8) == 0 )
					            {
                  		            sscanf( Value, "%ld", &((_CUCR008I * )pMessage)->StandardHeader.
                                                                        StndrdHeadSubgrp.KyCustNo );
					            }

           		            }


    			            /**************************************************************
      			            **
      			            **   CUCR011I - CUGM29  MAINTAIN BILL ACCOUNT
      			            **
      			            **************************************************************/
                            #include "CUCR011I.H"

      			            if ( strncmp( MsgPB.translation.map_name, "CUCR011I", 8 ) == 0 )
           		            {
            		            _CUCR011I *pCUCR011I;
            		            pCUCR011I = (_CUCR011I * ) pMessage;

            		            sscanf( Value, "%lf %ld %ld %ld",
            		            &((_CUCR011I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
            		            &((_CUCR011I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqBa,
            		            &((_CUCR011I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
            		            &((_CUCR011I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo);

            		            ((_CUCR011I * )pMessage)->HdrCU0301B.KyCustNo =
                                    ((_CUCR011I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;
            		            
                                ((_CUCR011I * )pMessage)->HdrCU0201A.KyPremNo =
                                    ((_CUCR011I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo;

           		            }



    			            /**************************************************************
      			            **
      			            **   CUCR053I - CUGM10  MAINTAIN METER POINT
      			            **
      			            **************************************************************/
                            #include "CUCR053I.H"

      			            if ( strncmp( MsgPB.translation.map_name, "CUCR053I", 8 ) == 0 )
           		            {
            		            _CUCR053I *pCUCR053I;
            		            pCUCR053I = (_CUCR053I * ) pMessage;
                                
                                WriteFile = TRUE;

                                sscanf( Value, "%ld %ld %ld %s %s",
                                &CurrentKyPremNo,
            		            &((_CUCR053I * )pMessage)->HdrCU0449A.KySpt,
            		            &((_CUCR053I * )pMessage)->HdrCU0449A.KyMptNo,
            		            &((_CUCR053I * )pMessage)->HdrCU0449A.KyMtrEquipNo,
                                &((_CUCR053I * )pMessage)->HdrCU0449A.CdMtrEquipMfgr);


                               ((_CUCR053I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo =
                                   CurrentKyPremNo;

            		            ((_CUCR053I * )pMessage)->HdrCU0449A.KyPremNo =
                                    ((_CUCR053I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo;
            		            
                                strcpy(((_CUCR053I * )pMessage)->HdrMI700000.KyMtrEquipNo,
                                    ((_CUCR053I * )pMessage)->HdrCU0449A.KyMtrEquipNo);

                                strcpy(((_CUCR053I * )pMessage)->HdrCU0449A.DtEff,
                                    "1998-12-15");

                                if( CurrentKyPremNo == PreviousKyPremNo)
                                {
                                    WriteFile = FALSE;
                                }
                                
                                PreviousKyPremNo = CurrentKyPremNo;
                            
                            }



    			            /**************************************************************
      			            **
      			            **   CUCR108I - CUGM51  MAINTAIN BILL DETERMINANTS
                            **   CUCR108I - CUGM51  MAINTAIN COMPARATIVE RATES
      			            **
      			            **************************************************************/
                            #include "CUCR108I.H"

      			            if ( strncmp( MsgPB.translation.map_name, "CUCR108I", 8 ) == 0 )
           		            {
            		            _CUCR108I *pCUCR108I;
            		            pCUCR108I = (_CUCR108I * ) pMessage;

            		            sscanf( Value, "%lf %ld %ld %ld",
            		            &((_CUCR108I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
            		            &((_CUCR108I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo,
            		            &((_CUCR108I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
            		            &((_CUCR108I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqBa);

                            }
/******************************************************************************************
CUGM51 - CUCL065I
LUW MAINTAIN BILL DETERMINANTS / LUW MAINTAIN COMPARATIVE RATES
Begin
******************************************************************************************/
    			            /**************************************************************
      			            **
      			            **   CUCL065I - CUGM51  LUW MAINTAIN BILL DETERMINANTS
                            **   CUCL065I - CUGM51  LUW MAINTAIN COMPARATIVE RATES
      			            **
      			            **************************************************************/
                            #include "CUCL065I.H"

      			            if ( strncmp( MsgPB.translation.map_name, "CUCL065I", 8 ) == 0 )
           		            {
            		            _CUCL065I *pCUCL065I;
            		            pCUCL065I = (_CUCL065I * ) pMessage;

                                WriteFile = TRUE;

            		            sscanf( Value, "%lf %ld %ld %s %ld %ld %s %ld %s",
                                &CurrentKyBa,
            		            &((_CUCL065I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqBa,
                                &CurrentKyPremNo,
                                &((_CUCL065I * )pMessage)->DatOldTarType.CdTarType,
                                &CurrentKyCustNo,
                                &((_CUCL065I * )pMessage)->DatSpt[0].KySpt,
                                &((_CUCL065I * )pMessage)->DatSpt[0].CdSptType,
                                &((_CUCL065I * )pMessage)->DatSpt[0].NoLockSeqSpt,
                                &((_CUCL065I * )pMessage)->DatSpt[0].CdTarSch);

            		            ((_CUCL065I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa = CurrentKyBa;
                                ((_CUCL065I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo = CurrentKyPremNo;
                                ((_CUCL065I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo = CurrentKyCustNo;

                                strcpy( ((_CUCL065I * )pMessage)->DatSpt[0].DatSptRel[0].CdTarSch2,
                                    ((_CUCL065I * )pMessage)->DatSpt[0].CdTarSch);

                                if(( CurrentKyPremNo == PreviousKyPremNo) || 
                                   ( CurrentKyCustNo == PreviousKyCustNo) ||
                                   ( CurrentKyBa     == PreviousKyBa))
                                {
                                    WriteFile = FALSE;
                                }
                                
                                PreviousKyPremNo = CurrentKyPremNo;
                                PreviousKyCustNo = CurrentKyCustNo;
                                PreviousKyBa     = CurrentKyBa;

            		            
                            }
/******************************************************************************************
End
******************************************************************************************/


    			            /**************************************************************
      			            **
      			            **   CUCR011I - CUCS02  MAINTAIN CUSTOMER
      			            **
      			            **************************************************************/
                            #include "CUCR011I.H"

      			            if ( strncmp( MsgPB.translation.map_name, "CUCR011I", 8 ) == 0 )
           		            {
            		            _CUCR011I *pCUCR011I;
            		            pCUCR011I = (_CUCR011I * ) pMessage;

            		            sscanf( Value, "%ld %ld %s %s %ld",
            		            &((_CUCR011I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo,
                                &((_CUCR011I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqCust,
            		            &((_CUCR011I * )pMessage)->HdrCU0301A.CdCustType,
                                &((_CUCR011I * )pMessage)->HdrCU0301A.CdAdType,                                            		            
                                &((_CUCR011I * )pMessage)->HdrCU0301A.KyAd);

            		            ((_CUCR011I * )pMessage)->HdrCU0301B.KyCustNo = 
                                ((_CUCR011I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;
            		            
            		            ((_CUCR011I * )pMessage)->HdrCU0101Q.KyCustNo = 
                                ((_CUCR011I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;
            		            
            		            ((_CUCR011I * )pMessage)->HdrCU0301A.KyCustNo = 
                                ((_CUCR011I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;
            		            
            		            ((_CUCR011I * )pMessage)->HdrCU0313A.KyCustNo = 
                                ((_CUCR011I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;
            		            
            		            ((_CUCR011I * )pMessage)->HdrCU0319A.KyCustNo = 
                                ((_CUCR011I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;
            		            
                                strcpy( ((_CUCR011I * )pMessage)->HdrCU0301B.CdCustType, 
                                ((_CUCR011I * )pMessage)->HdrCU0301A.CdCustType);

           		            }

    			            /**************************************************************
      			            **
      			            **   CUCL007I - CUCS02  MAINTAIN CUSTOMER
      			            **
      			            **************************************************************/
                            #include "CUCL007I.H"

      			            if ( strncmp( MsgPB.translation.map_name, "CUCL007I", 8 ) == 0 )
           		            {
            		            _CUCL007I *pCUCL007I;
            		            pCUCL007I = (_CUCL007I * ) pMessage;

            		            sscanf( Value, "%lf %ld %s %s %ld",
            		            &((_CUCL007I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
                                &((_CUCL007I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
            		            &((_CUCL007I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo,
                                &((_CUCL007I * )pMessage)->HdrCU0301E.KySsn,                                            		            
                                &((_CUCL007I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KySpt);

            		            ((_CUCL007I * )pMessage)->HdrCUOCT070.KySsn = 
                                ((_CUCL007I * )pMessage)->HdrCU0301E.KySsn;
            		            
            		            ((_CUCL007I * )pMessage)->DatCU0313A[0].KySsn = 
                                ((_CUCL007I * )pMessage)->HdrCU0301E.KySsn;
            		            
            		            ((_CUCL007I * )pMessage)->HdrCU0307A.KyCustNo = 
                                ((_CUCL007I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;
            		            
            		            ((_CUCL007I * )pMessage)->HdrCU0201Z.KyCustNo = 
                                ((_CUCL007I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;
            		            
            		            ((_CUCL007I * )pMessage)->HdrCU1015A.KyCustNo = 
                                ((_CUCL007I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;
            		            
            		            ((_CUCL007I * )pMessage)->HdrCU0301E.KyCustNo = 
                                ((_CUCL007I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;
            		            
            		            ((_CUCL007I * )pMessage)->HdrCU0313A.KyCustNo = 
                                ((_CUCL007I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;
            		            
	                            ((_CUCL007I * )pMessage)->HdrCU0319A.KyCustNo = 
                                ((_CUCL007I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;
            		            
           		            }


    			            /**************************************************************
      			            **
      			            **   CUCR001I - CUCS02  MAINTAIN CUSTOMER
      			            **
      			            **************************************************************/
                            #include "CUCR001I.H"

      			            if ( strncmp( MsgPB.translation.map_name, "CUCR001I", 8 ) == 0 )
           		            {
            		            _CUCR001I *pCUCR001I;
            		            pCUCR001I = (_CUCR001I * ) pMessage;

            		            sscanf( Value, "%ld",
            		            &((_CUCR001I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo);

           		            }


    			            /************************************************
				            **
				            **   CUCR012A - CUBI36 - View Bill Image
				            **
				            *************************************************/
                            #include "CUCR012A.H"

				            if ( strncmp( MsgPB.translation.map_name, "CUCR012A", 8 ) == 0 )
				            {
					            _CUCR012A *pCUCR012A;
					            pCUCR012A = (_CUCR012A * ) pMessage;

					            sscanf( Value, "%lf %s %s %l %c",
					            &((_CUCR012A * )pMessage)->Layout1.HdrCU1403A.PkeyBillGraph.BillGraphKey.KyBa,
					            &((_CUCR012A * )pMessage)->Layout1.HdrCU1403A.PkeyBillGraph.BillGraphKey.CdBillType,
					            &((_CUCR012A * )pMessage)->Layout1.HdrCU1403A.PkeyBillGraph.BillGraphKey.DtBill,
					            &((_CUCR012A * )pMessage)->Layout1.HdrCU1403A.PkeyBillGraph.BillGraphKey.QyBillSeqNo,
					            &((_CUCR012A * )pMessage)->Layout1.HdrCU1403A.PkeyBillGraph.BillGraphKey.QyRunSeqNo);

					            ((_CUCR012A * )pMessage)->Layout1.HdrCU1202A.KEY_BILL_DTL.KeyBillHdr.KyBa =
					            ((_CUCR012A * )pMessage)->Layout1.HdrCU1403A.PkeyBillGraph.BillGraphKey.KyBa;

					            strcpy(((_CUCR012A * )pMessage)->Layout1.HdrCU1202A.KEY_BILL_DTL.KeyBillHdr.CdBillType,
					            ((_CUCR012A * )pMessage)->Layout1.HdrCU1403A.PkeyBillGraph.BillGraphKey.CdBillType);

					            strcpy(((_CUCR012A * )pMessage)->Layout1.HdrCU1202A.KEY_BILL_DTL.KeyBillHdr.DtBill,
					            ((_CUCR012A * )pMessage)->Layout1.HdrCU1403A.PkeyBillGraph.BillGraphKey.DtBill);

					            ((_CUCR012A * )pMessage)->Layout1.HdrCU1202A.KEY_BILL_DTL.KeyBillHdr.QyBillSeqNo =
					            ((_CUCR012A * )pMessage)->Layout1.HdrCU1403A.PkeyBillGraph.BillGraphKey.QyBillSeqNo;
				            }


    			            /************************************************
				            **
				            **   CUCR012B - CUBI43 - Update Duplicate Bill
				            **
				            *************************************************/
                            #include "CUCR012B.H"

				            if ( strncmp( MsgPB.translation.map_name, "CUCR012B", 8 ) == 0 )
				            {
					            _CUCR012B *pCUCR012B;

					            pCUCR012B = (_CUCR012B * ) pMessage;

					            sscanf( Value, "%lf %s %s %l %c",
					            &((_CUCR012B * )pMessage)->Lay012B.HdrCU1201DB.KyBillInfoHdr.KyBa,
					            &((_CUCR012B * )pMessage)->Lay012B.HdrCU1201DB.KyBillInfoHdr.CdBillType,
					            &((_CUCR012B * )pMessage)->Lay012B.HdrCU1201DB.KyBillInfoHdr.DtBill,
					            &((_CUCR012B * )pMessage)->Lay012B.HdrCU1201DB.KyBillInfoHdr.QyBillSeqNo,
					            &((_CUCR012B * )pMessage)->Lay012B.HdrCU1201DB.KyBillInfoHdr.QyRunSeqNo);


					            ((_CUCR012B * )pMessage)->Lay012B.HdrCU02018.PkeyBillAcct.KyBa =
					            ((_CUCR012B * )pMessage)->Lay012B.HdrCU1201DB.KyBillInfoHdr.KyBa;

					            ((_CUCR012B * )pMessage)->Lay012B.HdrCU1205A.PkeyBillRlsePerm.KeyBsSeq.KyBa =
					            ((_CUCR012B * )pMessage)->Lay012B.HdrCU1201DB.KyBillInfoHdr.KyBa;

					            ((_CUCR012B * )pMessage)->Lay012B.HdrCU1206B.KyBa =
					            ((_CUCR012B * )pMessage)->Lay012B.HdrCU1201DB.KyBillInfoHdr.KyBa;
                            }

                
                            /************************************************
      			            **
      			            **   CUCR022I
      			            **
      			            *************************************************/
                            #include "CUCR022I.H"

                            if ( strncmp( MsgPB.translation.map_name, "CUCR022I", 8 ) == 0 )
           		            {
					            _CUCR022I *pCUCR022I;
					            pCUCR022I = (_CUCR022I * ) pMessage;


            		            if ( strncmp (lfunctioncode, "05", 8) == 0 )
		      		            {
               			            sscanf( Value, "%lf", &((_CUCR022I * )pMessage)->HdrCU0539C.KyBa);

               			            ((_CUCR022I * )pMessage)->HdrCU0542B.KyBa =
               			            ((_CUCR022I * )pMessage)->HdrCU0539C.KyBa;

               			            ((_CUCR022I * )pMessage)->HdrCU0502D.KyBa =
               			            ((_CUCR022I * )pMessage)->HdrCU0539C.KyBa;

               			            ((_CUCR022I * )pMessage)->HdrCU0201O.KyBa =
               			            ((_CUCR022I * )pMessage)->HdrCU0539C.KyBa;

               			            ((_CUCR022I * )pMessage)->HdrCU0201C.KyBa =
               			            ((_CUCR022I * )pMessage)->HdrCU0539C.KyBa;
              		            }

            		            if ( strncmp (lfunctioncode, "06", 8) == 0 )
		      		            {
               			            sscanf( Value, "%lf %ld",&((_CUCR022I * )pMessage)->HdrCU0204D.KyBa,
               			            &((_CUCR022I * )pMessage)->HdrCU0204D.KyProdOrdno);

               			            ((_CUCR022I * )pMessage)->HdrCU0503B.KyBa =
               			            ((_CUCR022I * )pMessage)->HdrCU0204D.KyBa;

						            ((_CUCR022I * )pMessage)->HdrCU0503B.KyProdOrdno =
						            ((_CUCR022I * )pMessage)->HdrCU0204D.KyProdOrdno;

               			            ((_CUCR022I * )pMessage)->HdrCU0539C.KyBa =
               			            ((_CUCR022I * )pMessage)->HdrCU0204D.KyBa;

               			            ((_CUCR022I * )pMessage)->HdrCU0502D.KyProdOrdno =
               			            ((_CUCR022I * )pMessage)->HdrCU0204D.KyProdOrdno;
              		            }
				            }


                            /************************************************
				            **
				            **   CUCR030I - VIEW BILL DETAIL (ABURDEN)
				            **
				            *************************************************/
                            #include "CUCR030I.H"
				             
				            if ( strncmp( MsgPB.translation.map_name, "CUCR030I", 8 ) == 0 )
				            {
					            if ( strncmp (lfunctioncode, "02", 8) == 0 )
					            {
						            sscanf( Value, "%lf %s",
						            &((_CUCR030A * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
						            ((_CUCR030A * )pMessage)->Layout1.HdrCommnhdr.DtBill );
					            }
				            }

/******************************************************************************************
CUMR05 / CUOB16 - CUCR037I
HIGH BILL INQUIRY / Select Usage - Metered
Begin
******************************************************************************************/
                            /************************************************
        		            **
        		            **   CUCR037I - CUMR05 HIGH BILL INQUIRY
        		            **              CUOB16 Select Usage - Metered
        		            *************************************************/
                            #include "CUCR037I.H"
                
                            if ( strncmp( MsgPB.translation.map_name, "CUCR037I", 8 ) == 0 )
           		            {
            		            _CUCR037I *pCUCR037I;
            		            pCUCR037I = (_CUCR037I * ) pMessage;
           
		                        if ( strncmp (lfunctioncode, "01", 8) == 0 ) //CUMR05
					            {
              			            sscanf( Value, "%lf %ld %ld %ld %ld %ld %ld %ld",
               			            &((_CUCR037I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
						            &((_CUCR037I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo,
               			            &((_CUCR037I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
               			            &((_CUCR037I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KySpt,
                                    &((_CUCR037I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqBa,
                                    &((_CUCR037I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqPrem,
                                    &((_CUCR037I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqBaAim,
               			            &((_CUCR037I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqSpt);

                                    ((_CUCR037I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqCust = 0;
               			            ((_CUCR037I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqFoHdr = 0;
               		            }

             		            if ( strncmp (lfunctioncode, "02", 8) == 0 ) // CUOB16
              		            {
               			            sscanf( Value, "%lf %ld %ld",
               			            &((_CUCR037I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
						            &((_CUCR037I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
               			            &((_CUCR037I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KySpt );
					            }
           		            }

    			            /************************************************
				            **
				            **   CUCR038 - RETRIEVAL (CUPB01) 
				            **
				            *************************************************/
                            #include "CUCR038I.H"
                
                            if ( strncmp( MsgPB.translation.map_name, "CUCR038I", 8 ) == 0 )
				            {
                                _CUCR038I *pCUCR038I;
				                pCUCR038I = (_CUCR038I * ) pMessage;

                                WriteFile = TRUE;
					            
			     	            sscanf( Value, "%ld %s %s", 
                                &CurrentKyPremNo,
                                &((_CUCR038I * )pMessage)->HdrCU0621A.KyPwqWoId,
                                &((_CUCR038I * )pMessage)->HdrCU0621A.TsKyPwq );
                                
                                ((_CUCR038I * )pMessage)->HdrCU0449A.KyPremNo = CurrentKyPremNo;

                                if( CurrentKyPremNo == PreviousKyPremNo)
                                {
                                    WriteFile = FALSE;
                                }
                                
                                PreviousKyPremNo = CurrentKyPremNo;
				            }

    			            /************************************************
				            **
				            **   CUCR048I - CUPB01 
				            **
				            *************************************************/
                            #include "CUCR048I.H"
				             
				            if ( strncmp( MsgPB.translation.map_name, "CUCR048I", 8 ) == 0 )
				            {
					            if ( strncmp (lfunctioncode, "01", 8) == 0 )
					            {
                                    WriteFile = TRUE;

                                    sscanf( Value, "%ld %s %s %ld %lf",
                                    &CurrentKyPremNo,
                                    &((_CUCR048I * )pMessage)->HdrCU0621A.KyPwqWoId,
						            &((_CUCR048I * )pMessage)->HdrCU0621A.TsKyPwq,
                                    &((_CUCR048I * )pMessage)->HdrCU0457A.KyBldgNo,                                       
                                    &((_CUCR048I * )pMessage)->HdrCU0501B.KyBa);

                                    ((_CUCR048I * )pMessage)->HdrCU04498.KyPremNo = CurrentKyPremNo;

						            ((_CUCR048I * )pMessage)->HdrCU0403I_2.KyPremNo =
						            ((_CUCR048I * )pMessage)->HdrCU04498.KyPremNo;

						            ((_CUCR048I * )pMessage)->HdrCU0449D.KyPremNo =
						            ((_CUCR048I * )pMessage)->HdrCU04498.KyPremNo;

						            ((_CUCR048I * )pMessage)->HdrCU0449N.KyPremNo =
						            ((_CUCR048I * )pMessage)->HdrCU04498.KyPremNo;

						            ((_CUCR048I * )pMessage)->HdrCU0401B.KyPremNo =
						            ((_CUCR048I * )pMessage)->HdrCU04498.KyPremNo;

						            ((_CUCR048I * )pMessage)->HdrCU0403I.KyPremNo =
						            ((_CUCR048I * )pMessage)->HdrCU04498.KyPremNo;

                                    if( CurrentKyPremNo == PreviousKyPremNo)
                                    {
                                        WriteFile = FALSE;
                                    }
                                
                                    PreviousKyPremNo = CurrentKyPremNo;

					            }
				            }

    			            /************************************************
				            **
				            **   CUCL039I - CUPB01 
				            **
				            *************************************************/
                            #include "CUCL039I.H"
				             
				            if ( strncmp( MsgPB.translation.map_name, "CUCL039I", 8 ) == 0 )
				            {
                                WriteFile = TRUE;
                                
                                sscanf( Value, "%ld %ld %s %ld %ld %s %s %ld %lf",
                                &((_CUCL039I * )pMessage)->HdrCU0403B.KySpt,                                       
                                &((_CUCL039I * )pMessage)->HdrCU0408O.KyRdg,  
                                &((_CUCL039I * )pMessage)->DatCU1230A[0].DtMtrGrpEff, 
                                &((_CUCL039I * )pMessage)->DatCU1230A[0].KyMtrEquipNo,                                       
                                &((_CUCL039I * )pMessage)->DatCU1230A[0].KyMrdgSeqActl,                                       
                                &((_CUCL039I * )pMessage)->HdrCU0616B.KyPwqWoId,
						        &((_CUCL039I * )pMessage)->HdrCU0616B.TsKyPwq,
                                &CurrentKyPremNo,
                                &((_CUCL039I * )pMessage)->HdrCU0403B.KyBa);

                                ((_CUCL039I * )pMessage)->HdrCU0403B.KyPremNo = CurrentKyPremNo;                                    

                                ((_CUCL039I * )pMessage)->DatCU1230A[0].KyBa =
                                    ((_CUCL039I * )pMessage)->HdrCU0403B.KyBa;

                                ((_CUCL039I * )pMessage)->DatCU1230A[0].KyPremNo =
                                    ((_CUCL039I * )pMessage)->HdrCU0403B.KyPremNo;

                                ((_CUCL039I * )pMessage)->DatCU1230A[0].KySpt =
                                    ((_CUCL039I * )pMessage)->HdrCU0403B.KySpt;

                                ((_CUCL039I * )pMessage)->DatCU1230A[0].KyRdg =
                                    ((_CUCL039I * )pMessage)->HdrCU0408O.KyRdg;

                                strcpy(((_CUCL039I * )pMessage)->HdrCUMWF002.KyPwqWoId,
                                    ((_CUCL039I * )pMessage)->HdrCU0616B.KyPwqWoId);

                                strcpy(((_CUCL039I * )pMessage)->HdrCUMWF002.TsKyPwq,
                                    ((_CUCL039I * )pMessage)->HdrCU0616B.TsKyPwq);


                                if( CurrentKyPremNo == PreviousKyPremNo)
                                {
                                    WriteFile = FALSE;
                                }
                            
                                PreviousKyPremNo = CurrentKyPremNo;
				            }

       			            /************************************************
				            **
				            **   CUCR063I - Response Handler CUMC15 (ABURDEN)
				            **
				            *************************************************/
                            #include "CUCR063I.H"

				            if ( strncmp( MsgPB.translation.map_name, "CUCR063I", 8 ) == 0 )
				            {
					            sscanf( Value, "%lf %s",
					            &((_CUCR063I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
                                &((_CUCR063I * )pMessage)->StandardHeader.DtCurrDate);
				            }


/******************************************************************************************
CUSO01 / CUSO02 - CUCR067I
Issue Connect / Issue Disconnect
Begin
******************************************************************************************/
         		            /**************************************************************
				            **
				            **   CUCR067I - Issue Reconnect/Issue Disconnect
                            **   CUSO01 & CUSO02
				            **
				            **************************************************************/
                            #include "CUCR067I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCR067I", 8 ) == 0 )
				            {
					            _CUCR067I *pCUCR067I;
					            pCUCR067I = (_CUCR067I * ) pMessage;

					            //*   ISSUE RECONNECT *//

					            if ( strncmp (lfunctioncode, "01", 8) == 0 )
					            {
						            sscanf( Value, "%lf %ld %ld %ld", 
						            &((_CUCR067I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
						            &((_CUCR067I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo,
						            &((_CUCR067I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
						            &((_CUCR067I * )pMessage)->HdrCU0475D.KyBldgNo );
                  
					            }

					            //*   ISSUE DISCONNECT *//

					            if ( strncmp (lfunctioncode, "02", 8) == 0 )
					            {
						            sscanf( Value, "%lf, %ld, %ld, %ld",
						            &((_CUCR067I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
						            &((_CUCR067I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo,
						            &((_CUCR067I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
						            &((_CUCR067I * )pMessage)->HdrCU0475D.KyBldgNo);

                                    ///* 
                                    //** Impose valid combinations of CdTarType and CdTarSch
                                    //** as seen in Table CU04TB61.
                                    //**/
                                    //if( CurrentCdCo == 1)
                                    //{
                                    //   strcpy(((_CUCL060I *)pMessage)->HdrCU0902P.CdTarSch, "020");
                                    //
                                    //    strcpy(((_CUCL060I *)pMessage)->HdrCumso043.SetupBA.CdTarType, "01");
                                    //    strcpy(((_CUCL060I *)pMessage)->HdrCumbi336NewSpt.CdTarType, "01");
                                    //    strcpy(((_CUCL060I *)pMessage)->HdrCumbi336.CdTarType, "01");
                                   // }
                                   // else if( CurrentCdCo == 2)
                                   // {
                                   //     strcpy(((_CUCL060I *)pMessage)->HdrCU0902P.CdTarSch, "020");
                                   //     strcpy(((_CUCL060I *)pMessage)->HdrCumso043.SetupBA.CdTarType, "03");
                                   //     strcpy(((_CUCL060I *)pMessage)->HdrCumbi336NewSpt.CdTarType, "03");
                                   //     strcpy(((_CUCL060I *)pMessage)->HdrCumbi336.CdTarType, "03");

                                  //  }
                                  //  else if( CurrentCdCo == 3)
                                  //  {
                                  //      strcpy(((_CUCL060I *)pMessage)->HdrCU0902P.CdTarSch, "025");
                                  //      strcpy(((_CUCL060I *)pMessage)->HdrCumso043.SetupBA.CdTarType, "01");
                                  //      strcpy(((_CUCL060I *)pMessage)->HdrCumbi336NewSpt.CdTarType, "01");
                                  //      strcpy(((_CUCL060I *)pMessage)->HdrCumbi336.CdTarType, "01");
                                  //  }
                                  //  else if( CurrentCdCo == 4)
                                  //  {
                                  //      strcpy(((_CUCL060I *)pMessage)->HdrCU0902P.CdTarSch, "020");
                                  //      strcpy(((_CUCL060I *)pMessage)->HdrCumso043.SetupBA.CdTarType, "03");
                                  //      strcpy(((_CUCL060I *)pMessage)->HdrCumbi336NewSpt.CdTarType, "03");
                                  //      strcpy(((_CUCL060I *)pMessage)->HdrCumbi336.CdTarType, "03");
                                  //  }
                                  //  else if( CurrentCdCo == 5)
                                  //  {
                                  //      strcpy(((_CUCL060I *)pMessage)->HdrCU0902P.CdTarSch, "020");
                                  //      strcpy(((_CUCL060I *)pMessage)->HdrCumso043.SetupBA.CdTarType, "03");
                                  //      strcpy(((_CUCL060I *)pMessage)->HdrCumbi336NewSpt.CdTarType, "03");
                                  //      strcpy(((_CUCL060I *)pMessage)->HdrCumbi336.CdTarType, "03");
                                  //  }
                                  //      

					            }
				            }
/******************************************************************************************
End
******************************************************************************************/

/******************************************************************************************
CUSO01 / CUSO02 - CUCL060I
LUW Issue Connect / LUW Issue Disconnect
Begin
******************************************************************************************/
         		            /**************************************************************
				            **
				            **   CUCL060I - LUW Issue Reconnect / LUW Issue Disconnect
                            **   CUSO01 & CUSO02
				            **
				            **************************************************************/
                            #include "CUCL060I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCL060I", 8 ) == 0 )
				            {
					            _CUCL060I *pCUCL060I;
					            pCUCL060I = (_CUCL060I * ) pMessage;

                                WriteFile = TRUE;

					            //*   ISSUE RECONNECT *//

					            if ( strncmp (lfunctioncode, "01", 8) == 0 )
					            {
						            sscanf( Value, "%ld %ld %ld %s",
                                    &CurrentKyCustNo,
                                    &CurrentKyPremNo,
						            &((_CUCL060I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqPrem,
						            &((_CUCL060I * )pMessage)->HdrCU0902P.CdRegion);

                                    ((_CUCL060I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo = CurrentKyCustNo;
                                    ((_CUCL060I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo = CurrentKyPremNo;
                                    
                                    
/* Don't forget to alter table CU04TB61 to hold valid rates */                                    
                                    
                                    /* This is a valid TarType/TarSch combination for the three coastal companies */
//                                    strcpy(((_CUCL060I *)pMessage)->HdrCU0902P.CdTarSch, "020");
                                    
//                                    strcpy(((_CUCL060I *)pMessage)->HdrCumso043.SetupBA.CdTarType, "03");
//                                    strcpy(((_CUCL060I *)pMessage)->HdrCumbi336NewSpt.CdTarType, "03");
//                                    strcpy(((_CUCL060I *)pMessage)->HdrCumbi336.CdTarType, "03");
                                    
                                    if(( CurrentKyPremNo == PreviousKyPremNo) || 
                                       ( CurrentKyCustNo == PreviousKyCustNo))
                                    {
                                        WriteFile = FALSE;
                                    }
                                    
                                    PreviousKyPremNo = CurrentKyPremNo;
                                    PreviousKyCustNo = CurrentKyCustNo;


					            }

					            //*   ISSUE DISCONNECT *//
					            if ( strncmp (lfunctioncode, "02", 8) == 0 )
					            {
						            sscanf( Value, "%lf %ld %ld %ld %ld %ld %ld %ld %s %ld %s",
                                    &CurrentKyBa,
                                    &CurrentKyCustNo,
                                    &CurrentKyPremNo,
						            &((_CUCL060I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqBa,
						            &((_CUCL060I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqBaAim,
						            &((_CUCL060I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqPrem,
						            &((_CUCL060I * )pMessage)->DatCumso043.ServiceMaintDat[0].KySpt,
						            &((_CUCL060I * )pMessage)->DatCumso043.ServiceMaintDat[0].NoLockSeqSpt,
						            &((_CUCL060I * )pMessage)->DatCumso043.ServiceMaintDat[0].CdTarSch,
						            &((_CUCL060I * )pMessage)->DatCumso043.ServiceMaintDat[0].KyMptNo,
						            &((_CUCL060I * )pMessage)->DatCumso043.ServiceMaintDat[0].KyMtrEquipNo );

                                    ((_CUCL060I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa = CurrentKyBa;
						            ((_CUCL060I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo = CurrentKyCustNo;
						            ((_CUCL060I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo = CurrentKyPremNo;
                                    
                                    ((_CUCL060I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqCust = 0;    
                                    
                                    ((_CUCL060I * )pMessage)->DatCumso043.ServiceMaintDat[0].KyBa = 
                                        ((_CUCL060I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                    if(( CurrentKyPremNo == PreviousKyPremNo) || 
                                       ( CurrentKyCustNo == PreviousKyCustNo) ||
                                       ( CurrentKyBa     == PreviousKyBa))
                                    {
                                        WriteFile = FALSE;
                                    }
                                    
                                    PreviousKyPremNo = CurrentKyPremNo;
                                    PreviousKyCustNo = CurrentKyCustNo;
                                    PreviousKyBa     = CurrentKyBa;
					            }
				            }
/******************************************************************************************
End
******************************************************************************************/


/******************************************************************************************
CUSO04 - CUCR068I
Issue Meter Order
Begin
******************************************************************************************/
         		            /**************************************************************
				            **
				            **   CUCR068I - Issue Meter Order
                            **   CUSO04
				            **
				            **************************************************************/
                            #include "CUCR068I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCR068I", 8 ) == 0 )
				            {
					            _CUCR068I *pCUCR068I;
					            pCUCR068I = (_CUCR068I * ) pMessage;

						        sscanf( Value, "%lf %ld %ld %ld", 
						        &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
						        &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo,
						        &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
						        &((_CUCR068I * )pMessage)->HdrCu0401D.KyBldgNo );

				            }

/******************************************************************************************
End
******************************************************************************************/

         		            
/******************************************************************************************
CUSO06 - CUCR068I
Issue Meter Investigation
Begin
******************************************************************************************/
                            /**************************************************************
				            **
				            **   CUCR068I - Issue Meter Investigation
                            **   CUSO06
				            **
				            **************************************************************/
                            #include "CUCR068I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCR068I", 8 ) == 0 )
				            {
					            _CUCR068I *pCUCR068I;
					            pCUCR068I = (_CUCR068I * ) pMessage;

						        sscanf( Value, "%ld %ld %ld", 
						        &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
						        &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqPrem,
						        &((_CUCR068I * )pMessage)->HdrCu0401D.KyBldgNo );
                  

				            }


                            /**************************************************************
				            **
				            **   CUCR001I - Issue Meter Investigation
                            **   CUSO06
				            **
				            **************************************************************/
                            #include "CUCR001I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCR001I", 8 ) == 0 )
				            {
					            _CUCR001I *pCUCR001I;
					            pCUCR001I = (_CUCR001I * ) pMessage;

						        sscanf( Value, "%ld %ld", 
						        &((_CUCR001I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
						        &((_CUCR001I * )pMessage)->????.KyBldgNo );
                  

				            }

                            /**************************************************************
				            **
				            **   CUCR068I - Issue Meter Investigation
                            **   CUSO06 (WORK GROUP AVAILABLILTY - CUDS024X)
				            **
				            **************************************************************/
                            #include "CUCR068I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCR068I", 8 ) == 0 )
				            {
					            _CUCR068I *pCUCR068I;
					            pCUCR068I = (_CUCR068I * ) pMessage;

						        sscanf( Value, "%ld %s %s %ld", 
						        &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
						        &((_CUCR068I * )pMessage)->HdrCUMDS001.CdOrdType,
						        &((_CUCR068I * )pMessage)->HdrCUMDS001.DtSpecRqst,
                                &((_CUCR068I * )pMessage)->HdrCu0401D.KyBldgNo );

				            }

                            /**************************************************************
				            **
				            **   CUCR068I - Issue Meter Investigation
                            **   CUSO06 (PREMISE DETAILS - CUSO012X)
				            **
				            **************************************************************/
                            #include "CUCR068I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCR068I", 8 ) == 0 )
				            {
					            _CUCR068I *pCUCR068I;
					            pCUCR068I = (_CUCR068I * ) pMessage;

						        sscanf( Value, "%lf %ld %ld", 
						        &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
						        &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
						        &((_CUCR068I * )pMessage)->HdrCu0401D.KyBldgNo );

				            }
/******************************************************************************************
End
******************************************************************************************/

         		            /**************************************************************
				            **
				            **   CUCR068I - Issue Other Investigation
                            **   CUSO07
				            **
				            **************************************************************/
                            #include "CUCR068I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCR068I", 8 ) == 0 )
				            {
					            _CUCR068I *pCUCR068I;
					            pCUCR068I = (_CUCR068I * ) pMessage;

						        sscanf( Value, "%lf %ld %ld %ld", 
						        &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
						        &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo,
						        &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
						        &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqPrem);

				            }

                            
                            /**************************************************************
				            **
				            **   CUCR001I - Issue Other Investigation
                            **   CUSO07
				            **
				            **************************************************************/
                            #include "CUCR001I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCR001I", 8 ) == 0 )
				            {
					            _CUCR001I *pCUCR001I;
					            pCUCR001I = (_CUCR001I * ) pMessage;

						        sscanf( Value, "%lf %ld %ld", 
						        &((_CUCR001I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
						        &((_CUCR001I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo,
						        &((_CUCR001I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo);
                  

				            }
                            
                            

                            /**************************************************************
				            **
				            **   CUCR068I - Issue Other Investigation
                            **   CUSO07 (ORDER DETAILS - CUSO020X)
				            **
				            **************************************************************/
                            #include "CUCR068I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCR068I", 8 ) == 0 )
				            {
					            _CUCR068I *pCUCR068I;
					            pCUCR068I = (_CUCR068I * ) pMessage;

						        sscanf( Value, "%lf %ld %ld", 
						        &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
						        &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
						        &((_CUCR068I * )pMessage)->????.KyBldgNo );

				            }


                            /**************************************************************
				            **
				            **   CUCR068I - Issue Other Investigation
                            **   CUSO07 (WORK GROUP AVAILABLILTY - CUDS024X)
				            **
				            **************************************************************/
                            #include "CUCR068I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCR068I", 8 ) == 0 )
				            {
					            _CUCR068I *pCUCR068I;
					            pCUCR068I = (_CUCR068I * ) pMessage;

						        sscanf( Value, "%ld %s %s %ld", 
						        &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
						        &((_CUCR068I * )pMessage)->HdrCUMDS001.CdOrdType,
						        &((_CUCR068I * )pMessage)->HdrCu0449S.DtEff,
                                &((_CUCR068I * )pMessage)->????.KyBldgNo );

				            }



                            /**************************************************************
				            **
				            **   CUCR001I - Issue Meter Investigation
                            **   CUSO06 (PREMISE DETAILS - CUSO012X)
				            **
				            **************************************************************/
                            #include "CUCR001I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCR001I", 8 ) == 0 )
				            {
					            _CUCR001I *pCUCR001I;
					            pCUCR001I = (_CUCR001I * ) pMessage;

						        sscanf( Value, "%lf %ld %ld", 
						        &((_CUCR001I * )pMessage)->.KyBa,
						        &((_CUCR001I * )pMessage)->.KyPremNo,
						        &((_CUCR001I * )pMessage)->.KyBldgNo);
                  

				            }
/******************************************************************************************
CUSO08 - CUCR072I
Maintain Service Orders
Begin
******************************************************************************************/
                            /**************************************************************
				            **
				            **   CUCR072I - Maintain Service Order
                            **   CUSO08
				            **
				            **************************************************************/
                            #include "CUCR072I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCR072I", 8 ) == 0 )
				            {
					            _CUCR072I *pCUCR072I;
					            pCUCR072I = (_CUCR072I * ) pMessage;

						        sscanf( Value, "%ld", 
						        &((_CUCR072I * )pMessage)->HdrCu0902A.KySoNo);
                  

				            }
/******************************************************************************************
End
******************************************************************************************/


/******************************************************************************************
CUSO08 - CUCL066I
Maintain Service Orders
Begin
******************************************************************************************/
                            /**************************************************************
				            **
				            **   CUCL066I - Maintain Service Order
                            **   CUSO08
				            **
				            **************************************************************/
                            #include "CUCL066I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCL066I", 8 ) == 0 )
				            {
					            _CUCL066I *pCUCL066I;
					            pCUCL066I = (_CUCL066I * ) pMessage;

                                WriteFile = TRUE;

						        sscanf( Value, "%lf %ld %ld %ld %ld %ld %ld", 
                                &CurrentKyBa,
                                &CurrentKyCustNo,
                                &CurrentKyPremNo,
						        &((_CUCL066I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqPrem,
                                &((_CUCL066I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyFordNo,
                                &((_CUCL066I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqFoHdr,
                                &((_CUCL066I * )pMessage)->HdrCU0902A.KySoNo);

						        ((_CUCL066I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa = CurrentKyBa;
						        ((_CUCL066I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo = CurrentKyCustNo;
						        ((_CUCL066I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo = CurrentKyPremNo;
						        

                                if(( CurrentKyPremNo == PreviousKyPremNo) || 
                                   ( CurrentKyCustNo == PreviousKyCustNo) ||
                                   ( CurrentKyBa     == PreviousKyBa))
                                {
                                    WriteFile = FALSE;
                                }
                                
                                PreviousKyPremNo = CurrentKyPremNo;
                                PreviousKyCustNo = CurrentKyCustNo;
                                PreviousKyBa     = CurrentKyBa;
                                    
                  

				            }
/******************************************************************************************
End
******************************************************************************************/


/******************************************************************************************
CUSO41 - CUCR066I
Issue Maintain Lighting
Begin
******************************************************************************************/
                            /**************************************************************
				            **
				            **   CUSO41 - CUCR066I
                            **   Issue Maintain Lighting
				            **
				            **************************************************************/
                            #include "CUCR066I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCR066I", 8 ) == 0 )
				            {
					            _CUCR066I *pCUCR066I;
					            pCUCR066I = (_CUCR066I * ) pMessage;

						        sscanf( Value, "%lf %ld %ld %ld", 
						        &((_CUCR066I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
						        &((_CUCR066I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo,
						        &((_CUCR066I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
						        &((_CUCR066I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqPrem);
                  

				            }

                            /**************************************************************
				            **
				            **   CUCR068I - Issue Maintain Lighting
                            **   CUSO41 (WORK GROUP AVAILABLILTY - CUDS024X)
				            **
				            **************************************************************/
                            #include "CUCR068I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCR068I", 8 ) == 0 )
				            {
					            _CUCR068I *pCUCR068I;
					            pCUCR068I = (_CUCR068I * ) pMessage;

						        sscanf( Value, "%ld %s %s %ld", 
						        &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
						        &((_CUCR068I * )pMessage)->HdrCUMDS001.CdOrdType,
						        &((_CUCR068I * )pMessage)->HdrCu0449S.DtEff,
                                &((_CUCR068I * )pMessage)->????.KyBldgNo );

				            }

                            /**************************************************************
				            **
				            **   CUCR066I - Issue Maintain Lighting
                            **   CUSO41 (PREMISE DETAILS - CUSO012X)
				            **
				            **************************************************************/
                            #include "CUCR066I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCR066I", 8 ) == 0 )
				            {
					            _CUCR066I *pCUCR066I;
					            pCUCR066I = (_CUCR066I * ) pMessage;

						        sscanf( Value, "%lf %ld %ld", 
						        &((_CUCR066I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
						        &((_CUCR066I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo,
						        &((_CUCR066I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo);
                            }
                  
/******************************************************************************************
End
******************************************************************************************/


/******************************************************************************************
CUSO45 - CUCR100I
Complete Lighting
Begin
******************************************************************************************/
                            /**************************************************************
				            **
				            **   CUSO45 - CUCR100I
                            **   Complete Lighting
				            **
				            **************************************************************/
                            #include "CUCR100I.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CUCR100I", 8 ) == 0 )
				            {
					            _CUCR100I *pCUCR100I;
					            pCUCR100I = (_CUCR100I * ) pMessage;

						        sscanf( Value, "%ld", 
						        &((_CUCR100I * )pMessage)->Cur100L01.HdrCu0909a.KyFordNo);
                            }

/******************************************************************************************
End
******************************************************************************************/

                            /************************************************
				            **
				            **   CUCR068I - CUSO17
				            **
				            *************************************************/
                            #include "CUCR068I.H"
				             
				            if ( strncmp( MsgPB.translation.map_name, "CUCR068I", 5 ) == 0 )
				            {
					            if ( strncmp (lfunctioncode, "05", 8) == 0 )
					            {
						            sscanf( Value, "%lf %s",
						            &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
						            &((_CUCR068I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo);
					            }
				            }



    			            /************************************************
				            **
				            **   CUCR069I - CUSO24
				            **
				            *************************************************/
                            #include "CUCR069I.H"
				             
				            if ( strncmp( MsgPB.translation.map_name, "CUCR069I", 8 ) == 0 )
				            {
					            _CUCR069I *pCUCR069I;
					            pCUCR069I = (_CUCR069I * ) pMessage;

					            if ( strncmp (lfunctioncode, "03", 8) == 0 )
					            {
						            sscanf( Value, "%ld %s",
						            &((_CUCR069I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyFordNo);
					            }
				            }



    			            /************************************************
				            **
				            **   CU0101WM (GENERIC SERVICE) (CUCS02) (ABURDEN)
				            **
				            *************************************************/
                            #include "CU0101WM.H"
				            
                            if ( strncmp( MsgPB.translation.map_name, "CU0101WM", 8 ) == 0 )
				            {
					            sscanf( Value, "%ld",
					            &((_CU0101WTRANREC *)pMessage)->Cu0101whHiKey.Cu0101wkSad.KySsn,
					            &((_CU0101WTRANREC *)pMessage)->Cu0101wlLOKey.Cu0101wkSad.KySsn);
				            }



        		            /************************************************
        		            **
        		            **   CU0209EM (GENERIC SERVICE)(CUOB15)
        		            **
        		            *************************************************/
                            #include "CU0209EM.H"
                            #include "CU0403FM.H"
         		            
                            if ( strncmp( MsgPB.translation.map_name, "CU0209EM", 8 ) == 0 )

           		            {
					            _CU0209EMTRANREC *pCU0209EMTRANREC;
					            pCU0209EMTRANREC = (_CU0209EMTRANREC * ) pMessage;

					            sscanf( Value, "%lf %d",
            		            &((_CU0209EMTRANREC *)pMessage)->Cu0209ehHiKey.Cu0209eKeyGrp.KyBa,
            		            &((_CU0209EMTRANREC *)pMessage)->Cu0209ehHiKey.Cu0209eKeyGrp.KyPremNo);

            		            ((_CU0209EMTRANREC *)pMessage)->Cu0209elLoKey.Cu0209eKeyGrp.KyBa =
            		            ((_CU0209EMTRANREC *)pMessage)->Cu0209ehHiKey.Cu0209eKeyGrp.KyBa;

		                        ((_CU0209EMTRANREC *)pMessage)->Cu0209elLoKey.Cu0209eKeyGrp.KyPremNo =
        		                ((_CU0209EMTRANREC *)pMessage)->Cu0209ehHiKey.Cu0209eKeyGrp.KyPremNo;
           		            }
                            else if( strncmp( MsgPB.translation.map_name, "CU0403FM", 8 ) == 0 )
                            {
					            _CU0403FMRECORD *pCU0403FMRECORD;
					            pCU0403FMRECORD = (_CU0403FMRECORD * ) pMessage;

					            sscanf( Value, "%d",
            		            &((_CU0403FMRECORD *)pMessage)->Cu0403fhHiKyGrp.SrvcPtKyGrp.KyPremNo);

		                        ((_CU0403FMRECORD *)pMessage)->Cu0403flLoKyGrp.SrvcPtKyGrp.KyPremNo =
        		                ((_CU0403FMRECORD *)pMessage)->Cu0403fhHiKyGrp.SrvcPtKyGrp.KyPremNo;
                            }

    			            /************************************************
				            **
				            **   CUCR111I (CUOB34)
				            **
        		            *************************************************/
                            #include "CUCR111I.H"

				            if ( strncmp( MsgPB.translation.map_name, "CUCR111I", 8 ) == 0 )
				            {   
					            _CUCR111I *pCUCR111I;
					            pCUCR111I = (_CUCR111I * ) pMessage;
				            
					            sscanf( Value, "%ld, %ld",
						        &((_CUCR111I * )pMessage)->PremiseInfo.KySpt, 
						        &((_CUCR111I * )pMessage)->PremiseInfo.KyPremNo);
				            }

    			            /************************************************
				            **
				            **   CU0403MM (CUOB34)
				            **
        		            *************************************************/
                            #include "CU0403MM.H"

				            if ( strncmp( MsgPB.translation.map_name, "CU0403MM", 8 ) == 0 )
				            {   
					            _CU0403MMTRANREC *pCU0403MMTRANREC;
					            pCU0403MMTRANREC = (_CU0403MMTRANREC * ) pMessage;
				            
					            sscanf( Value, "%ld, %ld",
						        &((_CU0403MMTRANREC * )pMessage)->Cu0403mlLoKey.ServcePtKeyGrp.KySpt,
						        &((_CU0403MMTRANREC * )pMessage)->Cu0403mlLoKey.ServcePtKeyGrp.KyPremNo );
				            
                                ((_CU0403MMTRANREC * )pMessage)->Cu0403mhHiKey.ServcePtKeyGrp.KyPremNo =
                                    ((_CU0403MMTRANREC * )pMessage)->Cu0403mlLoKey.ServcePtKeyGrp.KyPremNo;

                                ((_CU0403MMTRANREC * )pMessage)->Cu0403mhHiKey.ServcePtKeyGrp.KySpt =
                                    ((_CU0403MMTRANREC * )pMessage)->Cu0403mlLoKey.ServcePtKeyGrp.KySpt;
                            }

    			            /************************************************
				            **
				            **   CUCR099I (CUOB26)
				            **
        		            *************************************************/
                            #include "CUCR099I.H"

				            if ( strncmp( MsgPB.translation.map_name, "CUCR099I", 8 ) == 0 )
				            {   
					            _CUCR099I *pCUCR099I;
					            pCUCR099I = (_CUCR099I * ) pMessage;
				            
					            sscanf( Value, "%lf, %ld, %ld, %ld",
						        &((_CUCR099I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
						        &((_CUCR099I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo,
						        &((_CUCR099I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
						        &((_CUCR099I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyFordNo );
				            }

    			            /************************************************
				            **
				            **   CUCR099I (CUOB26) Retrieva Comments
				            **
        		            *************************************************/
                            #include "CUCR099I.H"

				            if ( strncmp( MsgPB.translation.map_name, "CUCR099I", 8 ) == 0 )
				            {   
					            _CUCR099I *pCUCR099I;
					            pCUCR099I = (_CUCR099I * ) pMessage;
				            
					            sscanf( Value, "%ld",
						        &((_CUCR099I * )pMessage)->HdrCumcc002.KyRemarks );
				            }



    			            /************************************************
				            **
				            **   CU0926BM (GENERIC SERVICE)(CUDS01)
				            **
        		            *************************************************/
                            #include "CU0926BM.H"

				            if ( strncmp( MsgPB.translation.map_name, "CU0926BM", 8 ) == 0 )
				            {   
					            _CU0926BTRANREC *pCU0926BTRANREC;
					            pCU0926BTRANREC = (_CU0926BTRANREC * ) pMessage;
				            
					            sscanf( Value, "%s %s",
					            &((_CU0926BTRANREC *)pMessage)->Cu0926blLoKyGrp.Cu0926bKeyGrp.CdOperCntr);

					            strcpy(((_CU0926BTRANREC *)pMessage)->Cu0926bhHiKyGrp.Cu0926bKeyGrp.CdOperCntr,
					            ((_CU0926BTRANREC *)pMessage)->Cu0926blLoKyGrp.Cu0926bKeyGrp.CdOperCntr);
				            }



    			            /************************************************
				            **
				            **   CU1201HM (GENERIC SERVICE)(CUOB01)
				            **
				            *************************************************/
                            #include "CU1201HM.H"

				            if ( strncmp( MsgPB.translation.map_name, "CU1201HM", 8 ) == 0 )

                            {   
					            _BILLINFOHDRREC *pBILLINFOHDRREC;
					            pBILLINFOHDRREC = (_BILLINFOHDRREC * ) pMessage;

					            sscanf( Value, "%lf",
					            &((_BILLINFOHDRREC * )pMessage)->Cu1201hhHiKeyGrp.Cu1201hkAlrKey.KyBa );

					            ((_BILLINFOHDRREC * )pMessage)->Cu1201hlLoKeyGrp.Cu1201hkAlrKey.KyBa =
					            ((_BILLINFOHDRREC * )pMessage)->Cu1201hhHiKeyGrp.Cu1201hkAlrKey.KyBa;

                            }

    			            /************************************************
				            **
				            **   CU0405JM (GENERIC SERVICE)(CUGM51)
				            **
				            *************************************************/
                            #include "CU0405JM.H"

				            if ( strncmp( MsgPB.translation.map_name, "CU0405JM", 8 ) == 0 )

                            {   
					            _CU0405JMRECORD *pCU0405JMRECORD;
					            pCU0405JMRECORD = (_CU0405JMRECORD * ) pMessage;

					            sscanf( Value, "%d",
					            &((_CU0405JMRECORD * )pMessage)->Cu0405jlLoKyGrp.Cu0405jKeyGrp.CdCo );

					            ((_CU0405JMRECORD * )pMessage)->Cu0405jhHiKyGrp.Cu0405jKeyGrp.CdCo =
					            ((_CU0405JMRECORD * )pMessage)->Cu0405jlLoKyGrp.Cu0405jKeyGrp.CdCo;
                                
                                
                    
                            }

    			            /************************************************
				            **
				            **   CU1099AM (GENERIC SERVICE)(CUOB70)
				            **
				            *************************************************/
                            #include "CU1099AM.H"

				            if ( strncmp( MsgPB.translation.map_name, "CU1099AM", 8 ) == 0 )

                            {   
					            _CU1099AMMAPREC *pCU1099AMMAPREC;
					            pCU1099AMMAPREC = (_CU1099AMMAPREC * ) pMessage;

					            sscanf( Value, "%s",
					            &((_CU1099AMMAPREC * )pMessage)->Cu1099ahHiKey.UsersKeyGrp.PkeyUser.KyUserId );

					            strcpy(((_CU1099AMMAPREC * )pMessage)->Cu1099alLoKey.UsersKeyGrp.PkeyUser.KyUserId,
					            ((_CU1099AMMAPREC * )pMessage)->Cu1099ahHiKey.UsersKeyGrp.PkeyUser.KyUserId);

                            }



    			            /************************************************
				            **
				            **   CU0205DM (GENERIC SERVICE)(CUOB02)
				            **
				            *************************************************/
                            #include "CU0205DM.H"

				            if ( strncmp( MsgPB.translation.map_name, "CU0205DM", 8 ) == 0 )

                            {   
					            _CU0205DMCREDSORC *pCU0205DMCREDSORC;
					            pCU0205DMCREDSORC = (_CU0205DMCREDSORC * ) pMessage;

					            sscanf( Value, "%lf",
					            &((_CU0205DMCREDSORC * )pMessage)->Cu0205dhCredSrce.CU0205dkCredtSrce.KyBa );

					            ((_CU0205DMCREDSORC * )pMessage)->Cu0205dlCredSrce.CU0205dkCredtSrce.KyBa =
					            ((_CU0205DMCREDSORC * )pMessage)->Cu0205dhCredSrce.CU0205dkCredtSrce.KyBa;

                            }


    			            /************************************************
				            **
				            **   CUCR097I (GENERIC SERVICE)(CUOB03)
				            **
				            *************************************************/
                            #include "CUCR097I.H"

				            if ( strncmp( MsgPB.translation.map_name, "CUCR097I", 8 ) == 0 )

                            {   
					            _CUCR097I *pCUCR097I;
					            pCUCR097I = (_CUCR097I * ) pMessage;

					            sscanf( Value, "%lf",
					            &((_CUCR097I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa );

					            ((_CUCR097I * )pMessage)->HdrCU0501C.KyBa =
					            ((_CUCR097I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;
					            
                                ((_CUCR097I * )pMessage)->HdrCU0502H.KyBa =
					            ((_CUCR097I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                            }



        		            /************************************************
        		            **
        		            **   CU2312GM (GENERIC SERVICE) CUMC15
        		            **
        		            *************************************************/
                            #include "CU0209EM.H"

         		            if ( strncmp( MsgPB.translation.map_name, "CU0209EM", 8 ) == 0 )

           		            {
					            _CU2312GMTRANREC *pCU2312GMTRANREC;
					            pCU2312GMTRANREC = (_CU2312GMTRANREC * ) pMessage;

					            sscanf( Value, "%s ",
            		            &((_CU2312GMTRANREC *)pMessage)->Cu2312glLoKey.Cu2312gKeyGrp.CdMrktAd );
           		            }


/******************************************************************************************
CUGM29 - CUCL107I
MAINTAIN BILL ACCOUNT
Begin
******************************************************************************************/
    			            /**************************************************************
				            **
				            **   CUCL107I - CUGM29  MAINTAIN BILL ACCOUNT
				            **
				            **************************************************************/
                            #include "CUCL107I.H"

				            if ( strncmp( MsgPB.translation.map_name, "CUCL107I", 8 ) == 0 )
				            {
					            _MNTBILLACCT *pCUCL107I;
					            pCUCL107I = (_MNTBILLACCT * ) pMessage;

                                WriteFile = TRUE;

					            sscanf( Value, "%lf %ld %ld %ld", 
                                &CurrentKyBa,
					            &((_MNTBILLACCT * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqBa,
                                &CurrentKyPremNo,
                                &CurrentKyCustNo);

                                ((_MNTBILLACCT * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa = CurrentKyBa;
					            ((_MNTBILLACCT * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo = CurrentKyPremNo;
					            ((_MNTBILLACCT * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo = CurrentKyCustNo;

                                if(( CurrentKyPremNo == PreviousKyPremNo) || 
                                   ( CurrentKyCustNo == PreviousKyCustNo) ||
                                   ( CurrentKyBa     == PreviousKyBa))
                                {
                                    WriteFile = FALSE;
                                }
                                
                                PreviousKyPremNo = CurrentKyPremNo;
                                PreviousKyCustNo = CurrentKyCustNo;
                                PreviousKyBa     = CurrentKyBa;

                            }
/******************************************************************************************
End
******************************************************************************************/

 

    			            /**************************************************************
				            **
				            **   CUCR035I - View Load Management Activity
				            **
				            **************************************************************/
                            #include "CUCR035I.H"

				            if ( strncmp( MsgPB.translation.map_name, "CUCR035I", 8 ) == 0 )
				            {
					            //*   VIEW LOAD MANAGEMENT USING WINDOW CULM011 *//
					            _LMACTIONSINRETR *pLMACTIONSINRETR;
					            pLMACTIONSINRETR = (_LMACTIONSINRETR * ) pMessage;

					            if ( strncmp (lfunctioncode, "04", 8) == 0 )
                                {
						            sscanf( Value, "%ld %s %ld %u",
                     	            &((_LMACTIONSINRETR * )pMessage)->HdrCU2213C.KyPremNo,
						            &((_LMACTIONSINRETR * )pMessage)->HdrCU2213C.CdBus,
						            &((_LMACTIONSINRETR * )pMessage)->HdrCU2213C.CdProd,
						            &((_LMACTIONSINRETR * )pMessage)->HdrCU2213C.NoProdSequence );

						            ((_LMACTIONSINRETR * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo =
						            ((_LMACTIONSINRETR * )pMessage)->HdrCU2213C.KyPremNo;

						            ((_LMACTIONSINRETR * )pMessage)->HdrCUMAC002.KyPremNo =
						            ((_LMACTIONSINRETR * )pMessage)->HdrCU2213C.KyPremNo;

                                }
					            //*   VIEW LOAD MANAGEMENT USING WINDOW CULM009 *//

					            if ( strncmp (lfunctioncode, "05", 8) == 0 )
                                {
						            sscanf( Value, "%l, %c, %l, %s",
						            &((_LMACTIONSINRETR * )pMessage)->HdrCU2213C.KyPremNo,
                     	            &((_LMACTIONSINRETR * )pMessage)->HdrCU2213C.CdBus,
                     	            &((_LMACTIONSINRETR * )pMessage)->HdrCU2213C.CdProd,
                     	            &((_LMACTIONSINRETR * )pMessage)->HdrCU2213C.NoProdSequence );

                     	            ((_LMACTIONSINRETR * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo =
                     	            ((_LMACTIONSINRETR * )pMessage)->HdrCU2213C.KyPremNo;

                     	            ((_LMACTIONSINRETR * )pMessage)->HdrCU2235F.KyPremNo =
                     	            ((_LMACTIONSINRETR * )pMessage)->HdrCU2213C.KyPremNo;

                     	            ((_LMACTIONSINRETR * )pMessage)->HdrCU0237S.KyPremNo =
                     	             ((_LMACTIONSINRETR * )pMessage)->HdrCU2213C.KyPremNo;
                                }


						            //*   VIEW LOAD MANAGEMENT USING WINDOW CULM009 *//

						            if ( strncmp (lfunctioncode, "06", 8) == 0 )
						            {
							            sscanf( Value, "%l",
							            &((_LMACTIONSINRETR * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo );

							            ((_LMACTIONSINRETR * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo =
							            ((_LMACTIONSINRETR * )pMessage)->HdrCUMAC002.KyPremNo;
                                }

					            //*   REQUEST LOAD MANAGEMENT ORDER *//

                                if ( strncmp (lfunctioncode, "02", 8) == 0 )
                                {
						            sscanf( Value, "%l, %l, %l, %c",
						            &((_LMACTIONSINRETR * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
                     	            &((_LMACTIONSINRETR * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo,
                     	            &((_LMACTIONSINRETR * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
                     	            &((_LMACTIONSINRETR * )pMessage)->HdrCU0101P35.CdResComm );

                     	            ((_LMACTIONSINRETR * )pMessage)->HdrCU2235F.KyPremNo =
                     	            ((_LMACTIONSINRETR * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo;

                     	            ((_LMACTIONSINRETR * )pMessage)->HdrCU0237S.KyPremNo =
                     	            ((_LMACTIONSINRETR * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo;

                     	            ((_LMACTIONSINRETR * )pMessage)->HdrCU0237S.KyBa =
                   		            ((_LMACTIONSINRETR * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                     	            ((_LMACTIONSINRETR * )pMessage)->HdrCU0101P35.KyPremNo =
                     	            ((_LMACTIONSINRETR * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo;

                     	            ((_LMACTIONSINRETR * )pMessage)->HdrCU0469A.KyPremNo =
                     	            ((_LMACTIONSINRETR * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo;

						            ((_LMACTIONSINRETR * )pMessage)->HdrCumacQy.KyPremNo =
						             ((_LMACTIONSINRETR * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo;
                                }
                             }



                           /**************************************************************
                           **
                           **   CUCR031A - CUCL01
                           **
                           *************************************************************/
                            #include "CUCR031A.H"

                            if ( strncmp( MsgPB.translation.map_name, "CUCR031A", 8 ) == 0 )
				            {
					            _CUCR031A *pCUCR031A;
					            pCUCR031A = (_CUCR031A * ) pMessage;

					            sscanf( Value, "%d %s", 
					            &((_CUCR031A * )pMessage)->
                                MainCutlistGroup.HdrCutlist.HdrCu0246A.CdCo,

					            &((_CUCR031A * )pMessage)->
                                MainCutlistGroup.HdrCutlist.HdrCu0246A.CdOperCntr);
                            
                            }

            //                   sscanf( Value, "%c, %d, %d, %c, %c, %c, %d, %d, %s, %s, %c",
            //
            //                     &((_CUCR031A * )pMessage)->StandardHeader.DtCurrDate,
            //                     &((_CUCR031A * )pMessage)->MainCutlistGroup.HdrCutlist.HdrCu0246A.AtOrigNtcTot,
            //                     &((_CUCR031A * )pMessage)->MainCutlistGroup.HdrCutlist.HdrCu0246A.KyBa,
            //                     &((_CUCR031A * )pMessage)->MainCutlistGroup.HdrCutlist.HdrCu0246A.CdOperCntr,
            //                     &((_CUCR031A * )pMessage)->MainCutlistGroup.HdrCutlist.HdrCu0246A.CdBAClassificatn,
            //                     &((_CUCR031A * )pMessage)->MainCutlistGroup.HdrCutlist.HdrCu0246A.CdBaStat,
            //                     &((_CUCR031A * )pMessage)->MainCutlistGroup.HdrCutlist.HdrCu0246A.AtMinPastDue,
            //                     &((_CUCR031A * )pMessage)->MainCutlistGroup.HdrCutlist.HdrCu0246A.AtMaxPastDue,
            //                     &((_CUCR031A * )pMessage)->MainCutlistGroup.HdrCutlist.HdrCu0246A.QyMinDyPDue,
            //                     &((_CUCR031A * )pMessage)->MainCutlistGroup.HdrCutlist.HdrCu0246A.QyMaxDyPDue,
            //                     &((_CUCR031A * )pMessage)->MainCutlistGroup.HdrCutlist.HdrCu0246A.CdBankLiqRecvr );
                                }


                             }



            	            /**************************************************************
               	            **
               	            **   CUCR097I
               	            **
               	            **************************************************************/
                            #include "CUCR097I.H"

				            _CUCR097I *pCUCR097I;
				            pCUCR097I = (_CUCR097I * ) pMessage;

                            if ( strncmp( MsgPB.translation.map_name, "CUCR097I", 8 ) == 0 )
                            {
					            _CUCR097I *pCUCR097I;
					            pCUCR097I = (_CUCR097I * ) pMessage;

					            if ( strncmp (lfunctioncode, "02", 8) == 0 )
                                {
                   		            sscanf( Value, "%lf %d %d", &((_CUCR097I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
                   		            &((_CUCR097I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqBa,
                     	            &((_CUCR097I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqBaAim);

                       	            ((_CUCR097I * )pMessage)->HdrCU0501C.KyBa =
                       	            ((_CUCR097I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                       	            ((_CUCR097I * )pMessage)->HdrCU0502H.KyBa =
                       	            ((_CUCR097I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;
                                }
                             }



    			            /**************************************************************
				            **
				            **   CUCR033I (CUCL03)
				            **
				            **************************************************************/
                            #include "CUCR033I.H"

                            if ( strncmp( MsgPB.translation.map_name, "CUCR033I", 8 ) == 0 )
                            {
					            _CUCR033I *pCUCR033I;
					            pCUCR033I = (_CUCR033I * ) pMessage;

                                if ( strncmp (lfunctioncode, "01", 8) == 0 )
                                {
						            sscanf( Value, "%lf %ld %ld %ld",
                     	            &((_CUCR033I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
                     	            &((_CUCR033I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo,
                     	            &((_CUCR033I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqBa,
                     	            &((_CUCR033I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqBaAim);

                                   ((_CUCR033I * )pMessage)->HdrCU0201R.KyBa =
                                   ((_CUCR033I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                   ((_CUCR033I * )pMessage)->HdrCU0234G.KyBa =
                                   ((_CUCR033I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                      	            ((_CUCR033I * )pMessage)->HdrCU0234G.KyCustNo =
                      	            ((_CUCR033I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;

                      	            ((_CUCR033I * )pMessage)->HdrCU0231A.KyBa =
                      	            ((_CUCR033I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;


                      	            ((_CUCR033I * )pMessage)->HdrCU0306E.KyBa =
                      	            ((_CUCR033I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;


                      	            ((_CUCR033I * )pMessage)->HdrCU0307B.KyBa =
                      	            ((_CUCR033I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                      	            ((_CUCR033I * )pMessage)->HdrCU0307B.KyCustNo =
                      	            ((_CUCR033I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;

                      	            ((_CUCR033I * )pMessage)->HdrCU0229E.KyBa =
                      	            ((_CUCR033I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;
                 	            }
                             }


/******************************************************************************************
CUCL03 - CUCL023I
Maintain Collection Arrangements
Begin
******************************************************************************************/
    			            /**************************************************************
				            **
				            **   CUCL03 - CUCL023I
                            **   Maintain Collection Arrangements
				            **
				            **************************************************************/
                            #include "CUCL023I.H"

				            //*   CUCL03 Collection Arrangement LUW  *//

				            if ( strncmp( MsgPB.translation.map_name, "CUCL023I", 8 ) == 0 )
                            {
					            _CUCL023I *pCUCL023I;
					            pCUCL023I = (_CUCL023I * ) pMessage;

                                WriteFile = TRUE;

					            if ( strncmp (lfunctioncode, "01", 8) == 0 )
                                {
						            sscanf( Value, "%lf %ld %ld %ld",
                                    &CurrentKyBa,
                                    &CurrentKyCustNo,
                                    &((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqBa,
						            &((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.NoLockSeqBaAim);

						            ((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa = CurrentKyBa;
						            ((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo = CurrentKyCustNo;


                                    ((_CUCL023I * )pMessage)->HdrCu0231A.KyBa =
                                    ((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                    ((_CUCL023I * )pMessage)->HdrCu0234H.KyBa =
                                    ((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                    ((_CUCL023I * )pMessage)->HdrCu0234H.KyCustNo =
                                    ((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;

                                    ((_CUCL023I * )pMessage)->HdrCu0238A.KyBa =
                                    ((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                    ((_CUCL023I * )pMessage)->HdrCu0238A.KyCustNo =
                                    ((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;

                                    ((_CUCL023I * )pMessage)->HdrCu0307O.KyCustNo =
                                    ((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;

                                    ((_CUCL023I * )pMessage)->HdrCu0307O.KyBa =
                                    ((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                    ((_CUCL023I * )pMessage)->HdrCu1201M.KyBa =
                                    ((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                    ((_CUCL023I * )pMessage)->HdrCu0229A.KyBa =
                                    ((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                    ((_CUCL023I * )pMessage)->HdrCUMCC001.KyCustNo =
                                    ((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;

                                    ((_CUCL023I * )pMessage)->HdrCU0229D.KyBa =
                                    ((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                    ((_CUCL023I * )pMessage)->HdrCU0231B.KyBa =
                                    ((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                    ((_CUCL023I * )pMessage)->HdrCU0234D.KyBa =
                                    ((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                    ((_CUCL023I * )pMessage)->HdrCU0234D.KyCustNo =
                                    ((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;

                                    ((_CUCL023I * )pMessage)->HdrCU0238D.KyBa =
                                    ((_CUCL023I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;
                               
                                    if(( CurrentKyBa == PreviousKyBa) || 
                                       ( CurrentKyCustNo == PreviousKyCustNo))
                                    {
                                        WriteFile = FALSE;
                                    }
                                    
                                    PreviousKyBa = CurrentKyBa;
                                    PreviousKyCustNo = CurrentKyCustNo;
                                
                                }
                            }    
/******************************************************************************************
End
******************************************************************************************/

    			            /**************************************************************
				            **
				            **   CUCR034I
				            **
				            **************************************************************/
                            #include "CUCR034I.H"

                            if ( strncmp( MsgPB.translation.map_name, "CUCR034I", 8 ) == 0 )
                            {
					            //_CUCR034I *pCUCR034I;
					            ////pCUCR034I = (_CUCR034I * ) pMessage;

					            //*   CUCL07  Retrieval  *//

					            if ( strncmp (lfunctioncode, "01", 8) == 0 )
					            {
						            sscanf( Value, "%lf %ld",
						            &((_CUCR034I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
						            &((_CUCR034I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo );

                                   ((_CUCR034I * )pMessage)->HdrCU0301E.KyCustNo =
                                   ((_CUCR034I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;

                                   ((_CUCR034I * )pMessage)->HdrCU0307I.KyBa =
                                   ((_CUCR034I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                   ((_CUCR034I * )pMessage)->HdrCU0307I.KyCustNo =
                                   ((_CUCR034I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;

                                   ((_CUCR034I * )pMessage)->HdrCU0238F.KyBa =
                                   ((_CUCR034I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                   ((_CUCR034I * )pMessage)->HdrCU0234K.KyBa =
                                   ((_CUCR034I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                   ((_CUCR034I * )pMessage)->HdrCU0234K.KyCustNo =
                                   ((_CUCR034I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;

                                   ((_CUCR034I * )pMessage)->HdrCU0204K.KyBa =
                                   ((_CUCR034I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                   ((_CUCR034I * )pMessage)->HdrCU0601T.KyBa =
                                   ((_CUCR034I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                   ((_CUCR034I * )pMessage)->HdrCU0601T.KyCustNo =
                                   ((_CUCR034I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;

                                   ((_CUCR034I * )pMessage)->HdrCU0201I.KyBa =
                                   ((_CUCR034I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                   ((_CUCR034I * )pMessage)->HdrCU1501A.KyBa =
                                   ((_CUCR034I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                   ((_CUCR034I * )pMessage)->HdrCU1501A.KyCustNo =
                                   ((_CUCR034I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;
                                }
                             }



                           /**************************************************************
                           **
                           **   CUCL024I
                           **
                           **************************************************************/
                            #include "CUCL024I.H"

                            if ( strncmp( MsgPB.translation.map_name, "CUCL024I", 8 ) ==
                                0 )
                            {

                             _CUCL024I *pCUCL024I;

                            pCUCL024I = (_CUCL024I * ) pMessage;




                         //*   CUCL07  LUW  *//


                               sscanf( Value, "%lf %ld %ld",

                                 &((_CUCL024I * )pMessage)->HdrCUSO414.KyBa,
                                 &((_CUCL024I * )pMessage)->HdrCUSO414.KyCustNo,
                                 &((_CUCL024I * )pMessage)->HdrCUSO414.KyPremNo );



                                   ((_CUCL024I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa
                                 = ((_CUCL024I * )pMessage)->HdrCUSO414.KyBa;

                                   ((_CUCL024I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo
                                 = ((_CUCL024I * )pMessage)->HdrCUSO414.KyCustNo;

                                   ((_CUCL024I * )pMessage)->HdrCU0238A.KyBa
                                 = ((_CUCL024I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;

                                   ((_CUCL024I * )pMessage)->HdrCU0238A.KyCustNo
                                 = ((_CUCL024I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo;
                            }



    			            /************************************************
				            **
				            **   CU0238AM (GENERIC SERVICE) -  CUCL09
				            **
				            *************************************************/
                            #include "CU0238AM.H"

				            if ( strncmp( MsgPB.translation.map_name, "CU0238AM", 8 ) == 0 )
                            {
					            _COLACTIVTMAPREC *pCOLACTIVTMAPREC;
					            pCOLACTIVTMAPREC = (_COLACTIVTMAPREC * ) pMessage;

					            sscanf( Value, "%lf",
					            &((_COLACTIVTMAPREC *)pMessage)->Cu0238aHiKey.AlrKeyGroup.PkeyCollActvty.KeyBsSeq.KyBa);

					            ((_COLACTIVTMAPREC *)pMessage)->Cu0238alLoKey.AlrKeyGroup.PkeyCollActvty.KeyBsSeq.KyBa =
					            ((_COLACTIVTMAPREC *)pMessage)->Cu0238aHiKey.AlrKeyGroup.PkeyCollActvty.KeyBsSeq.KyBa;
                            }



                           /**************************************************************
                           **
                           **   CUCR089I
                           **
                           **************************************************************/
                            #include "CUCR089I.H"

                            if ( strncmp( MsgPB.translation.map_name, "CUCR089I", 8 ) == 0 )
                            {

             		            //*   CUEE25 SELECT PROGRAM *//
                	            _CUCR089I *pCUCR089I;

                	            pCUCR089I = (_CUCR089I * ) pMessage;

                                if ( strncmp (lfunctioncode, "01", 8) == 0 )
                                {
                   		            sscanf( Value, "%lf %ld %ld",
                                    &((_CUCR089I * )pMessage)->HdrCU2214C.KyBa,
                     	            &((_CUCR089I * )pMessage)->HdrCU2214C.KyPremNo,
                     	            &((_CUCR089I * )pMessage)->HdrCU2214C.KyBldgNo );
                                }
                            }



    			            /**************************************************************
				            **
				            **   CUSO34 - CUCR070A  ENTER R/D FIELD DATA
				            **
				            **************************************************************/
                            #include "CUCR070A.H"

				            _CUCR070I *pCUCR070I;
				            pCUCR070I = (_CUCR070I * ) pMessage;

				            if ( strncmp( MsgPB.translation.map_name, "CUCR070A", 8 ) == 0 )
                            {
					            
					            if ( strncmp (lfunctioncode, "34", 8) == 0 )
					            {
						            sscanf( Value, "%ld",
						            &((_CUCR070I * )pMessage)->I1Layout.HdrCU0909A.KyFordNo );
					            }
					            if ( strncmp (lfunctioncode, "19", 8) == 0 )
					            {
						            sscanf( Value, "%ld",
						            &((_CUCR070I * )pMessage)->I1Layout.HdrCU0909A.KyFordNo );
					            }

				            }



            	            /**************************************************************
               	            **
               	            **   CUCR025I
               	            **
               	            **************************************************************/
                            #include "CUCR025I.H"

                            _CUCR025I *pCUCR025I;
                            pCUCR025I = (_CUCR025I * ) pMessage;

                            if ( strncmp( MsgPB.translation.map_name, "CUCR025I", 8 ) == 0 )
                            {
					            //*   CUAR09 VIEW TRANSFER HISTORY *//

                                if ( strncmp (lfunctioncode, "01", 8) == 0 )
                                {
						            sscanf( Value, "%lf %lf",
						            &((_CUCR025I * )pMessage)->HdrCU02Tb07A.KyBa,
                     	            &((_CUCR025I * )pMessage)->HdrCU02Tb07A.KyBaTrnsfrTo );
					            }
				            }



    			            /**************************************************************
				            **
				            **   CUCR026I
				            **
				            **************************************************************/
                            #include "CUCR026I.H"

				            _CUCR026I *pCUCR026I;
				            pCUCR026I = (_CUCR026I * ) pMessage;

				            if ( strncmp( MsgPB.translation.map_name, "CUCR026I", 8 ) == 0 )
				            {

					            //*   CUAR14 POST RETURNED ITEM *//

					            if ( strncmp (lfunctioncode, "03", 8) == 0 )
                                {
						            sscanf( Value, "%lf %ld",
						            &((_CUCR026I * )pMessage)->HdrCU0307B.KyBa,
						            &((_CUCR026I * )pMessage)->HdrCU0307B.KyCustNo );

						            ((_CUCR026I * )pMessage)->HdrCU0201C.KyBa =
						            ((_CUCR026I * )pMessage)->HdrCU0307B.KyBa;

						            ((_CUCR026I * )pMessage)->HdrCU0204A.KyBa =
						            ((_CUCR026I * )pMessage)->HdrCU0307B.KyBa;

						            ((_CUCR026I * )pMessage)->HdrCU0204J.KyBa =
						            ((_CUCR026I * )pMessage)->HdrCU0307B.KyBa;

						            ((_CUCR026I * )pMessage)->HdrCU0201P.KyCustNo =
						            ((_CUCR026I * )pMessage)->HdrCU0307B.KyCustNo;

						            ((_CUCR026I * )pMessage)->HdrCU0201I.KyBa =
						            ((_CUCR026I * )pMessage)->HdrCU0307B.KyBa;
					            }

					            //*   CUAR20 REQUEST ACCOUNT ACTIVITY STATEMENT *//

					            if ( strncmp (lfunctioncode, "04", 8) == 0 )
                                {
						            sscanf( Value, "%lf %ld",
						            &((_CUCR026I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa,
						            &((_CUCR026I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo );

						            ((_CUCR026I * )pMessage)->HdrCU0204A.KyBa =
						            ((_CUCR026I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa;
					            }
				            }


    			            /**************************************************************
				            **
				            **   CUCR009I - CUEL01
				            **
				            **************************************************************/
                            #include "CUCR009I.H"

				            //** CUEL01 ELECTRIC TROUBLE RETRIEVAL **//

				            if ( strncmp( MsgPB.translation.map_name, "CUCR009I", 8 ) == 0 )
				            {
					            _CUCR009I *pCUCR009I;
					            pCUCR009I = (_CUCR009I * ) pMessage;

                                WriteFile = TRUE;

					            if ( strncmp (lfunctioncode, "01", 8) == 0 )
					            {
						            sscanf( Value, "%ld %ld %s",
                                    &CurrentKyCustNo,
                                    &CurrentKyPremNo,
						            &((_CUCR009I * )pMessage)->HdrTA320000.CdOperCntr);
            		                
                                    ((_CUCR009I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo = CurrentKyPremNo;
                                    ((_CUCR009I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo = CurrentKyCustNo;

						            ((_CUCR009I * )pMessage)->HdrCU01019.KyPremNo =
						            ((_CUCR009I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo;

						            ((_CUCR009I * )pMessage)->HdrDemis.KyPremNo =
						            ((_CUCR009I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo;

                                    if(( CurrentKyPremNo == PreviousKyPremNo) || 
                                       ( CurrentKyCustNo == PreviousKyCustNo))
                                    {
                                        WriteFile = FALSE;
                                    }
                                
                                    PreviousKyPremNo = CurrentKyPremNo;
                                    PreviousKyCustNo = CurrentKyCustNo;

					            }
				            }



    			            /**************************************************************
				            **
				            **   CUCL006I
				            **
				            **************************************************************/
                            #include "CUCL006I.H"

				            if ( strncmp( MsgPB.translation.map_name, "CUCL006I", 8 ) == 0 )
				            {

					            //*   CUEL01 ISSUE ELECTRIC TROUBLE LUW  *//

					            _CUCL006I *pCUCL006I;
					            pCUCL006I = (_CUCL006I * ) pMessage;

                                WriteFile = TRUE;

					            if ( strncmp (lfunctioncode, "01", 8) == 0 )
					            {
						            sscanf( Value, "%lf %ld %ld %ld %s %ld %s %s %s",
                                    &CurrentKyBa,
                                    &CurrentKyCustNo,
                                    &CurrentKyPremNo,
                    	            &((_CUCL006I * )pMessage)->HdrTA320000.CdCo,
                    	            &((_CUCL006I * )pMessage)->HdrTA320000.CdOperCntr,
                                    &((_CUCL006I * )pMessage)->HdrCU0457B.KyBldgNo,
                                    &((_CUCL006I * )pMessage)->HdrTA320000.KyGwa,
                                    &((_CUCL006I * )pMessage)->HdrTA320000.CdLocationType,
                                    &((_CUCL006I * )pMessage)->HdrTA320000.KyLocationId);
                                
            		                ((_CUCL006I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyBa = CurrentKyBa;
                                    ((_CUCL006I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo = CurrentKyPremNo;
                                    ((_CUCL006I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyCustNo = CurrentKyCustNo;

                                    if(( CurrentKyPremNo == PreviousKyPremNo) || 
                                       ( CurrentKyCustNo == PreviousKyCustNo) ||
                                       ( CurrentKyBa     == PreviousKyBa))
                                    {
                                        WriteFile = FALSE;
                                    }
                                
                                    PreviousKyPremNo = CurrentKyPremNo;
                                    PreviousKyCustNo = CurrentKyCustNo;
                                    PreviousKyBa     = CurrentKyBa;
                                
                                }
                             }



    			            /**************************************************************
				            **
				            **   CUCR020I
				            **
				            **************************************************************/
                            #include "CUCR020I.H"

				            if ( strncmp( MsgPB.translation.map_name, "CUCR020I", 8 ) == 0 )
				            {
					            //*   CUEE11 MAINTAIN RECOMMENDATIONS  *//
   
					            _CUCR020I *pCUCR020I;
					            pCUCR020I = (_CUCR020I * ) pMessage;

					            if ( strncmp (lfunctioncode, "01", 8) == 0 )
                                {
						            sscanf( Value, "%ld %c %l %s %c",
                    	            &((_CUCR020I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
                    	            &((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2204A.CdBus,
                    	            &((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2204A.CdProd,
                    	            &((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2204A.NoProdSequence,
                    	            &((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2204A.NoRecommendDtl);

						            ((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2204A.KyPremNo =
						            ((_CUCR020I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo;

						            ((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2229A.KyPremNo =
						            ((_CUCR020I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo;

                     	            strcpy(((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2229A.CdBus,
                                    ((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2204A.CdBus);

						            ((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2229A.CdProd =
                    	            ((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2204A.CdProd;

						            ((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2229A.NoProdSequence =
						            ((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2204A.NoProdSequence;

                    	            ((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2223A.KyPremNo =
                    	            ((_CUCR020I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo;

                     	            strcpy(((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2223A.CdBus,
                                    ((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2204A.CdBus);

						            ((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2223A.CdProd =
						            ((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2204A.CdProd;

						            ((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2223A.NoProdSequence =
						            ((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2204A.NoProdSequence;

                                }
                  	            /* CUEE04 */
					            if ( strncmp (lfunctioncode, "05", 8) == 0 )
                                {
						            sscanf( Value, "%ld %c %l %s %c",
						            &((_CUCR020I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo,
						            &((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2223A.CdBus,
                    	            &((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2223A.CdProd,
                    	            &((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2223A.NoProdSequence );

                     	            ((_CUCR020I * )pMessage)->HdrCU2214A.NoProdSequence =
                     	            ((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2223A.NoProdSequence;

						            ((_CUCR020I * )pMessage)->HdrCU2214A.KyPremNo =
						            ((_CUCR020I * )pMessage)->StandardHeader.StndrdHeadSubgrp.KyPremNo;

						            strcpy(((_CUCR020I * )pMessage)->HdrCU2214A.CdBus,
                                    ((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2223A.CdBus);

						            ((_CUCR020I * )pMessage)->HdrCU2214A.CdProd =
						            ((_CUCR020I * )pMessage)->HdrMainRec.HdrRec.HdrCU2223A.CdProd;
					            }
				            }




/******************************************************************************************
CUDS02 - CUCL054E
Release Order LUW CUDS02
Begin
******************************************************************************************/
                          /**************************************************************
                          **
                          **   CUCL054I - Release Order LUW CUDS02
                          **
                          *************************************************************/
        
                          #include "CUCL054E.H"

                          if ( strncmp( MsgPB.translation.map_name, "CUCL054E", 8 ) == 0 )
                          {
                              _CUCL054E *pCUCL054E;
                              pCUCL054E = (_CUCL054E * ) pMessage;

                              sscanf( Value, "%ld %ld %s",
                              &((_CUCL054E * )pMessage)->CUCL054Common.DatFuncProcFl[0].KyFordNo,
                              &((_CUCL054E * )pMessage)->CUCL054Common.DatFuncProcFl[0].NoLockSeqFoHdr,
                              &((_CUCL054E * )pMessage)->CUCL054Common.DatFuncProcFl[0].CdFordType);


                          } 
/******************************************************************************************
End
******************************************************************************************/


                          /**************************************************************
                          **
                          **   CUCR056I - Release Order CUDS02
                          **
                          *************************************************************/
                          
                          #include "CUCR056I.H"

                          if ( strncmp( MsgPB.translation.map_name, "CUCR056I", 8 ) == 0 )
                          {
                              _CUCR056I *pCUCR056I;
                              pCUCR056I = (_CUCR056I * ) pMessage;


                              if ( strncmp (lfunctioncode, "01", 8) == 0 )
                              {
                                  sscanf( Value, "%s",

                                  &((_CUCR056I * )pMessage)->DatRelFord.TxKyFordNoCat);


                               }
                           } 
    			            /**************************************************************
      			            **
      			            **   CUCR118I - CASH INTERFACE SII - RETRIEVAL
      			            **
      			            **************************************************************/
                            #include "CUCR118I.H"

      			            if ( strncmp( MsgPB.translation.map_name, "CUCR118I", 8 ) == 0 )
           		            {
            		            _SIIRETRIEVAL *pCUCR118I;
            		            pCUCR118I = (_SIIRETRIEVAL * ) pMessage;

            		            sscanf( Value, "%s",
            		            &((_SIIRETRIEVAL * )pMessage)->CustomerInfo.KySiiAcctNo);

           		            }

    			            /**************************************************************
      			            **
      			            **   CUCL112I - CASH INTERFACE SII - UPDATE
      			            **
      			            **************************************************************/
                            #include "CUCL112I.H"

      			            if ( strncmp( MsgPB.translation.map_name, "CUCL112I", 8 ) == 0 )
           		            {
            		            _SIILUW *pCUCL112I;
            		            pCUCL112I = (_SIILUW * ) pMessage;

            		            sscanf( Value, "%s",
            		            &((_SIILUW * )pMessage)->ScsCash.TransactionDetail[0].KySiiAcctNo);

           		            }


/***********************************************************************
*                             END OF FILE
***********************************************************************/
