         TITLE 'DETERMINE WHAT ENVIRONMENT  YOU ARE RUNNING IN'      
*---------------------------------------------------------------------
* FOR THE CSS PROJECT.                                               
*                                                                    
* INPUT:                                                            
*     NONE                                                           
*                                                                   
* OUTPUT:                                                          
*    "B" IF PROGRAM CALLED FROM BATCH.                            
*    "C" IF PROGRAM CALLED FROM CICS.                                
*     -                                                             
*                                                                    
*  THIS PROGRAM IS CALLED FROM BOTH BATCH AND ONLINE APPLICATIONS.   
*  IT RETURNS A "B" OR "C" TO TELL THE CALLING APPLICATION WHETHER   
*  IT IS BEING CALLED FROM A BATCH APPLICATION OR FROM CICS.         
*                                                                   
*  FIELDS IN THE ADDRESS SPACE CONTROL BLOCK ARE USED TO DETERMINE   
*   IF BATCH OR ONLINE.                                              
*                                                                    
*     NOTE: SMARTTEST RUNS UNDER TSO, SO A C WILL BE PLACED IN THE   
*           RETURN TO INDICATE CICS.                                 
*                                                                    
* IF A CHANGE IS MADE TO THIS PROGRAM IT SHOULD BE LINKED INTO       
* BOTH THE BATCH AND ONLINE LOAD LIBRARIES.                          
*                                                                    
*                                                                    
* THE PROGRAM USES TWO MACROS SUBENTRY AND SUBEXIT. THE LIBRARY      
*  CONTAINING THESE MACROS SHOULD BE INCLUDED IN THE ASSEMBLY        
* JCL AND POINTED TO BY THE SYSLIB DD STATEMENT.                     
*                                                                    
*                                                                    
*                                                                    
*     -                                                              
*(c) COPYRIGHT 1995 ANDERSEN CONSULTING - ALL RIGHTS RESERVED.       
*THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.     
*--------------------------------------------------------------------- 
AZEH001A START 0                                                      
AZEH001A AMODE 31                                                     
AZEH001A RMODE ANY                                                    
R0       EQU   0                                                      
R1       EQU   1                            *EQUATE REGISTERS         
R2       EQU   2                                                      
R3       EQU   3                                                      
R4       EQU   4                                                      
R5       EQU   5                                                      
R6       EQU   6                                                        
R7       EQU   7                                                       
R8       EQU   8                                                       
R9       EQU   9                                                       
BASE1    EQU   10                                                      
R11      EQU   11                                                      
R12      EQU   12                                                      
R13      EQU   13                                                      
R14      EQU   14                                                      
R15      EQU   15                                                      
*--------------------------------------------------------------------- 
CVTMAP   CVT DSECT=YES,LIST=YES                                        
*--------------------------------------------------------------------- 
         IHAASCB LIST=YES                                              
*--------------------------------------------------------------------- 
         IHAASSB LIST=YES                                              
*--------------------------------------------------------------------- 
         IHAPSA  DSECT=YES                                             
*---------------------------------------------------------------------
         IHASTCB                                                       
*--------------------------------------------------------------------- 
         IKJTCB  DSECT=YES                                             
*--------------------------------------------------------------------- 
         IAZJSAB DSECT=YES                                             
*--------------------------------------------------------------------- 
         PRINT GEN                                                     
AZEH001A SUBENTRY BASES=(10)          SET BASE REGISTER R10            
*--------------------------------------------------------------------- 
         LR    R7,R1                  SAVE REGISTER 1                  
*--------------------------------------------------------------------- 
         L     R2,=F'0'       ADDRESS 0--> ADDRESS OF PSA              
         USING PSA,R2                                                 
*--------------------------------------------------------------------- 
         L     R6,PSAAOLD             --> MAP TO THE ASCB              
         DROP  R2                                                      
         USING ASCB,R6                                                 
*--------------------------------------------------------------------- 
         L     R4,ASCBJBNI           --> JOBNAME FIELD                 
         LTR   R4,R4                 ANY ADDRESS ?                     
         BNZ   BATCH                   YES, ITS A JOB                  
         B     CICS                     NO, ITS CICS                   
*--------------------------------------------------------------------- 
BATCH    DS    0H                                                      
         CLC   0(4,R4),=XL4'00000000'  CICS ?                          
         BE    CICS                   YES - WE ARE IN CICS MODE.       
         CLC   0(4,R4),=CL3'CIC'       CICS ?                          
         BE    CICS                   YES - WE ARE IN CICS MODE.       
*--------------------------------------------------------------------- 
BATCHJOB DS    0H                     SET BATCH INDICATOR "B"          
         MVC   ANSWER(1),=C'B'        AND EXIT                         
         B     EOJ                                                     
*--------------------------------------------------------------------- 
CICS     DS    0H                     SET CICS INDICATOR  "C"          
         MVC   ANSWER(1),=C'C'        AND EXIT.                        
         B     EOJ                                                     
*--------------------------------------------------------------------- 
SAVEA    DS    18F                                                     
ANSWER   DS    CL1               FLAG TO TELL WHAT ENVIRONMENT         
EOJ      DS    0H                                                      
         LR      R1,R7           RESTORE PARAMETER ADDRESS             
         L       R1,0(R1)        PICKUP FIELD ADDRESS                  
         MVC     0(1,R1),ANSWER  POINT TO THE ANSWER                   
         XR      R15,R15         ZERO RETURN CODE                      
         SUBEXIT RC=(R15)                                              
**       LTORG                                                         
*--------------------------------------------------------------------- 
*                                                                      
*--------------------------------------------------------------------- 
         END                                                           
