#include "mex.h"
#include "math.h"

bool cmp(int* a, int* b, int length, int side);
int max(int a, int b);
int getLineValue(int* line);
int getLaziValue(int a[20][20],int size,int x,int y);
int getAILazi(int a[20][20],int size,int side,int dep,int & x,int & y );
int maxIndex(int *line,int length);
int minIndex(int *line,int length);
int maxLine[500];
int maxIndexNum=0;
int five[5]={1,1,1,1,1};
int fourl[6]={0,1,1,1,1,0};
int fourd1[5]={0,1,1,1,1};
int fourd2[5]={1,1,1,1,0};
int threel1[6]={0,0,1,1,1,0};
int threel2[6]={0,1,1,1,0,0};
int threel3[5]={0,1,1,1,0};
int threed1[5]={1,1,1,0,0};
int threed2[5]={0,0,1,1,1};
int twol1[5]={0,1,1,0,0};
int twol2[5]={0,0,1,1,0};
int twol3[4]={0,1,1,0};
int twod1[3]={0,1,1};
int twod2[3]={1,1,0};
int lineValue[20];

void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])
{
    int size,side,dep,value,x,y;
    size=int(*(mxGetPr(prhs[1])));
    side=int(*(mxGetPr(prhs[2])));
    dep=int(*(mxGetPr(prhs[3])));
    double *a,*c;
    int a1[20][20];
    a = mxGetPr(prhs[0]);
    plhs[0]=mxCreateDoubleMatrix(500,1,mxREAL);
    c= mxGetPr(plhs[0]);
    for(int i=0;i<size;i++)
    {
        for(int j=0;j<size;j++)
        {
            a1[i][j]=int(a[i+j*20]);
        }
    }
    for(int i=0;i<9;i++)
    {
        lineValue[i]=int(a[400+i]);
    }
    value=getAILazi(a1,size,side,dep,x,y);
    a1[x][y]=side;
    for(int i=0;i<size;i++)
    {
        for(int j=0;j<size;j++)
        {
            c[i+j*20]=double(a1[i][j]);
        }
    }
    c[399]=value;
    return ;
}

int getAILazi(int a[20][20],int size,int side,int dep,int & x,int & y )
{
    int count=0,count1=0;int index;
    int threshold=0;
    int laziX[400],laziY[400],value0[400],value1[400],value2[400];
    if (dep==1)
    {
        for(int i=0;i<size;i++)
        {
            for(int j=0;j<size;j++)
            {
                if(a[i][j]!=0) continue;
                laziX[count]=i;laziY[count]=j;
                a[i][j]=side;
                value1[count]=getLaziValue(a,size,i,j);
                a[i][j]=side % 2+1;
                value0[count]=value1[count]+(getLaziValue(a,size,i,j)*7)/10;
                a[i][j]=0;count++;
            }
        }
        if(count==0) return 0;
        index=maxIndex(value0,count);
        x=laziX[index];y=laziY[index];
        return value1[index];
    }
    
    for (int i=0;i<size;i++)
    {
        for(int j=0;j<size;j++)
        {
            if(a[i][j]!=0) continue;
            laziX[count]=i;laziY[count]=j;
            a[i][j]=side;
            value1[count]=getLaziValue(a,size,i,j);
            a[i][j]=side % 2+1;
            value0[count]=value1[count]+(getLaziValue(a,size,i,j)*10/10);
            a[i][j]=side;
            value0[count]=value0[count]-(getAILazi(a,size,side % 2+1,1,x,y)*7)/10;
            a[i][j]=0;
            count++;
        }
    }
if(count==0) return 0;
if(value1[maxIndex(value1,count)]>=lineValue[2])
{
    index=maxIndex(value1,count);
    x=laziX[index];y=laziY[index];
    return value1[index];
}
threshold=(2*value0[maxIndex(value0,count)]+value0[minIndex(value0,count)])/3;
for(int i=0;i<count;i++)
{
    if (value0[i]<threshold) continue;
    laziX[count1]=laziX[i];laziY[count1]=laziY[i];
    a[laziX[count1]][laziY[count1]]=side;
    value1[count1]=value1[i]-(getAILazi(a,size,side%2+1,dep-1,x,y)*7)/10;
    a[laziX[count1]][laziY[count1]]=0;
    count1++;
}
    index=maxIndex(value1,count1);
    x=laziX[index];y=laziY[index];
    return value1[index];
}

int getLaziValue(int a[][20],int size,int x,int y)
{
    int side=a[x][y];
    int line[9];
    int value=0;
    for(int i=0;i<9;i++)
    {
        if(x+i-4>=0 & x+i-4<size)line[i]=a[x+i-4][y];
        else line[i]=-1;
    }
    value=value+getLineValue(line);
    
    for(int i=0;i<9;i++)
    {
        if(y+i-4>=0 & y+i-4<size)line[i]=a[x][y+i-4];
        else line[i]=-1;
    }
    value=value+getLineValue(line);
    
    
    for(int i=0;i<9;i++)
    {
        if(x+i-4>=0 & x+i-4<size & y+i-4>=0 & y+i-4<size)line[i]=a[x+i-4][y+i-4];
        else line[i]=-1;
    }
    value=value+getLineValue(line);
    
    for(int i=0;i<9;i++)
    {
        if(x+i-4>=0 & x+i-4<size & y-i+4>=0 & y-i+4<size) line[i]=a[x+i-4][y-i+4];
        else line[i]=-1;
    }
    value=value+getLineValue(line);
    
    return value;
}

int getLineValue( int *line )
{
    
    int side=0,value=0; 
    side=line[4];
    for(int i=0;i<9;i++)
    {
        if (i<4)
        {
            if(cmp(line+i,fourl,6,side)){value=max(value,lineValue[0]);}
            if(cmp(line+i,threel1,6,side)|cmp(line+i,threel2,6,side)){value=max(value,lineValue[1]);}
        }
        if (i<5)
        {
            if(cmp(line+i,five,5,side)){value=max(value,lineValue[2]);}
            if(cmp(line+i,fourd1,5,side)|cmp(line+i,fourd2,5,side)){value=max(value,lineValue[3]);}
            if(cmp(line+i,threel3,5,side)){value=max(value,lineValue[4]);}
            if(cmp(line+i,threed1,5,side)|cmp(line+i,threed2,5,side)){value=max(value,lineValue[5]);}
            if(cmp(line+i,twol1,5,side)|cmp(line+i,twol2,5,side)){value=max(value,lineValue[6]);}
        }
        if (i<6)
        {
            if(cmp(line+i,twol3,4,side)){value=max(value,lineValue[7]);}
        }
        if (i<7)
        {
            if(cmp(line+i,twod1,3,side)|cmp(line+i,twod2,3,side)){value=max(value,lineValue[8]);}
        }
    }
    return value;
}

bool cmp(int* a, int* b, int length,int side)
{
    for(int i=0;i<length;i++)
    {
        if (*(a+i)!=(*(b+i))*side) return 0;
    }
    return 1;
    
}
 int max(int a, int b)
{
    if (a>b)
    {
        return a;
    }
    else
    {
        return b;
    }
}
int maxIndex(int *line,int length)
{
    int index=0;maxLine[0]=index;maxIndexNum=1;
    for(int i=1;i<length;i++)
    {
        if(*(line+i)>*(line+index))
        {
                index=i;
                maxIndexNum=1;
                maxLine[0]=index;
        }
        if(*(line+i)==*(line+index))
        {
            maxLine[maxIndexNum]=index;
            maxIndexNum++;
        }
    }
    return maxLine[rand()%maxIndexNum];
}
int minIndex(int *line,int length)
{
    int index=0;
    for(int i=0;i<length;i++)
    {
        if(*(line+i)<*(line+index))index=i;
    }
    return index;
}