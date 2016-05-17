#include "mex.h"
#include <stdlib.h>

int cmpfunc (const void * a, const void * b)
{
   return ( *(int*)a - *(int*)b );
}

void indFind(bool *maskVec, size_t n, int *m, int *ind)
{
  size_t i = 0;
  int cntr = 0;
  while ((cntr < m[0]) && (i < n)){
    if (maskVec[i])
      cntr++;
    i++;
  }
  if (cntr < m[0])
    ind[0] = 0;
  else
    ind[0] = i;
}

void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
  //bool *maskVec;
  int *rankVec,*newRankVec;
  double rankPen,eqPen,shiftPen,*newRankPen;
  double *lossMat;
  size_t n,i;
  
  if(nrhs!=5) 
    mexErrMsgIdAndTxt( "MATLAB:insertion:invalidNumInputs",
            "Five inputs required.");
  if(nlhs!=2) 
    mexErrMsgIdAndTxt( "MATLAB:insertion:invalidNumOutputs",
            "Two output required.");
////////////////////////////
  n = mxGetM(prhs[0]);
  //mexPrintf("Length: %i\n", n);
  
  if( !mxIsClass(prhs[0],"int32") || mxIsComplex(prhs[0]) ||
      mxGetM(prhs[0])!=n || mxGetN(prhs[0])!=1 ) {
    mexErrMsgIdAndTxt( "MATLAB:insertion:rankVecNotColumn",
            "Input rankVec must be a integer column.");
  }
  
  if( !mxIsNumeric(prhs[1]) || mxIsComplex(prhs[1]) ||
      mxGetNumberOfElements(prhs[1]) != 1 ) {
    mexErrMsgIdAndTxt( "MATLAB:insertion:rankPenNotScalar",
            "Input rankPen must be a numeric scalar.");
  }
  
  if( !mxIsDouble(prhs[2]) || mxIsComplex(prhs[2]) ||
      mxGetN(prhs[2])!=n || mxGetM(prhs[2])!=n ) {
    mexErrMsgIdAndTxt( "MATLAB:insertion:lossMatNotSqMatrix",
            "Input lossMat must be a square matrix.");
  }
  
  if( !mxIsNumeric(prhs[3]) || mxIsComplex(prhs[3]) ||
      mxGetNumberOfElements(prhs[3]) != 1 ) {
    mexErrMsgIdAndTxt( "MATLAB:insertion:eqPenNotScalar",
            "Input eqPen must be a numeric scalar.");
  }
  if( !mxIsNumeric(prhs[4]) || mxIsComplex(prhs[4]) ||
      mxGetNumberOfElements(prhs[4]) != 1 ) {
    mexErrMsgIdAndTxt( "MATLAB:insertion:shiftPenNotScalar",
            "Input shiftPen must be a numeric scalar.");
  }
  ////
  rankVec = (int *)mxGetData(prhs[0]);
  rankPen = mxGetScalar(prhs[1]);
  lossMat = mxGetPr(prhs[2]);
  eqPen = mxGetScalar(prhs[3]);
  shiftPen = mxGetScalar(prhs[4]);
  
  ////
  plhs[0] = mxCreateNumericMatrix((mwSize)n, 1, mxINT32_CLASS, mxREAL);
  plhs[1] = mxCreateDoubleMatrix(1, 1, mxREAL);
  
  //mexPrintf("Length: %i\n", mxGetNumberOfElements(plhs[0]));
  
  newRankVec = (int *)mxGetData(plhs[0]);
  newRankPen = mxGetPr(plhs[1]);
  ////
  for (i=0; i<n; i++) {
    *(newRankVec+i) = *(rankVec+i);
  }
  //
  qsort(newRankVec, n / 2, 2*sizeof(int), cmpfunc);
  //
  *newRankPen = rankPen;
}