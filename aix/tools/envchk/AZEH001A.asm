         TITLE 'DETERMINE WHAT ENVIRONMENT  YOU ARE RUNNING IN'         
*---------------------------------------------------------------------  
* FOR THE CSS PROJECT.                                                  
*                                                                       
*  A "B" WILL BE SENT BACK IF IT IS TSO, STARTED TASK, OR BATCH.        
*     -                                                                 
*     NOTE: SMARTTEST RUNS UNDER TSO, SO A C WILL BE PLACED IN THE      
*           RETURN TO INDICATE CICS.                                    
*                                                                       
*  A "C" WILL BE SENT BACK IF IT IS CICS.                               
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
R10      EQU   10                                                       
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
         L     R6,PSAAOLD             --> ASCB                          
         DROP  R2                                                       
         USING ASCB,R6                                                  
*---------------------------------------------------------------------  
         L     R4,ASCBJBNI           --> JOBNAME FIELD                  
         LTR   R4,R4                 ANY ADDRESS ?                      
         BNZ   BATCH                   YES, ITS A JOB                   
         L     R4,ASCBJBNS            --> STARTED TASK OR TSO           
         B     BATCH            CHECK FOR CICS JOB.                     
*---------------------------------------------------------------------  
BATCH    DS    0H                                                       
         LA    R5,CICSTBL              POINT TO THE CICS JOBNAME TABLE  
         CLC   0(2,R4),=C'TC'          IS IT A TC PREFIX JOB ?          
         BNE   BATCHJOB                NO IT MUST BE BATCH.             
CICSLOOP DS    0H                                                       
         CLC   0(8,R5),0(R4)          IS IT A CICS JOBNAME ?            
         BE    CICS                   YES - GO TO CICS                  
         CLC   0(3,R5),=XL3'FFFFFF'   AT END OF TABLE ?                 
         BE    BATCHJOB               YES - WE ARE IN BATCH MODE.       
         LA    R5,8(R5)               BUMP REG 5 TO NEXT JOBNAME        
         B     CICSLOOP               GO CHECK NEXT JOBNAME             
BATCHJOB DS    0H                     IN BATCH MODE.                    
         MVC   ANSWER(1),=C'B'        BATCH                             
         B     EOJ                                                      
*---------------------------------------------------------------------  
CICS     DS    0H                                                       
         MVC   ANSWER(1),=C'C'        CICS                              
         B     EOJ                                                      
*---------------------------------------------------------------------  
ANSWER   DS    CL1               FLAG TO TELL WHAT ENVIRONMENT          
EOJ      DS    0H                                                       
         LR      R1,R7           RESTORE PARAMETER ADDRESS              
         L       R1,0(R1)        PICKUP FIELD ADDRESS                   
         MVC     0(1,R1),ANSWER  POINT TO THE ANSWER                    
         XR      R15,R15         ZERO RETURN CODE                       
         SUBEXIT RC=(R15)                                               
*---------------------------------------------------------------------  
*                                                                       
*---------------------------------------------------------------------  
CICSTBL  DS    0H                                                       
         DC    CL8'TC101ROP'     PRODUCTION REGIONS                     
         DC    CL8'TC102ROP'                                            
         DC    CL8'TC103ROP'                                            
         DC    CL8'TC104ROP'                                            
         DC    CL8'TC105ROP'                                            
         DC    CL8'TC106ROP'                                            
         DC    CL8'TC107ROP'                                            
         DC    CL8'TC108ROP'                                            
         DC    CL8'TC109ROP'                                            
         DC    CL8'TC110ROP'                                            
         DC    CL8'TC111ROP'                                            
         DC    CL8'TC112ROP'                                            
         DC    CL8'TC113ROP'                                            
         DC    CL8'TC114ROP'                                            
         DC    CL8'TC115ROP'                                            
         DC    CL8'TC116ROP'                                            
         DC    CL8'TC117ROP'                                            
         DC    CL8'TC118ROP'                                            
         DC    CL8'TC119ROP'                                            
         DC    CL8'TC120ROP'                                            
*                                                                       
         DC    CL8'TC201ROT'     TEST REGIONS                           
         DC    CL8'TC202ROT'                                            
         DC    CL8'TC203ROT'                                            
         DC    CL8'TC204ROT'                                            
         DC    CL8'TC205ROT'                                            
         DC    CL8'TC206ROT'                                            
         DC    CL8'TC207ROT'                                            
         DC    CL8'TC208ROT'                                            
         DC    CL8'TC209ROT'                                            
         DC    CL8'TC210ROT'                                            
         DC    CL8'TC211ROT'                                            
         DC    CL8'TC212ROT'                                            
         DC    CL8'TC213ROT'                                            
         DC    CL8'TC214ROT'                                            
         DC    CL8'TC215ROT'                                            
         DC    CL8'TC216ROT'                                            
         DC    CL8'TC217ROT'                                            
         DC    CL8'TC218ROT'                                            
         DC    CL8'TC219ROT'                                            
         DC    CL8'TC220ROT'                                            
*                                                                       
         DC    CL8'TC301ROT'     MAINTENANCE REGIONS                    
         DC    CL8'TC302ROT'                                            
         DC    CL8'TC303ROT'                                            
         DC    CL8'TC304ROT'                                            
         DC    CL8'TC305ROT'                                            
         DC    CL8'TC306ROT'                                            
         DC    CL8'TC307ROT'                                            
         DC    CL8'TC308ROT'                                            
         DC    CL8'TC309ROT'                                            
         DC    CL8'TC310ROT'                                            
         DC    CL8'TC311ROT'                                            
         DC    CL8'TC312ROT'                                            
*                                                                       
         DC    XL3'FFFFFF'       END OF CICSTBL                         
         END                                                            
