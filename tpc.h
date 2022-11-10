/*
 * tpc.h
 * definitions for tpcc loading program && transactions
 */

#ifdef __cplusplus
extern "C" {
#endif

/*
 * correct values
 */
extern int max_items;		// 100000
#define CUST_PER_DIST 3000 
extern int dist_per_ware; 	// 10
#define ORD_PER_DIST  3000
/*
 */

/* 
 * small values

#define max_items 	1000
#define CUST_PER_DIST 	30
#define dist_per_ware	3
#define ORD_PER_DIST	30

 */ 

/* definitions for new order transaction */
#define MAX_NUM_ITEMS 15
#define MAX_ITEM_LEN  24

#define swap_int(a,b) {int tmp; tmp=a; a=b; b=tmp;}

/*
 * hack MakeAddress() into a macro so that we can pass Oracle
 * VARCHARs instead of char *s
 */
#define MakeAddressMacro(str1,str2,city,state,zip) \
{int tmp; \
 tmp = MakeAlphaString(10,20,str1.arr); \
 str1.len = tmp; \
 tmp = MakeAlphaString(10,20,str2.arr); \
 str2.len = tmp; \
 tmp = MakeAlphaString(10,20,city.arr); \
 city.len = tmp; \
 tmp = MakeAlphaString(2,2,state.arr); \
 state.len = tmp; \
 tmp = MakeNumberString(9,9,zip.arr); \
 zip.len = tmp;}

/*
 * while we're at it, wrap MakeAlphaString() and MakeNumberString()
 * in a similar way
 */
#define MakeAlphaStringMacro(x,y,str) \
{int tmp; tmp = MakeAlphaString(x,y,str.arr); str.len = tmp;}
#define MakeNumberStringMacro(x,y,str) \
{int tmp; tmp = MakeNumberString(x,y,str.arr); str.len = tmp;}

/*
 * likewise, for Lastname()
 * counts on Lastname() producing null-terminated strings
 */
#define LastnameMacro(num,str) \
{Lastname(num, str.arr); str.len = strlen(str.arr);}

extern long count_ware;
  
/* Functions */
    
void         LoadItems();
void         LoadWare();   
void         LoadCust();
void         LoadOrd();
void         LoadNewOrd();   
int          Stock();
int          District();
void         Customer();
void         Orders();
void         New_Orders();
void         MakeAddress();
void         Error();

#ifdef __STDC__
void SetSeed (int seed);
int RandomNumber (int min, int max);
int NURand (unsigned A, unsigned x, unsigned y);
int MakeAlphaString (int x, int y, char str[]);
int MakeNumberString (int x, int y, char str[]);
void gettimestamp (char str[], char *format, size_t n);
void InitPermutation (void);
int GetPermutation (void);
void Lastname(int num, char* name);

#endif /* __STDC__ */
    
#ifdef __cplusplus
}
#endif
