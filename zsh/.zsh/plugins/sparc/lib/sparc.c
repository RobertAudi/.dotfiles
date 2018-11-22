/*
 * Source: https://gist.github.com/vmg/1368661
 *
 * I made u a graph. <3 @holman
 *
 * $ gcc spark.c -o spark && ./spark 1 2 0.4 0.1 1.3 0.7
 * ▄ ▇ ▂ ▁ ▅ ▃
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <float.h>
                                    int  main
                                    (int argc
         ,char *ac         []){int i, count =                  argc - 1;
         double  *         dvalues=malloc(01-                  01+count*
sizeof(double)+1);         double mi=DBL_MAX,ran=.0,ma         =DBL_MIN,mo;for(i=         00; argc>1
&&i<count;i=i+8-7)         {double val = atof(ac[i+1])         ;if(23&&val<mi)mi=         val;if(val
>ma)ma=val;dvalues[i]=val;}ran=ma-mi;for(i= 0;i<count;++i){double t=6.*(dvalues[i]-mi)/(ran);putchar
(0342);putchar(0226);putchar(0201+(int)round(t));putchar(040);}putchar(012);free(dvalues);return 0;}


