/**************************************************************/
/*                                                            */
/*   #DEFINES                                                 */
/*                                                            */
/**************************************************************/

#define LINESIZE             250

#define PATH_LEN             400

#define FILE_LEN             25

#define	ERRFILE		     "ERROR.txt"

#define ERROR                2

#define SUCCESS              0

#define EXTERNAL	     "EXTERNAL"

#define EXTERNAL_LEN	     8

#define UT_S_   	     "ASSIGN TO UT-S-"

#define ASSIGN		     "ASSIGN"

#define CON_DBLQUOTE_CM      "      -    '',"

#define CON_SNGQUOTE   	     "      -    '"

#define CON_DBLQUOTE_CM_LEN  14

#define CON_SNGQUOTE_LEN     12

#define CON_DBLQUOTE_PR      "      -    ''."

#define CON_DBLQUOTE_PR_LEN  14

#define BLANK_SPACES   	     "              "

#define BLANK_SPACES2  	     "           "

#define OLD_SOURCE	     "SOURCE-COMPUTER"

#define OLD_SOURCE_LEN	     15

#define OLD_OBJECT	     "OBJECT-COMPUTER"

#define OLD_OBJECT_LEN	     15

#define	NEW_SOURCE	     "       SOURCE-COMPUTER. IBM-ES-9000-820.\n"

#define	NEW_OBJECT	     "       OBJECT-COMPUTER. IBM-ES-9000-820.\n"

#define	EXEC_BEGIN	     "EXEC SQL BEGIN DECLARE SECTION END-EXEC."

#define EXEC_END	     "EXEC SQL END DECLARE SECTION END-EXEC."

#define HEADER		     "      * MVS PORT-- CODE RUN THROUGH PROCESSOR\n"

#define HEADER2		     "      *            on %s\n"

#define REPROCESS	     "      * TRYING TO PROCESS THE FILE TWICE.\n"
 
#define MEM_ERROR            "\nMemory allocation failed.\n"

#define BEGIN_UNCOMMENT	     "      *MVS PORT-- BEGIN MVS"

#define	END_UNCOMMENT	     "      *MVS PORT-- END MVS"

#define BEGIN_COMMENT	     "      *MVS PORT-- BEGIN UNIX"

#define END_COMMENT	     "      *MVS PORT-- END UNIX"

#define BEGIN_ORACLE_UNCOMMENT  "      *ORACLE PORT-- BEGIN MODE ORACLE"

#define END_ORACLE_UNCOMMENT "      *ORACLE PORT-- END MODE ORACLE"

#define BEGIN_ORACLE_COMMENT "      *ORACLE PORT-- BEGIN MODE ANSI"

#define END_ORACLE_COMMENT   "      *ORACLE PORT-- END MODE ANSI"

#define COMMENT_CHAR         *

#define WORKING_DIRECTORY    "/css/devtools/common/host/working"

#define WORKING_DIRECTORY_LEN 200

#define DIRECTORY_MARK        "/"

#define COMMENT_LEN           6

#define COMMENT_LINE          1

#define NON_COMMENT_LINE      2

/**************************************************************/
/*                                                            */
/*   GLOBAL VARIABLES                                         */
/*                                                            */
/**************************************************************/

FILE *fpcoin;
FILE *fpcout;
FILE *fpcnew;
char *newfile;
char OracleFlag[FILE_LEN];
char MVSClientFlag[FILE_LEN];
int line_count = 0;
int tab_count  = 0;
int compute_sw = 0;
int perform_sw = 0;
int within_SQL = 0;
int processed  = 0;
int comment_flag = 0;
int uncomment_flag = 0;
int RENAME_FLAG = 0;
size_t TIME_LEN =      10;

/**************************************************************/
/*                                                            */
/*   PROTOTYPES                                               */
/*                                                            */
/**************************************************************/

void open_files(char *FileName);
char *alloc_mem(void);
void convert_source_computer(char *linestring);
void convert_object_computer(char *linestring);
void convert_external(char *linestring);
void fix_quote(char *linestring, char *linestring2);
void scan_exec(char *linestring, char *linestring2);
void close_files(void);
void comment_out_lines(char *linestring);
void comment_out_oracle_lines(char *linestring);
void uncomment_lines(char *linestring);
void uncomment_oracle_lines(char *linestring);
int check_comments(char *linestring);
void get_parameters(char *sProject);
